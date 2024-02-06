import 'package:flutter/material.dart';

class GlobeExample extends StatefulWidget {
  const GlobeExample({Key? key}) : super(key: key);

  @override
  State<GlobeExample> createState() => _GlobeExampleState();
}

class _GlobeExampleState extends State<GlobeExample> {
  bool isExpand = false;
  double sizeValue = 75.0, lineSize = 0.0;
  int lineDuration = 1000;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: GestureDetector(
          onTap: () => setState(() {
            isExpand = !isExpand;
            isExpand == true ? sizeValue = 100.0 : sizeValue = 75.0;
            isExpand == true ? lineDuration = 800 : lineDuration = 1000;
            isExpand == true ? lineSize = 400.0 : lineSize = 0.0;
          }),
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedContainer(
                duration: const Duration(seconds: 1),
                height: isExpand == true ? 400.0 : 250.0,
                width: isExpand == true ? 400.0 : 250.0,
                decoration: BoxDecoration(
                  border: Border.all(width: 2.5, color: Colors.blueGrey),
                  borderRadius: BorderRadius.circular(250.0),
                ),
              ),
              Container(
                height: 100.0,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(100.0),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: lineDuration),
                height: lineSize,
                width: 2.0,
                decoration: BoxDecoration(
                  border: Border.all(width: 2.5, color: Colors.blueGrey),
                ),
              ),
              AnimatedContainer(
                duration: Duration(milliseconds: lineDuration),
                height: 2.0,
                width: lineSize,
                decoration: BoxDecoration(
                  border: Border.all(width: 2.5, color: Colors.blueGrey),
                ),
              ),
              Transform.rotate(
                angle: 0.77,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: lineDuration),
                  height: lineSize,
                  width: 2.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.5, color: Colors.blueGrey),
                  ),
                ),
              ),
              Transform.rotate(
                angle: -0.77,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: lineDuration),
                  height: lineSize,
                  width: 2.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.5, color: Colors.blueGrey),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                top: isExpand == true ? 200.0 : 290.0,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: sizeValue,
                  width: sizeValue,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(sizeValue),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                bottom: isExpand == true ? 200.0 : 290.0,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: sizeValue,
                  width: sizeValue,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(sizeValue),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                right: isExpand == true ? -38.0 : 50.0,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: sizeValue,
                  width: sizeValue,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(sizeValue),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                left: isExpand == true ? -38.0 : 50.0,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: sizeValue,
                  width: sizeValue,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(sizeValue),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                bottom: isExpand == true ? 256.0 : 324.0,
                right: isExpand == true ? 20.0 : 80.0,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: sizeValue,
                  width: sizeValue,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(sizeValue),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                bottom: isExpand == true ? 256.0 : 324.0,
                left: isExpand == true ? 20.0 : 80.0,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: sizeValue,
                  width: sizeValue,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(sizeValue),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                top: isExpand == true ? 256.0 : 324.0,
                right: isExpand == true ? 20.0 : 80.0,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: sizeValue,
                  width: sizeValue,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(sizeValue),
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(seconds: 1),
                top: isExpand == true ? 256.0 : 324.0,
                left: isExpand == true ? 20.0 : 80.0,
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  height: sizeValue,
                  width: sizeValue,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(sizeValue),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}