import 'package:flutter/material.dart';
import 'package:circusweb/app/app.dart';
import 'package:circusweb/core/routing/route_name.dart';

class AppRouter {
	static Route<dynamic> onGenerateRoute(RouteSettings settings) {
		switch (settings.name) {
			case RouteName.welcome:
				return MaterialPageRoute(
					builder: (_) => const WelcomeScreen(),
					settings: settings,
				);

			case RouteName.catalog:
				return MaterialPageRoute(
					builder: (_) => const PlaceholderScreen(
						title: 'Catalogo',
						subtitle: 'Aqui vivira tu modulo catalog',
					),
					settings: settings,
				);

			case RouteName.orders:
				return MaterialPageRoute(
					builder: (_) => const PlaceholderScreen(
						title: 'Ordenes',
						subtitle: 'Aqui vivira tu modulo orders',
					),
					settings: settings,
				);

			case RouteName.profile:
				return MaterialPageRoute(
					builder: (_) => const PlaceholderScreen(
						title: 'Perfil',
						subtitle: 'Aqui vivira tu modulo profile',
					),
					settings: settings,
				);

			default:
				return MaterialPageRoute(
					builder: (_) => const PlaceholderScreen(
						title: '404',
						subtitle: 'Ruta no encontrada',
					),
					settings: settings,
				);
		}
	}
}

class PlaceholderScreen extends StatelessWidget {
	final String title;
	final String subtitle;

	const PlaceholderScreen({
		super.key,
		required this.title,
		required this.subtitle,
	});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(title: Text(title)),
			body: Center(
				child: Padding(
					padding: const EdgeInsets.all(24),
					child: Text(
						subtitle,
						textAlign: TextAlign.center,
					),
				),
			),
		);
	}
}
