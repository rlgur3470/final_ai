import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  bool isBreakfastSelected = false;
  bool isLunchSelected = false;
  bool isDinnerSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('오늘의 식단 추천'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '오늘 어디까지 식사하셨나요?',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: <Widget>[
                _mealButton('아침', isBreakfastSelected, () {
                  setState(() {
                    isBreakfastSelected = !isBreakfastSelected;
                  });
                }),
                _mealButton('점심', isLunchSelected, () {
                  setState(() {
                    isLunchSelected = !isLunchSelected;
                  });
                }),
                _mealButton('저녁', isDinnerSelected, () {
                  setState(() {
                    isDinnerSelected = !isDinnerSelected;
                  });
                }),
              ],
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                final arguments = {
                  'breakfast': isBreakfastSelected,
                  'lunch': isLunchSelected,
                  'dinner': isDinnerSelected,
                };

                // 디버깅용 로그 출력
                print('SecondScreen - 전달될 아규먼트: $arguments');

                Navigator.pushNamed(context, '/mealSelection', arguments: arguments);
              },
              child: Text('다음 단계'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mealButton(String title, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: isSelected ? Colors.blue : Colors.grey,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(title, style: TextStyle(fontSize: 18)),
    );
  }
}
