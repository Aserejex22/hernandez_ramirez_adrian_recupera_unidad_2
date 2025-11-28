import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/plant_viewmodel.dart';
import 'viewmodels/theme_viewmodel.dart';
import 'views/plant_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlantViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (context, themeViewModel, child) {
        return MaterialApp(
          title: 'Guía de Plantas',
          debugShowCheckedModeBanner: false,
          theme: themeViewModel.currentTheme,
          home: const PlantListScreen(),
        );
      },
    );
  }
}
