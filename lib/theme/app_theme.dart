// import 'package:flutter/material.dart';
// import '../config/app_config.dart';

// class AppTheme {
//   static ThemeData lightTheme(AppConfiguration config) {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.light,
//       primaryColor: config.primaryColor,
//       scaffoldBackgroundColor: config.backgroundColor,
//       colorScheme: ColorScheme.light(
//         primary: config.primaryColor,
//         secondary: config.secondaryColor,
//       ),
//       textTheme: TextTheme(
//         displayLarge: TextStyle(
//           fontSize: config.typography.h1,
//           color: Colors.black87,
//         ),
//         bodyMedium: TextStyle(
//           fontSize: config.typography.body,
//           color: Colors.black87,
//         ),
//         labelLarge: TextStyle(
//           fontSize: config.typography.button,
//           color: Colors.white,
//         ),
//       ),
//       appBarTheme: AppBarTheme(
//         backgroundColor: config.primaryColor,
//         foregroundColor: Colors.white,
//       ),
//       elevatedButtonTheme: ElevatedButtonThemeData(
//         style: ElevatedButton.styleFrom(
//           backgroundColor: config.primaryColor,
//           foregroundColor: Colors.white,
//           textStyle: TextStyle(
//             fontSize: config.typography.button,
//           ),
//           padding: EdgeInsets.symmetric(
//             horizontal: config.spacing.medium,
//             vertical: config.spacing.small,
//           ),
//         ),
//       ),
//     );
//   }

//   static ThemeData darkTheme(AppConfiguration config) {
//     return ThemeData(
//       useMaterial3: true,
//       brightness: Brightness.dark,
//       primaryColor: config.primaryColor,
//       scaffoldBackgroundColor: Colors.grey[900],
//       colorScheme: ColorScheme.dark(
//         primary: config.primaryColor,
//         secondary: config.secondaryColor,
//       ),
//       textTheme: TextTheme(
//         displayLarge: TextStyle(
//           fontSize: config.typography.h1,
//           color: Colors.white,
//         ),
//         bodyMedium: TextStyle(
//           fontSize: config.typography.body,
//           color: Colors.white70,
//         ),
//         labelLarge: TextStyle(
//           fontSize: config.typography.button,
//           color: Colors.white,
//         ),
//       ),
//       appBarTheme: AppBarTheme(
//         backgroundColor: Colors.grey[900],
//         foregroundColor: Colors.white,
//       ),
//     );
//   }
// }