import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:nombre_mystere/notifier/loginnotifier.dart';
import 'router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
            ChangeNotifierProvider(
              create: (context) => LoginInfo()
            ),
            ProxyProvider<LoginInfo, AppRouter>(
                update: (context, login, _) => AppRouter(loginInfo: login)
            ),
        ],
        child: Builder(
              builder: ((context) {
                final GoRouter router = Provider.of<AppRouter>(context).router;
                return MaterialApp.router(
                  title: 'Application - Nombre mystère',
                  theme: ThemeData(
                    colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),

                  ),
                  routerConfig: AppRouter(loginInfo: Provider.of<LoginInfo>(context)).router,
                );
              }
            ),
          ),
    );
  }
}