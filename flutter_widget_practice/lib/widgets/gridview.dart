import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/text.dart';

class GridViewPage extends StatelessWidget {
  const GridViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> image_urls = [
      "https://placekitten.com/200/300",
      "https://placebear.com/200/300",
      "https://placekitten.com/201/301",
      "https://placekitten.com/201/304",
      // "https://placekitten.com/201/302",
      // "https://placekitten.com/201/305",
      // "https://placekitten.com/201/306",
      // "https://placekitten.com/201/311",
      // "https://placekitten.com/201/323",
      // "https://placekitten.com/201/321",
      // "https://placebear.com/201/301",
      // "https://placekitten.com/202/302",
      // "https://placebear.com/202/302",
      // "https://placekitten.com/203/303",
      // "https://placebear.com/203/303",
      // "https://placebear.com/204/302",
      // "https://placebear.com/204/312",
      // "https://placebear.com/204/322",
      // "https://placebear.com/204/303",
      // "https://placebear.com/204/304",
      // "https://placebear.com/204/305",
      // "https://placebear.com/204/306",
      // "https://placekitten.com/204/304",
    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            text('Hello Guys...'),
            GridView.builder(
              // You can use Expanded instead of Shrinkwrap=true(if it's true then widget take only needed Space in Scaffold) [Choice is yours...]
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 10,
                mainAxisExtent: 250,
              ),
              itemCount: image_urls.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: image_urls[index],
                  errorWidget: (context, url, error) => const ColoredBox(
                    color: Colors.black,
                    child: Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                  placeholder: (context, url) => const ColoredBox(
                    color: Colors.black26,
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
/*


GridView.count...

GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          // scrollDirection: Axis.horizontal,
          shrinkWrap: false,
          children: [
            lstile(title: text('Hello'), tileColor: Colors.yellow),
            lstile(title: text('Hello'), tileColor: Colors.yellow),
            lstile(title: text('Hello'), tileColor: Colors.yellow),
            lstile(title: text('Hello'), tileColor: Colors.yellow),
            lstile(title: text('Hello'), tileColor: Colors.yellow),
            lstile(title: text('Hello'), tileColor: Colors.yellow),
            lstile(title: text('Hello'), tileColor: Colors.yellow),
            lstile(title: text('Hello'), tileColor: Colors.yellow),
            lstile(title: text('Hello'), tileColor: Colors.yellow),
          ],
        ),

GridView.builder...

List<String> image_urls = [
      "https://placekitten.com/200/300",
      "https://placebear.com/200/300",
      "https://placekitten.com/201/301",
      "https://placebear.com/201/301",
      "https://placekitten.com/202/302",
      "https://placebear.com/202/302",
      "https://placekitten.com/203/303",
      "https://placebear.com/203/303",
      "https://placekitten.com/204/304",
      "https://placebear.com/204/304"
    ];

    
GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10,
            mainAxisExtent: 250,
          ),
          itemCount: image_urls.length,
          itemBuilder: (context, index) {
            return Image.network(
              image_urls[index],
            );
          },
        ),

GridView.Extent..

GridView.extent(
          maxCrossAxisExtent: 200,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          // cacheExtent: 5,
          children: [
            Image.network("https://placekitten.com/200/300"),
            Image.network("https://placebear.com/200/300"),
            Image.network("https://placekitten.com/201/301"),
            Image.network("https://placekitten.com/201/304"),
            Image.network("https://placekitten.com/201/302"),
            Image.network("https://placekitten.com/201/305"),
            Image.network("https://placekitten.com/201/306"),
            Image.network("https://placekitten.com/201/311"),
            Image.network("https://placekitten.com/201/323"),
            Image.network("https://placekitten.com/201/321"),
            Image.network("https://placebear.com/201/301"),
            Image.network("https://placekitten.com/202/302"),
            Image.network("https://placebear.com/202/302"),
            Image.network("https://placekitten.com/203/303"),
            Image.network("https://placebear.com/203/303"),
            Image.network("https://placebear.com/204/302"),
            Image.network("https://placebear.com/204/312"),
            Image.network("https://placebear.com/204/322"),
            Image.network("https://placebear.com/204/303"),
            Image.network("https://placebear.com/204/304"),
            Image.network("https://placebear.com/204/305"),
            Image.network("https://placebear.com/204/306"),
            Image.network("https://placekitten.com/204/304"),
          ],
        )

*/