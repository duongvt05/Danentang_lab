import 'package:flutter/material.dart';

void main() => runApp(MyApp());

// 1. Định nghĩa class Question ngay tại đây để tránh lỗi import
class Question {
  String questionText;
  bool questionAnswer;

  Question(this.questionText, this.questionAnswer);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // Danh sách Icon hiển thị kết quả (tick hoặc cross)
  List<Icon> scoreKeeper = [];

  // Biến đếm câu hỏi hiện tại
  int questionNumber = 0;

  // Danh sách câu hỏi
  final List<Question> questionsList = [
    Question('Môn Lập trình đa nền tảng học vào sáng thứ 5?', true),
    Question('Môn Lập trình đa nền tảng gồm 3 tín chỉ?', false),
    Question('Giảng viên dạy môn này là thầy ThS Ngô Lê Quân?', true),
    Question('1 + 1 = 2?', true),
  ];

  // Hàm kiểm tra đáp án và xử lý logic
  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = questionsList[questionNumber].questionAnswer;

    setState(() {
      // Kiểm tra xem đã đến câu hỏi cuối cùng chưa
      if (questionNumber >= questionsList.length - 1) {
        // 1. Ghi nhận kết quả câu cuối
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }

        // 2. Hiện thông báo kết thúc
        _showResetDialog();
      } else {
        // Nếu chưa hết câu hỏi
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }
        // Chuyển sang câu tiếp theo
        questionNumber++;
      }
    });
  }

  // Hàm reset lại game
  void resetQuiz() {
    setState(() {
      questionNumber = 0;
      scoreKeeper = [];
    });
  }

  // Hộp thoại thông báo kết thúc
  void _showResetDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Bắt buộc người dùng phải bấm nút
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Hoàn thành!"),
          content: Text("Bạn đã trả lời hết các câu hỏi."),
          actions: [
            TextButton(
              child: Text("Làm lại"),
              onPressed: () {
                Navigator.of(context).pop(); // Tắt hộp thoại
                resetQuiz(); // Reset game
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // PHẦN 1: HIỂN THỊ CÂU HỎI (Dùng Expanded để chiếm phần lớn màn hình)
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: Text(
                      questionsList[questionNumber].questionText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              // PHẦN 2: NÚT TRUE
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: Text(
                      'True',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onPressed: () {
                      checkAnswer(true);
                    },
                  ),
                ),
              ),

              // PHẦN 3: NÚT FALSE
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: Text(
                      'False',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    onPressed: () {
                      checkAnswer(false);
                    },
                  ),
                ),
              ),

              // PHẦN 4: THANH TRẠNG THÁI (Icons)
              // Dùng SingleChildScrollView để nếu nhiều icon quá thì cuộn được, không bị lỗi
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: scoreKeeper,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}