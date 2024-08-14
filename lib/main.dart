import 'package:flutter/material.dart';
import 'package:ai_reco/screens/main_navigation.dart';
import 'package:ai_reco/screens/second_screen.dart';
import 'package:ai_reco/screens/meal_selection_screen.dart';
import 'package:ai_reco/screens/food_preference_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainNavigator(),
        '/second': (context) => SecondScreen(),
        '/mealSelection': (context) => MealSelectionScreen(),
        '/foodPreference': (context) => FoodPreferenceScreen(),
      },
    );
  }
}
