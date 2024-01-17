import 'package:flutter/material.dart';
import 'package:pie_timer/pie_timer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pie Timer',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('PieTimer'),
        ),
        body: const PieWidget(),
      ),
    );
  }
}

class PieWidget extends StatefulWidget {
  const PieWidget({Key? key}) : super(key: key);

  @override
  State<PieWidget> createState() => _PieWidgetState();
}

class _PieWidgetState extends State<PieWidget>
    with SingleTickerProviderStateMixin {
  late PieAnimationController _pieAnimationController;

  @override
  void initState() {
    super.initState();
    _pieAnimationController = PieAnimationController(vsync: this);
  }

  @override
  void dispose() {
    _pieAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        PieTimer(
          pieAnimationController: _pieAnimationController,
          duration: const Duration(seconds: 10),
          countdownPassed: const Duration(seconds: 6),
          radius: 150,
          fillColor: Colors.red,
          pieColor: Colors.black,
          borderColor: Colors.yellow,
          borderWidth: 15,
          shadowColor: Colors.black,
          shadowElevation: 10.0,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
          isReverse: false,
          onCompleted: () => {},
          onDismissed: () => {},
          enableTouchControls: true,
        ),
        const SizedBox(height: 100),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.pause),
              onPressed: () {
                _pieAnimationController.stopAnim?.call();
              },
            ),
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {
                _pieAnimationController.startAnim?.call();
              },
            ),
            IconButton(
              icon: const Icon(Icons.replay),
              onPressed: () {
                _pieAnimationController.resetAnim?.call();
              },
            ),
          ],
        ),
      ],
    );
  }
}
