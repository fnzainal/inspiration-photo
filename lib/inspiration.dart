
import 'package:flutter/material.dart';

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
            var linkImage = "https://picsum.photos/${width.toInt()}/${height.toInt()}?random=$number";
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
