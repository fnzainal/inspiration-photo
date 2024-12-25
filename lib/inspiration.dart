
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class MyInspirationPage extends StatelessWidget {
  const MyInspirationPage({ super.key,required this.number});

  final int number;

  @override
  Widget build(BuildContext context) {
    final List<int> numberList = List.generate(number, (index) => index + 1);
    var width = MediaQuery.of(context).size.width;
    var height = width / 2;

    return Scaffold(
        appBar: AppBar(
          title: Text('Show $number Inspirations'),
        ),
        body: ListView(
          children: numberList.map((number) {
            var linkImage = "https://picsum.photos/id/$number/${width.toInt()}/${height.toInt()}";
            return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return DetailInspirationPage(linkImage);
                      }));
                },
                child: Hero(
                tag: "picture",
                child: Container(
                      height: height,
                      decoration:
                      BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(linkImage),
                        ),
                      ),
                    )
                    )
            );
          }).toList(),
        )
    );

  }
}
class DetailInspirationPage extends StatefulWidget {
  const DetailInspirationPage(this.linkImage, {Key? key}) : super(key: key);

  final String linkImage;

  @override
  State<DetailInspirationPage> createState()  => _DetailInspirationPageState();
}

class _DetailInspirationPageState extends State<DetailInspirationPage> {

  Future<void> _shareImage() async {
    try {
      // 1. Fetch the image
      final response = await http.get(Uri.parse(widget.linkImage));
      final bytes = response.bodyBytes;

      // 2. Get the file path
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = '${directory.path}/image.jpg';
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(bytes);

      // 3. Share the image
      await Share.shareXFiles([XFile(imagePath)], text: 'Check out this image!');
    } catch (e) {
      var message = 'Error sharing image: $e';
      var snackBar = SnackBar(content: Text(message));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      // Handle the error, e.g., show a snackbar or dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
                child: InteractiveViewer(
                    panEnabled: false,
                    minScale: 0.5,
                    maxScale: 2,
                    child: Image.network(widget.linkImage)
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shareImage,
        tooltip: 'Share',
        child: const Icon(Icons.share),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

}
