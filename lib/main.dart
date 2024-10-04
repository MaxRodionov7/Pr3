import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Собственный StatelessWidget для главного приложения
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Туристическое приложение',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String destinationText = "Выберите направление для путешествия";
  String destinationDescription = "Нажмите на кнопку, чтобы выбрать направление.";
  Color containerColor = Colors.lightBlueAccent;

  void changeDestination(String destination) {
    setState(() {
      destinationText = "Вы выбрали: $destination";
      if (destination == "Париж") {
        destinationDescription = "Париж — город любви, искусства и культуры.";
      } else if (destination == "Токио") {
        destinationDescription = "Токио — современная столица Японии, сочетающая традиции и технологии.";
      } else if (destination == "Нью-Йорк") {
        destinationDescription = "Нью-Йорк — город, который никогда не спит, с множеством достопримечательностей.";
      }
      toggleContainerColor();
    });
  }

  void toggleContainerColor() {
    setState(() {
      containerColor = containerColor == Colors.lightBlueAccent
          ? Colors.redAccent
          : Colors.lightBlueAccent;
    });
  }

  void showDestinationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Выберите направление"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Париж"),
                onTap: () {
                  changeDestination("Париж");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Токио"),
                onTap: () {
                  changeDestination("Токио");
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Нью-Йорк"),
                onTap: () {
                  changeDestination("Нью-Йорк");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Популярные направления'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              destinationText,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              destinationDescription,
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(16),
              color: containerColor,
              child: Text(
                'Информация о направлении!',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: showDestinationDialog,
              child: Text('Выбрать направление'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ColumnScreen()),
                  ),
                  child: Icon(Icons.location_city, size: 32, color: Colors.blue),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListViewScreen()),
                  ),
                  child: Icon(Icons.location_city, size: 32, color: Colors.green),
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListViewSeparatedScreen()),
                  ),
                  child: Icon(Icons.location_city, size: 32, color: Colors.red),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Экран со списком на основе Column
class ColumnScreen extends StatefulWidget {
  @override
  _ColumnScreenState createState() => _ColumnScreenState();
}

class _ColumnScreenState extends State<ColumnScreen> {
  List<String> destinations = ["Париж", "Токио", "Нью-Йорк"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Список на Column")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: destinations.map((destination) {
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                title: Text(
                  destination,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      destinations.remove(destination);
                    });
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          setState(() {
            destinations.add("Новое направление");
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// Экран со списком на основе ListView.builder
class ListViewScreen extends StatefulWidget {
  @override
  _ListViewScreenState createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  List<String> destinations = ["Париж", "Токио", "Нью-Йорк"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Список на ListView")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text(
                destinations[index],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    destinations.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          setState(() {
            destinations.add("Новое направление");
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

// Экран со списком на основе ListView.separated
class ListViewSeparatedScreen extends StatefulWidget {
  @override
  _ListViewSeparatedScreenState createState() => _ListViewSeparatedScreenState();
}

class _ListViewSeparatedScreenState extends State<ListViewSeparatedScreen> {
  List<String> destinations = ["Париж", "Токио", "Нью-Йорк"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Список на ListView.separated")),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text(
                destinations[index],
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    destinations.removeAt(index);
                  });
                },
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          setState(() {
            destinations.add("Новое направление");
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
