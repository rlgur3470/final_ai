import 'package:flutter/material.dart';
import 'food_preference_screen.dart';  // FoodPreferenceScreen을 임포트
import '../data/food_data.dart';  // 음식 데이터를 임포트

class MealSelectionScreen extends StatefulWidget {
  @override
  _MealSelectionScreenState createState() => _MealSelectionScreenState();
}

class _MealSelectionScreenState extends State<MealSelectionScreen> {
  bool isBreakfast = false;
  bool isLunch = false;
  bool isDinner = false;

  List<Map<String, dynamic>> selectedFoods = [];
  Set<String> breakfastCategories = {};  // 아침 선택된 카테고리들
  Set<String> lunchCategories = {};  // 점심 선택된 카테고리들
  Set<String> dinnerCategories = {};  // 저녁 선택된 카테고리들

  int totalCalories = 0;
  int remainingCalories = 2000;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, bool>?;

    // 디버깅용 로그 출력
    print('MealSelectionScreen - 수신된 아규먼트: $arguments');

    if (arguments != null) {
      setState(() {
        isBreakfast = arguments['breakfast'] ?? false;
        isLunch = arguments['lunch'] ?? false;
        isDinner = arguments['dinner'] ?? false;
      });
    }
  }

  void _calculateCalories() {
    totalCalories = selectedFoods.fold<int>(0, (sum, food) => sum + (food['calories'] as int));
    remainingCalories = 2000 - totalCalories;
  }

  void _selectFood(String category, List<Map<String, dynamic>> foodList, String mealType) async {
    final selectedFood = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('음식을 선택하세요'),
          children: foodList.map((food) {
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context, food);
              },
              child: Text('${food['food_name']} (${food['calories']} Kcal)'),
            );
          }).toList(),
        );
      },
    );

    if (selectedFood != null) {
      setState(() {
        selectedFoods.add(selectedFood);
        if (mealType == 'breakfast') {
          breakfastCategories.add(category);
        } else if (mealType == 'lunch') {
          lunchCategories.add(category);
        } else if (mealType == 'dinner') {
          dinnerCategories.add(category);
        }
        _calculateCalories();
      });
    }
  }

  void _navigateToFoodPreferenceScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodPreferenceScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 식단 추천'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isBreakfast) _mealSection('아침에 뭘 드셨나요?', 'breakfast'),
            if (isLunch) _mealSection('점심에 뭘 드셨나요?', 'lunch'),
            if (isDinner) _mealSection('저녁에 뭘 드셨나요?', 'dinner'),
            SizedBox(height: 20),
            Text('먹은 칼로리: $totalCalories Kcal', style: TextStyle(fontSize: 18)),
            Text('남은 칼로리: $remainingCalories Kcal', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToFoodPreferenceScreen,
              child: Text('다음 단계'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mealSection(String title, String mealType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: TextStyle(fontSize: 20)),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            _mealButton('밥', riceList, mealType),
            _mealButton('국', soupList, mealType),
            _mealButton('메인 음식', mainDishList, mealType),
            _mealButton('간식', snackList, mealType),
            _mealButton('음료', beverageList, mealType),
          ],
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _mealButton(String category, List<Map<String, dynamic>> foodList, String mealType) {
    bool isDisabled = false;
    if (mealType == 'breakfast') {
      isDisabled = breakfastCategories.contains(category);
    } else if (mealType == 'lunch') {
      isDisabled = lunchCategories.contains(category);
    } else if (mealType == 'dinner') {
      isDisabled = dinnerCategories.contains(category);
    }

    return ElevatedButton(
      onPressed: isDisabled
          ? null  // 이미 선택된 경우 비활성화
          : () => _selectFood(category, foodList, mealType),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(category, style: TextStyle(fontSize: 18)),
    );
  }
}
