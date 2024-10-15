// import 'package:get/get.dart';
//
// class CalculatorController extends GetxController {
//   // Reactive variables to hold the display value and input
//   var display = '0'.obs;
//   var firstNumber = ''.obs;
//   var secondNumber = ''.obs;
//   var operation = ''.obs;
//
//   // Function to handle number input
//   void inputNumber(String num) {
//     if (operation.isEmpty) {
//       firstNumber.value += num;
//       display.value = firstNumber.value;
//     } else {
//       secondNumber.value += num;
//       display.value = secondNumber.value;
//     }
//   }
//
//   // Function to handle operation input (+, -, *, /)
//   void inputOperation(String oper) {
//     if (firstNumber.isNotEmpty) {
//       operation.value = oper;
//       display.value = oper;
//     }
//   }
//
//   // Function to perform calculation
//   void calculateResult() {
//     if (firstNumber.isNotEmpty && secondNumber.isNotEmpty && operation.isNotEmpty) {
//       double num1 = double.parse(firstNumber.value);
//       double num2 = double.parse(secondNumber.value);
//       double result;
//
//       switch (operation.value) {
//         case '+':
//           result = num1 + num2;
//           break;
//         case '-':
//           result = num1 - num2;
//           break;
//         case '*':
//           result = num1 * num2;
//           break;
//         case '/':
//           result = num2 != 0 ? num1 / num2 : 0; // Avoid division by zero
//           break;
//         default:
//           result = 0;
//       }
//
//       display.value = result.toString();
//       // Clear after calculation
//       firstNumber.value = '';
//       secondNumber.value = '';
//       operation.value = '';
//     }
//   }
//
//   // Function to clear the calculator
//   void clear() {
//     firstNumber.value = '';
//     secondNumber.value = '';
//     operation.value = '';
//     display.value = '0';
//   }
// }
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  var display = '0'.obs;
  var firstNumber = ''.obs;
  var secondNumber = ''.obs;
  var operation = ''.obs;

  // Handle button presses in the controller (centralized logic)
  void handleInput(String input) {
    if (input == 'C') {
      clear();
    } else if (input == '=') {
      calculateResult();
    } else if (_isOperator(input)) {
      inputOperation(input);
    } else {
      inputNumber(input);
    }
  }

  // Input numbers
  void inputNumber(String num) {
    if (operation.isEmpty) {
      firstNumber.value += num;
      display.value = _formatDisplay(firstNumber.value);
    } else {
      secondNumber.value += num;
      display.value = _formatDisplay(secondNumber.value);
    }
  }

  // Input operations
  void inputOperation(String oper) {
    if (firstNumber.isNotEmpty) {
      operation.value = oper;
      display.value = oper;  // Temporarily show the operation
    }
  }

  // Calculate the result
  void calculateResult() {
    if (firstNumber.isNotEmpty && secondNumber.isNotEmpty && operation.isNotEmpty) {
      double num1 = double.tryParse(firstNumber.value) ?? 0;
      double num2 = double.tryParse(secondNumber.value) ?? 0;
      double result;

      try {
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
            result = num2 != 0 ? num1 / num2 : double.nan;  // Handle division by zero
            break;
          default:
            result = 0;
        }

        // Display result and reset inputs
        display.value = _formatDisplay(result.toString());
        _clearInput();
      } catch (e) {
        display.value = 'Error';
        _clearInput();
      }
    }
  }

  // Clear all inputs
  void clear() {
    _clearInput();
    display.value = '0';
  }

  // Helper to reset the inputs after a calculation
  void _clearInput() {
    firstNumber.value = '';
    secondNumber.value = '';
    operation.value = '';
  }

  // Check if the input is an operator
  bool _isOperator(String input) {
    return ['+', '-', '*', '/'].contains(input);
  }


  String _formatDisplay(String value) {
    if (value.contains('.')) {
      value = double.parse(value).toStringAsFixed(6);  // Display up to 6 decimal places
    }
    return value.replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');  // Remove trailing zeros
  }
}
