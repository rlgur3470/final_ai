import 'package:flutter/material.dart';
import 'package:ai_reco/screens/food_recommendation.dart';

class FoodPreferenceScreen extends StatelessWidget {
  final List<Map<String, dynamic>> japaneseFoodList = [
    {'음식명': '초밥', '칼로리': 300},
    {'음식명': '우동', '칼로리': 400},
    // 다른 일식 항목 추가
  ];

  final List<Map<String, dynamic>> westernFoodList = [
    {'음식명': '스테이크', '칼로리': 800},
    {'음식명': '파스타', '칼로리': 600},
    // 다른 양식 항목 추가
  ];

  final List<Map<String, dynamic>> convenienceStoreFoodList = [
    {'음식명': '삼각김밥', '칼로리': 200},
    {'음식명': '라면', '칼로리': 300},
    // 다른 편의점 항목 추가
  ];

  final List<Map<String, dynamic>> fastFoodList = [
    {'음식명': '햄버거', '칼로리': 700},
    {'음식명': '프렌치프라이', '칼로리': 400},
    // 다른 패스트푸드 항목 추가
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('음식 취향을 골라주세요!'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('음식 취향을 골라주세요!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 30),
            _buildFoodOptions(context),
            SizedBox(height: 20),
          ],
        ),
      ),

    );
  }

  Widget _buildFoodOptions(BuildContext context) {
    return Wrap(
      spacing: 20.0,
      runSpacing: 20.0,
      alignment: WrapAlignment.center,
      children: <Widget>[
        _foodOptionButton(context, '일식'),
        _foodOptionButton(context, '양식'),
        _foodOptionButton(context, '편의점'),
        _foodOptionButton(context, '패스트푸드'),
      ],
    );
  }

  Widget _foodOptionButton(BuildContext context, String label) {
    return ElevatedButton(
      onPressed: () {
        List<Map<String, dynamic>> selectedFoodList;

        switch (label) {
          case '일식':
            selectedFoodList = japaneseFoodList;
            break;
          case '양식':
            selectedFoodList = westernFoodList;
            break;
          case '편의점':
            selectedFoodList = convenienceStoreFoodList;
            break;
          case '패스트푸드':
            selectedFoodList = fastFoodList;
            break;
          default:
            selectedFoodList = [];
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FoodRecommendationScreen(
              foodType: label,
              foodList: selectedFoodList,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      ),
      child: Text(label, style: TextStyle(fontSize: 18)),
    );
  }
}
