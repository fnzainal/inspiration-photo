import 'package:flutter/material.dart';

class MyInspirationPage extends StatelessWidget {
  const MyInspirationPage({ super.key,required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final List<int> numberList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    var width = MediaQuery.of(context).size.width;
    var height = width / 2;

    return Scaffold(
        appBar: AppBar(
          title: Text('Inspiration for $name'),
        ),
        body: ListView(
          children: numberList.map((number) {
            var linkImage = "https://picsum.photos/${width.toInt()}/${height.toInt()}?random=$number";
            return InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return DetailInspirationPage(linkImage);
                      }));
                },
                child: Container(
                  height: height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fitWidth,
                      image: NetworkImage(linkImage),
                    ),
                  ),
                )
            );
          }).toList(),
        )
    );

  }
}
class DetailInspirationPage extends StatelessWidget {
  const DetailInspirationPage(this.linkImage, {Key? key}) : super(key: key);

  final String linkImage;

  @override
  Widget build(BuildContext context) {

    return Center(
        child: InteractiveViewer(
            panEnabled: false,
            minScale: 0.5,
            maxScale: 2,
            child: Image.network(linkImage)
        )
    );
  }
}
