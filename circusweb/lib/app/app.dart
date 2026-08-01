import 'package:flutter/material.dart';
import 'package:circusweb/core/hooks/paginated_hook.dart';
import 'package:circusweb/core/routing/app_router.dart';
import 'package:circusweb/core/routing/route_name.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circus Web',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      initialRoute: RouteName.welcome,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final PaginatedHook _hook = PaginatedHook();

  @override
  void initState() {
    super.initState();
    _hook.syncFromRoute(RouteName.welcome);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bienvenido al Amazin Digital Circus Web',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text( 
                'Arquitectura Modular lista para arrancar',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Widget actual: ${_hook.widgetFileForCurrentRoute()}',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  final nextRoute = _hook.goTo(RouteName.catalog);
                  Navigator.pushNamed(context, nextRoute);
                },
                child: const Text('Entar al catalogo'),
              ),
            ],
          ),

        ),
      ),
    );
  }
}