import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // Импорт для kIsWeb
import 'dart:io' show Platform; // Для работы с Platform на Windows и Android

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PlatformSpecificHomePage(),
    );
  }
}

class PlatformSpecificHomePage extends StatefulWidget {
  @override
  _PlatformSpecificHomePageState createState() => _PlatformSpecificHomePageState();
}

class _PlatformSpecificHomePageState extends State<PlatformSpecificHomePage> {
  String platformMessage = "Определение платформы...";
  Color backgroundColor = Colors.white;
  String webMessage = "Это веб-платформа. Нажмите кнопку для изменения сообщения.";
  double textSize = 24;

  @override
  void initState() {
    super.initState();
    determinePlatform();
  }

  // Определение платформы и выполнение платформенно-зависимых действий
  void determinePlatform() {
    if (kIsWeb) {
      setState(() {
        platformMessage = "Web";
      });
    } else if (Platform.isAndroid) {
      setState(() {
        platformMessage = "Android";
      });
    } else if (Platform.isWindows) {
      setState(() {
        platformMessage = "Windows.";
      });
    }
  }

  // Изменение цвета фона на Android
  void changeBackgroundColor() {
    setState(() {
      backgroundColor = backgroundColor == Colors.white ? Colors.blue : Colors.white;
    });
  }

  // Изменение сообщения на веб-платформе
  void changeWebMessage() {
    setState(() {
      webMessage = "Сообщение изменено!";
    });
  }

  // Изменение размера текста на Windows
  void increaseTextSize() {
    setState(() {
      textSize = textSize == 24 ? 32 : 24;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Платформенно-зависимый интерфейс'),
      ),
      body: Container(
        color: backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                platformMessage,
                style: TextStyle(fontSize: textSize),
              ),
              SizedBox(height: 20),
              if (kIsWeb) ...[
                Text(
                  webMessage,
                  style: TextStyle(fontSize: 18),
                ),
                ElevatedButton(
                  onPressed: changeWebMessage,
                  child: Text("Изменить сообщение"),
                )
              ] else if (Platform.isAndroid) ...[
                ElevatedButton(
                  onPressed: changeBackgroundColor,
                  child: Text("Изменить цвет фона"),
                )
              ] else if (Platform.isWindows) ...[
                ElevatedButton(
                  onPressed: increaseTextSize,
                  child: Text("Изменить размер текста"),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
