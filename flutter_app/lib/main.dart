import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/match_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const LiveFootballApp());
}

class LiveFootballApp extends StatelessWidget {
  const LiveFootballApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MatchProvider(),
      child: MaterialApp(
        title: 'Live Football Score',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.green,
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
