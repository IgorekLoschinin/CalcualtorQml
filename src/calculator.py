#!/usr/bin/env python
# coding: utf-8

import re
import sys

from pathlib import Path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import (
	QObject,
	Slot,
	Signal
)


class BackendCalculator(QObject):

	calExp = Signal(str)
	optChangeSign = Signal(str)
	histOutput = Signal(str)

	def __init__(self) -> None:
		QObject.__init__(self)

	@Slot(str)
	def history(self, expression: str) -> None:
		self.histOutput.emit(expression)

	@Slot(str)
	def calculate(self, expression: str) -> None:
		try:
			if "%" in expression:
				self.calExp.emit(
					str(eval(self.process_percentages(expression)))
				)
				return

			self.calExp.emit(str(eval(expression)))

		except Exception as e:
			print(e)
			self.calExp.emit(expression)

	@staticmethod
	def process_percentages(expression: str) -> str:
		# Find all occurrences of percentages in an expression
		matches = re.finditer(r'(\d+(\.\d+)?)%', expression)
		for match in matches:
			percentage = float(match.group(1))
			# Replace the percentage with its numeric value
			expression = expression.replace(match.group(0), f"({percentage}/100)")

		return expression

	@Slot(str)
	def changeSign(self, expression: str) -> None:

		if expression:
			# Using a regular expression to find the last number or expression
			# in parentheses
			match = re.search(r'(\(?-?\d+(\.\d+)?\)?)$', expression)
			if match:
				num = match.group(0)

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
				else:
					# Иначе оборачиваем число в скобки и меняем знак
					if num.startswith('-'):
						self.optChangeSign.emit(
							expression[:match.start()] + f"({num[1:]})"
						)
					else:
						self.optChangeSign.emit(
							expression[:match.start()] + f"(-{num})"
						)


if __name__ == "__main__":

	app = QGuiApplication([])
	engine = QQmlApplicationEngine()

	main = BackendCalculator()
	engine.rootContext().setContextProperty("backend", main)

	engine.load(Path(__file__).parent / "qml/calculator.qml")

	if not engine.rootObjects():
		sys.exit(-1)

	sys.exit(app.exec())
