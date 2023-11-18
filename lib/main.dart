import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/screens/screens.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(const AppState()),
  );
}

class AppState extends StatelessWidget {
  const AppState() : super(key: null);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MoviesProvider(),
          lazy: false,
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp() : super(key: null);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pel·lícules',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => const HomeScreen(),
        'details': (BuildContext context) => DetailsScreen(),
      },
      theme: getTheme(),
    );
  }

  getTheme() {
    return ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          primary: Colors.redAccent,
        )).copyWith(
      appBarTheme: const AppBarTheme(
        color: Colors.redAccent,
      ),
    );
  }
}
