import 'package:get/get.dart';

class CalculatorController extends GetxController {
  // Reactive variables to hold the display value and input
  var display = '0'.obs;
  var firstNumber = ''.obs;
  var secondNumber = ''.obs;
  var operation = ''.obs;

  // Function to handle number input
  void inputNumber(String num) {
    if (operation.isEmpty) {
      firstNumber.value += num;
      display.value = firstNumber.value;
    } else {
      secondNumber.value += num;
      display.value = secondNumber.value;
    }
  }

  // Function to handle operation input (+, -, *, /)
  void inputOperation(String oper) {
    if (firstNumber.isNotEmpty) {
      operation.value = oper;
      display.value = oper;
    }
  }

  // Function to perform calculation
  void calculateResult() {
    if (firstNumber.isNotEmpty && secondNumber.isNotEmpty && operation.isNotEmpty) {
      double num1 = double.parse(firstNumber.value);
      double num2 = double.parse(secondNumber.value);
      double result;

      switch (operation.value) {
        case '+':
          result = num1 + num2;
          break;
        case '-':
          result = num1 - num2;
          break;
        case '*':
          result = num1 * num2;
          break;
        case '/':
          result = num2 != 0 ? num1 / num2 : 0; // Avoid division by zero
          break;
        default:
          result = 0;
      }

      display.value = result.toString();
      // Clear after calculation
      firstNumber.value = '';
      secondNumber.value = '';
      operation.value = '';
    }
  }

  // Function to clear the calculator
  void clear() {
    firstNumber.value = '';
    secondNumber.value = '';
    operation.value = '';
    display.value = '0';
  }
}
