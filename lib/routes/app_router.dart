/*
  Gerador de rotas nomeadas (usado em `MaterialApp.onGenerateRoute`).

  - Centraliza o mapeamento entre `AppRoutes` e os widgets correspondentes.
  - Para rotas que aceitam argumentos (ex.: `eventDetails`) espera-se um
    `Map<String, dynamic>` com chaves: 'title', 'description', 'location',
    'speakers'.
  - Pontos de melhoria: adicionar validações de argumento
*/
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'app_routes.dart';
import 'package:campus_guide/components/cards/event_details_card.dart';
import 'package:campus_guide/Features/profile/profile_page.dart';
import 'package:campus_guide/Features/profile/edit_profile_page.dart';
import 'package:campus_guide/Features/events/home_shell.dart';
import 'package:campus_guide/Features/auth/login.dart';
import 'package:campus_guide/Features/auth/register.dart';

class AppRouter {
  /// Gera as rotas usadas pelo `MaterialApp.onGenerateRoute`.
  ///
  /// Recebe `RouteSettings` com `name` e `arguments` e devolve uma
  /// `Route<dynamic>`. Para `AppRoutes.eventDetails` é esperado que
  /// `arguments` seja um `Map<String, dynamic>` contendo as chaves
  /// necessárias para popular `EventDetailsModal`.
  static Route<dynamic> _redirectToLogin(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => const Login());
  }

  static List<Map<String, String>> _speakersFromArgs(dynamic value) {
    if (value is! List) return [];

    return value
        .whereType<Map>()
        .map(
          (speaker) => speaker.map(
            (key, value) => MapEntry(key.toString(), value.toString()),
          ),
        )
        .toList();
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final user = FirebaseAuth.instance.currentUser;

    switch (settings.name) {
      case AppRoutes.home:
        if (user != null) {
          return MaterialPageRoute(builder: (_) => const HomeShell());
        }
        return _redirectToLogin(settings);

      case AppRoutes.profile:
        if (user != null) {
          return MaterialPageRoute(builder: (_) => const ProfilePage());
        }
        return _redirectToLogin(settings);

      case AppRoutes.editProfile:
        if (user != null) {
          return MaterialPageRoute(builder: (_) => const EditProfilePage());
        }
        return _redirectToLogin(settings);

      case AppRoutes.eventDetails:
        if (user != null) {
          final args = settings.arguments as Map<String, dynamic>?;
          // Fallback: se alguém navegar por rota, mostramos os detalhes
          // como uma página completa (embalando o conteúdo do modal).
          return MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(title: const Text('Detalhes do evento')),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: EventDetailsCard(
                  title: args?['title'] ?? '',
                  description: args?['description'] ?? '',
                  location: args?['location'] ?? '',
                  speakers: _speakersFromArgs(args?['speakers']),
                  remainingVacancies: args?['remainingVacancies'] ?? 0,
                  isOpen: args?['isOpen'] ?? false,
                ),
              ),
            ),
          );
        }
        return _redirectToLogin(settings);

      case AppRoutes.login:
        if (user != null) {
          return MaterialPageRoute(builder: (_) => const HomeShell());
        }
        return MaterialPageRoute(builder: (_) => const Login());

      case AppRoutes.register:
        if (user != null) {
          return MaterialPageRoute(builder: (_) => const HomeShell());
        }
        return MaterialPageRoute(builder: (_) => const Register());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Rota não encontrada')),
            body: Center(child: Text('Rota desconhecida: ${settings.name}')),
          ),
        );
    }
  }
}
