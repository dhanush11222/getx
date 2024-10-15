//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'calculator_controller.dart';
//
//
// void main() {
//   runApp(CalculatorApp());
// }
//
// class CalculatorApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//
//     return GetMaterialApp(
//
//       debugShowCheckedModeBanner: false,
//       home: CalculatorScreen(),
//     );
//   }
// }
//
// class CalculatorScreen extends StatelessWidget {
//   final CalculatorController controller = Get.put(CalculatorController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//
//         backgroundColor: Colors.black,
//         title: Text(
//           'Calculator',
//           style: TextStyle(color: Colors.white, fontSize: 24),
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           // Display screen
//           Obx(() => Container(
//             padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
//             alignment: Alignment.centerRight,
//             child: Text(
//               controller.display.value,
//               style: TextStyle(
//                 fontSize: 52,
//                 color: Colors.white,
//                 fontWeight: FontWeight.w300,
//               ),
//             ),
//           )),
//           SizedBox(height: 24),
//           // Buttons
//           _buildButtons(),
//         ],
//       ),
//     );
//   }
//
//   // Create calculator buttons with circular shape and color differentiation
//   Widget _buildButtons() {
//     return Column(
//       children: [
//         _buildButtonRow(['7', '8', '9', '/'], operator: true),
//         _buildButtonRow(['4', '5', '6', '*'], operator: true),
//         _buildButtonRow(['1', '2', '3', '-'], operator: true),
//         _buildButtonRow(['C', '0', '=', '+'], operator: false),
//       ],
//     );
//   }
//
//   // Helper to create a row of buttons with styling
//   Widget _buildButtonRow(List<String> buttons, {bool operator = false}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: buttons.map((btn) {
//         return _buildButton(btn, operator: ['/', '*', '-', '+', '='].contains(btn));
//       }).toList(),
//     );
//   }
//
//   // Create a single button with custom styling
//   Widget _buildButton(String text, {bool operator = false}) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SizedBox(
//         width: 50,
//         height: 80,
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: operator ? Colors.orange : Colors.grey[850], // Colors for operators and numbers
//             shape: CircleBorder(),
//             padding: EdgeInsets.all(20),
//           ),
//           onPressed: () {
//             _handleButtonPress(text);
//           },
//           child: Text(
//             text,
//             style: TextStyle(
//               fontSize: 20,
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Handle button presses
//   void _handleButtonPress(String value) {
//     if (value == 'C') {
//       controller.clear();
//     } else if (value == '=') {
//       controller.calculateResult();
//     } else if (['+', '-', '*', '/'].contains(value)) {
//       controller.inputOperation(value);
//     } else {
//       controller.inputNumber(value);
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'calculator_controller.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        hintColor: Colors.orange,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatelessWidget {
  final CalculatorController controller = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Calculator',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildDisplay(),
          SizedBox(height: 24),
          _buildButtons(),
        ],
      ),
    );
  }

  // Display widget wrapped in Obx for reactive updates
  Widget _buildDisplay() {
    return Obx(() => Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      alignment: Alignment.centerRight,
      child: Text(
        controller.display.value,
        style: TextStyle(
          fontSize: controller.display.value.length > 8 ? 36 : 52, // Dynamic font size
          color: Colors.white,
          fontWeight: FontWeight.w300,
        ),
      ),
    ));
  }

  // Button grid layout
  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          _buildButtonRow(['7', '8', '9', '/']),
          _buildButtonRow(['4', '5', '6', '*']),
          _buildButtonRow(['1', '2', '3', '-']),
          _buildButtonRow(['C', '0', '=', '+']),
        ],
      ),
    );
  }

  // Build a row of buttons
  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((btn) {
        return _buildButton(btn, isOperator: ['/', '*', '-', '+', '='].contains(btn));
      }).toList(),
    );
  }

  // Build individual button with responsive styling
  Widget _buildButton(String text, {bool isOperator = false}) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isOperator ? Colors.orange : Colors.grey[850],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: () => controller.handleInput(text),  // Call the controller directly for handling input
          child: Text(
            text,
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
