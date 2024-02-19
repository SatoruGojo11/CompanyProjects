import 'package:flutter/material.dart';
import 'package:flutter_widget_practice/models/text.dart';
import 'package:flutter_widget_practice/widgets/Hero/second_screen.dart';

class HeroWidget extends StatelessWidget {
  const HeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: text('Hero Widget Sample'),
      ),
      body: Center(
        child: ListTile(
          leading: Hero(
            transitionOnUserGestures: true,
            tag: 'naruto',
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: Image.asset('assets/naruto.jpg'),
            ),
          ),
          onTap: () {
            Future.delayed(
              const Duration(seconds: 2),
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SecondScreenofHero(),
              ),
            );
          },
          title: text('Naruto Uzumaki'),
          subtitle: text('I am Hokage'),
        ),

        // child: GestureDetector(
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => const SecondScreenofHero(),
        //       ),
        //     );
        //   },
        //   child: Hero(
        //     tag: 'naruto',
        //     child: Image.asset('assets/naruto.jpg'),
        //   ),
        // ),
      ),
    );
  }
}
