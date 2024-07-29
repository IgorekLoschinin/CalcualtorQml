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
			print(e)
			self.calExp.emit(expression)

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

		# Using a regular expression to find the last number or expression
		# in parentheses
		match = re.search(r'([-]?)(\(?-?\d+(\.\d+)?\)?)$', expression)

		num = match.group(0)
		num1 = match.group(1)
		num2 = match.group(2)

		# If the number is already in parentheses, extract it and
		# change the sign
		if num.startswith('(') and num.endswith(')'):
			num_inside = num[1:-1]
			if num_inside.startswith('-'):
				num_inside = num_inside[1:]
			else:
				num_inside = '-' + num_inside
			self.optChangeSign.emit(
				expression[:match.start()] + f"{num_inside}"
			)
			return

		# Otherwise, we wrap the number in brackets and change the
		# sign
		if num.startswith('-'):
			self.optChangeSign.emit(
				expression[:match.start()] + f"{num[1:]}"
			)
			return

		self.optChangeSign.emit(
			expression[:match.start()] + f"(-{num})"
		)
		return

	@staticmethod
	def _process_percentages(expression: str) -> str:
		""" The method to handle the percentage symbol.

		:param expression: Mathematical expression that comes from the display.
		"""

		# Find all occurrences of percentages in an expression
		matches = re.finditer(r'(\d+(\.\d+)?)%', expression)
		for match in matches:
			percentage = float(match.group(1))

			# Replace the percentage with its numeric value
			expression = expression.replace(
				match.group(0), f"({percentage}/100)"
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
