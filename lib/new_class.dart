import 'package:flutter/material.dart';
import 'constant.dart';

class MainImage extends StatelessWidget {
  const MainImage({
    Key? key,
    required this.height,
    required this.width,
    required this.image,
  });

  final double height;
  final double width;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          image,
          height: height * 0.40,
          width: width,
          fit: BoxFit.cover,
        ),
        Container(
          height: height * 0.50,
          width: width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.white],
                stops: [0.3, 0.8]),
          ),
        ),
        Positioned(
          bottom: 30,
          left: 0,
          right: 0,
          child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                  text: appName + '\n',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  children: [
                    TextSpan(
                        text: slogan,
                        style: TextStyle(
                            color: Colors.grey, fontSize: 13)),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
