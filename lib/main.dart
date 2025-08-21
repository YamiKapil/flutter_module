import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_ui_module/product/view/product_list_screen.dart';

import 'config/app_config.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String uuid = "";
  late AppConfig config;

  @override
  void initState() {
    super.initState();
    config = AppConfig.defaultConfig();
    _loadInitialData();
  }

  /// loading the app configuration
  Future<void> _loadInitialData() async {
    const channel = MethodChannel('com.example.androidlogin/config');
    try {
      final data = Map<String, dynamic>.from(
        await channel.invokeMethod('getInitialData'),
      );
      final fetchedUuid = data['uuid'] ?? '';
      final configJson = data['appConfigJson'] ?? '{}';
      final fetchedConfig = AppConfig.fromMap(jsonDecode(configJson));

      setState(() {
        uuid = fetchedUuid;
        config = fetchedConfig;
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to get initial data: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (uuid.isEmpty) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: config.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: config.primaryColor,
        scaffoldBackgroundColor: config.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: config.primaryColor,
          surface: config.backgroundColor,
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: config.primaryColor,
            surface: config.backgroundColor,
          ),
        ),
        // appBarTheme: AppBarTheme(
        //   backgroundColor: config.backgroundColor,
        //   color: config.primaryColor,
        // ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: config.typography.bodyLarge.fontSize,
            height: config.typography.bodyLarge.lineHeight /
                config.typography.bodyLarge.fontSize,
            letterSpacing: config.typography.bodyLarge.letterSpacing,
          ),
          titleLarge: TextStyle(
            fontSize: config.typography.titleLarge.fontSize,
            height: config.typography.titleLarge.lineHeight /
                config.typography.titleLarge.fontSize,
            letterSpacing: config.typography.titleLarge.letterSpacing,
          ),
          labelSmall: TextStyle(
            fontSize: config.typography.labelSmall.fontSize,
            height: config.typography.labelSmall.lineHeight /
                config.typography.labelSmall.fontSize,
            letterSpacing: config.typography.labelSmall.letterSpacing,
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: config.primaryColor,
        scaffoldBackgroundColor: config.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: config.primaryColor,
          surface: config.backgroundColor,
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: config.primaryColor,
            surface: config.backgroundColor,
          ),
        ),
        // appBarTheme: AppBarTheme(
        //   backgroundColor: config.backgroundColor,
        //   color: config.primaryColor,
        // ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: config.typography.bodyLarge.fontSize,
            height: config.typography.bodyLarge.lineHeight /
                config.typography.bodyLarge.fontSize,
            letterSpacing: config.typography.bodyLarge.letterSpacing,
          ),
          titleLarge: TextStyle(
            fontSize: config.typography.titleLarge.fontSize,
            height: config.typography.titleLarge.lineHeight /
                config.typography.titleLarge.fontSize,
            letterSpacing: config.typography.titleLarge.letterSpacing,
          ),
          labelSmall: TextStyle(
            fontSize: config.typography.labelSmall.fontSize,
            height: config.typography.labelSmall.lineHeight /
                config.typography.labelSmall.fontSize,
            letterSpacing: config.typography.labelSmall.letterSpacing,
          ),
        ),
      ),
      // home: FlutterLoginScreen(uuid: uuid, config: config),
      home: const ProductListScreen(),
    );
  }
}

class FlutterLoginScreen extends StatelessWidget {
  final String uuid;
  final AppConfig config;
  const FlutterLoginScreen(
      {required this.config, required this.uuid, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(
              uuid.isEmpty ? "Loading..." : "Flutter Login UUID:\n$uuid",
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            Text(config.isDarkTheme.toString()),
          ],
        ),
      ),
    );
  }
}
