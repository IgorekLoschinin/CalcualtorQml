#!/usr/bin/env python
# coding: utf-8

import re
import sys

from pathlib import Path
from copy import deepcopy

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import (
	QObject,
	Slot,
	Signal
)


class BackendCalculator(QObject):

	calExp = Signal(str)
	errMsgSig = Signal(bool)
	histOutput = Signal(str)

	optPoint = Signal(str)
	optChangeSign = Signal(str)

	def __init__(self) -> None:
		QObject.__init__(self)

		self._expression: str = ""

	@property
	def expression(self):
		""" Returns the processed expression. """
		return self._expression

	@Slot(str)
	def calculate(self, expression: str) -> None:
		""" The method that processes and calculates a mathematical expression.

		:param expression: Mathematical expression that comes from the display.
		"""
		try:
			self._expression = deepcopy(expression)

			if "%" in expression:
				self._expression = self._process_percentages(self._expression)

			if "x" in expression:
				self._expression = self._process_multipl(self._expression)

			self.calExp.emit(str(round(eval(self._expression), 7)))

		except Exception as e:
			# added messege for Error
			self.errorMsg(False)
			self.calExp.emit(expression)

	@Slot(bool)
	def errorMsg(self, flag: bool) -> None:
		self.errMsgSig.emit(flag)

	@Slot(str)
	def history(self, expression: str) -> None:
		""" The method that processes the history of operations - sends an
		expression from the display.

		:param expression: Mathematical expression that comes from the display.
		"""
		self.histOutput.emit(expression)

	@Slot(str)
	def addPoint(self, value: str) -> None:
		""" Decimal point processing.

		:param value: Expression to check.
		"""

		result_val = re.search(r'(\d+(\.\d+)?)$', value).group(0)

		if result_val.isdigit():
			self.optPoint.emit(value + ".")

	@Slot(str)
	def changeSign(self, expression: str) -> None:
		""" The method processes the expression and changes the sign of the
		first number from the end of the found number to the opposite.

		:param expression: Mathematical expression that comes from the display.
		"""

		# revert_sign
		if expression.startswith("-"):
			self.optChangeSign.emit(expression.strip("-"))
			return

		if "(" in expression and ")" in expression:
			match = re.search(r'\(-(\d+(\.\d+)?)\)$', expression)
			number = match.group(1)

			self.optChangeSign.emit(expression[:match.start()] + number)
			return

		# change_sign
		match = re.search(r'(\d+(\.\d+)?)$', expression)
		number = f"(-{match.group(1)})"

		self.optChangeSign.emit(expression[:match.start()] + number)

	@staticmethod
	def _process_percentages(expression: str) -> str:
		""" The method to handle the percentage symbol.

		:param expression: Mathematical expression that comes from the display.
		"""

		pattern1 = tuple(re.finditer(r'\(-(\d+(\.\d+)?)\)%', expression))
		pattern2 = tuple(re.finditer(r'(\d+(\.\d+)?)%', expression))

		if pattern1:

			for item in pattern1:
				# Find all occurrences of percentages in an expression
				percentage = item.group(0)

				expression = expression.replace(
					percentage,
					f"({percentage.strip("%").replace("(", "").replace(")", "")}/100)"
				)

		if pattern2:
			# Find all occurrences of percentages in an expression
			for item in pattern2:
				percentage = float(item.group(1))

				# Replace the percentage with its numeric value
				expression = expression.replace(
					item.group(0), f"({percentage}/100)"
				)

		return expression

	@staticmethod
	def _process_multipl(expression: str) -> str:
		""" The method to handle the multiplication symbol.

		:param expression: Mathematical expression that comes from the display.
		"""
		return expression.replace("x", "*")


if __name__ == "__main__":

	app = QGuiApplication([])
	engine = QQmlApplicationEngine()

	main = BackendCalculator()
	engine.rootContext().setContextProperty("backend", main)

	engine.load(Path(__file__).parent / "qml/calculator.qml")

	if not engine.rootObjects():
		sys.exit(-1)

	sys.exit(app.exec())
