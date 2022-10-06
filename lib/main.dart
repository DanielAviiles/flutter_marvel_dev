import 'package:flutter/material.dart';
import 'package:flutter_marvel_dev/app/core/api/api_route_config.dart';
import 'package:flutter_marvel_dev/app/routes/app_pages_route.dart';
import 'package:flutter_marvel_dev/app/routes/app_routes.dart';
import '/app/di/injection.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.configureAppInjection();
  await ApiRouteConfig.loadEnviroments();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marvel Characters - Mobile',
      theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
        color: Colors.red,
      )),
      routes: AppPagesRoute.getRoutes(),
      initialRoute: AppRoutes.home,
    );
  }
}
