import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const maxMinutes = 45 * 60;
  int totalSecond = maxMinutes;
  int routineCount = 0;
  bool isPlaying = false;
  late Timer timer;

  void onTimerStart(Timer timer) {
    log('$totalSecond');
    if (totalSecond == 0) {
      setState(() {
        routineCount = routineCount + 1;
        totalSecond = maxMinutes;
        isPlaying = false;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSecond = totalSecond - 1;
      });
    }
  }

  void onPlayPressed() {
    timer = Timer.periodic(const Duration(seconds: 1), onTimerStart);
    setState(() {
      isPlaying = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isPlaying = false;
    });
  }

  void onResetPressed() {
    timer.cancel();
    setState(() {
      isPlaying = false;
      totalSecond = maxMinutes;
    });
  }

  String format(int seconds) {
    String strSeconds = Duration(seconds: seconds).toString();
    return strSeconds.split('.')[0].substring(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSecond),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 88,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 5,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: isPlaying ? onPausePressed : onPlayPressed,
                    icon: Icon(
                      isPlaying
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline_rounded,
                    ),
                    iconSize: 110,
                    color: Theme.of(context).cardColor,
                  ),
                  IconButton(
                    onPressed: onResetPressed,
                    icon: const Icon(Icons.restart_alt_rounded),
                    iconSize: 60,
                    color: Theme.of(context).cardColor,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Routines',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline1!.color,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '$routineCount',
                          style: TextStyle(
                            color: Theme.of(context).textTheme.headline1!.color,
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
