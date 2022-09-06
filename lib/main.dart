import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_firebase/database.dart';
import 'package:test_firebase/view.dart';

import 'add.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  late Database db;
  // int _counter = 0;
  List docs = [];

  initialise() {
    db = Database();
    db.initialize();
    db.read().then((value) => {
          setState(() {
            docs = value!;
          })
        });
  }

  @override
  void initState() {
    super.initState();
    initialise();
  }

  // final List<String> entries = <String>['A', 'B', 'C'];
  // final List<int> colorCodes = <int>[600, 500, 100];
  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      // _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text("Country"),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: docs.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => View(
                                country: docs[index],
                                db: db,
                              ))).then((value) => {
                        if (value != null) {initialise()}
                      });
                },
                contentPadding: const EdgeInsets.only(right: 30, left: 30),
                title: Text(docs[index]['name']),
                trailing: Text(docs[index]['code']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Add(db: db)))
              .then((value) => {
                    if (value != null) {initialise()}
                  });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
