import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'food_preference_screen.dart';
import 'second_screen.dart';
import 'meal_selection_screen.dart';

class MainNavigator extends StatefulWidget {
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    FoodPreferenceScreen(),
    Center(child: Text('식단일지')),
    Center(child: Text('My 홈')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        initialRoute: '/',
        onGenerateRoute: (RouteSettings settings) {
          Widget page = _pages[_selectedIndex];

          if (settings.name == '/second') {
            page = SecondScreen();
          } else if (settings.name == '/mealSelection') {
            // 아규먼트를 전달할 때 settings.arguments로 전달된 값이 있는지 확인
            final args = settings.arguments as Map<String, bool>?;
            page = MealSelectionScreen();
            if (args != null) {
              page = MealSelectionScreen();
            }
          }

          return MaterialPageRoute(builder: (_) => page, settings: settings);
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: '오늘의 식단추천',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: '식단일지',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My 홈',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
