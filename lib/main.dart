import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  int _number = 1;

  void _nextPage() {
    const maxNumber = 100;
    const minNumber = 1;
    if(_number < minNumber){
      const snackBar = SnackBar(content: Text('Number can\'t be less than 1!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if(_number > maxNumber){
      const snackBar = SnackBar(content: Text('Number is too big! max is $maxNumber.'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyInspirationPage(number: _number);
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
              'Enter number of inspiration'
            ),
            Center(
                child:Container(
                  margin: const EdgeInsets.all(15),
                  child: TextField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly, // Allow only digits
                    ],
                    maxLength: 3,
                    onChanged: (String value) {
                      setState(() {
                        _number = int.parse(value);
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
