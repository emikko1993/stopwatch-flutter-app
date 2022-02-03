import 'dart:async';

import 'package:flutter/material.dart';

import 'widgets/custom_button.dart';

class StopWatchView extends StatefulWidget {
  const StopWatchView({Key? key}) : super(key: key);

  @override
  _StopWatchViewState createState() => _StopWatchViewState();
}

class _StopWatchViewState extends State<StopWatchView> {
  int seconds = 0;
  int minutes = 0;
  int hours = 0;
  String digitSeconds = '00';
  String digitMinutes = '00';
  String digitHours = '00';
  Timer? timer;
  bool started = false;
  List laps = [];

  void stop() {
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitSeconds = '00';
      digitMinutes = '00';
      digitHours = '00';
    });
    laps.clear();
  }

  void addLaps() {
    String lap = '$digitHours:$digitMinutes:$digitSeconds';
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinutes = minutes;
      int localHours = hours;

      if (localSeconds > 59) {
        if (localMinutes > 59) {
          localHours++;
          localMinutes = 0;
        } else {
          localMinutes++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinutes;
        hours = localHours;
        digitSeconds = (seconds >= 10) ? '$seconds' : '0$seconds';
        digitMinutes = (minutes >= 10) ? '$minutes' : '0$minutes';
        digitHours = (hours >= 10) ? '$hours' : '0$hours';
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 249, 255, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromRGBO(132, 100, 255, 1),
          ),
          child: const Text(
            'Stopwatch',
            style: TextStyle(),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: Text(
                '$digitHours:$digitMinutes:$digitSeconds',
                style: TextStyle(fontSize: 36),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: laps.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Lap ${index + 1}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          laps[index],
                        ),
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  title: started ? 'Stop' : 'Start',
                  backgroundColor: Color.fromRGBO(130, 100, 255, 1),
                  titleColor: Colors.white,
                  onTap: () => started ? stop : start,
                ),
                IconButton(
                  onPressed: () {
                    addLaps();
                  },
                  icon: Icon(Icons.ac_unit),
                ),
                CustomButton(
                  title: 'Reset',
                  backgroundColor: Color.fromRGBO(248, 240, 250, 1),
                  titleColor: Color.fromRGBO(250, 180, 186, 1),
                  onTap: () => reset,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
