import 'package:flutter/material.dart';

class FoodRecommendationScreen extends StatelessWidget {
  final String foodType;
  final List<Map<String, dynamic>> foodList;

  FoodRecommendationScreen({required this.foodType, required this.foodList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 $foodType 추천 메뉴!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$foodType 추천 메뉴',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            _buildFoodRecommendations(),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodRecommendations() {
    return Column(
      children: foodList.map((food) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                food['음식명'],
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '${food['칼로리']}kcal',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
