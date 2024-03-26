import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nombre_mystere/notifier/loginnotifier.dart';
import 'package:nombre_mystere/ui/preamescreen.dart';
import 'package:nombre_mystere/ui/playgame.dart';
import 'package:nombre_mystere/ui/homescreen.dart';
import 'package:nombre_mystere/ui/login.dart';
import 'package:nombre_mystere/ui/rules.dart';
import 'package:nombre_mystere/ui/viewscores.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final LoginInfo loginInfo;

  AppRouter({required this.loginInfo});

  get router => _router;

  late final _router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/home',
      refreshListenable: loginInfo,
      redirect: (context, state) {
        final bool loggedInfo = loginInfo.logged;
        if(!loggedInfo) {
          return '/sign-in';
        }
        return null; // signifie la route par défaut que l'on a demandé
      },
      routes: <RouteBase>[
        GoRoute(
            path: '/',
            redirect: (context, state) {
              return '/home';
            }
        ),
        GoRoute(
            path: '/sign-in',
            builder: (context, state) {
              return const LoginScreen();
            }
        ),
        GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
            routes: <RouteBase>[
              GoRoute(
                  path: 'pre-game',
                  builder: (context, state) => const PreGamePage(),
                  routes: <RouteBase>[
                    GoRoute(
                      path: 'play-game',
                      builder: (context, state) {
                        final int niveau = int.parse(state.uri.queryParameters['niveau']!);
                        final String? nom = state.uri.queryParameters['player'];
                        return GamePage(niveau: niveau, player: '$nom');
                      }
                    ),
                  ]
              ),
              GoRoute(
                  path: 'view-scores',
                  builder: (context, state) {
                    return const ViewScores();
                  }
              ),
              GoRoute(
                  path: 'info',
                  builder: (context, state) {
                    return const RulesPage();
                  }
              ),
            ]
        ),
        // GoRoute(
        //   path: '/details/:id',
        //   name: 'details-on-id',
        //   builder: (context, state) {
        //     final id = state.pathParameters["id"];
        //     return DetailScreen(id: int.parse(id!));
        //   },
        // ),
        // GoRoute(
        //   path: '/details',
        //   name: 'details',
        //   builder: (context, state) {
        //     final id = state.uri.queryParameters['search'];
        //     return DetailScreen(id: int.parse(id!));
        //   },
        // ),
      ]
  );
}