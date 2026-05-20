import 'package:flutter/material.dart';

import 'app_routes.dart';
import 'package:campus_guide/Features/profile/profile_page.dart';
import 'package:campus_guide/Features/profile/edit_profile_page.dart';
import 'package:campus_guide/Features/events/event_details_page.dart';
import 'package:campus_guide/Features/auth/login.dart';
import 'package:campus_guide/Features/auth/register.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      case AppRoutes.editProfile:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());

      case AppRoutes.eventDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => EventDetailsPage(
            title: args?['title'] ?? '',
            description: args?['description'] ?? '',
            location: args?['location'] ?? '',
            speakers: (args?['speakers'] as List<Map<String, String>>?) ?? [],
          ),
        );

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const Login());

      case AppRoutes.register:
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
