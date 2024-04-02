import 'package:flutter/material.dart';
import 'package:nombre_mystere/database_helper/databaseHelper.dart';
import 'router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    DatabaseHelper.getDatabase();

    return MaterialApp.router(
      title: 'Application - Nombre mystère',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
      ),
      routerConfig: AppRouter().router,
    );
  }
}
