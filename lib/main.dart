import 'package:flutter/material.dart';
import 'package:inspiration_photo/inspiration.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspiration',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: 'Welcome to Inspiration'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _name = "";

  void _nextPage() {
    const maxLengthName = 8;
    const minLengthName = 3;
    if(_name.isEmpty){
      const snackBar = SnackBar(content: Text('Name can\'t be empty!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if(_name.length < minLengthName){
      const snackBar = SnackBar(content: Text('Name too short! min $minLengthName chars.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }  else if(_name.length > maxLengthName){
      const snackBar = SnackBar(content: Text('Name too long! max $maxLengthName chars.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyInspirationPage(name: _name);
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter your nick _name',
            ),
            Center(
                child:Container(
                  margin: const EdgeInsets.all(15),
                  child: TextField(
                    textAlign: TextAlign.center,
                    onChanged: (String value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  )
                )
            ),
            const Text(
              'tap next button to see inspiration photos.',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _nextPage,
        tooltip: 'Next Page',
        child: const Icon(Icons.navigate_next_rounded),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
