import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SliderWidget extends StatefulWidget {
  final String fanName, fanID;
  const SliderWidget({Key? key, required this.fanName, required this.fanID})
      : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget>
    with TickerProviderStateMixin {
  bool isFanOff = false;
  final List<bool> isSelected = [true, false, false];
  double speed = 0;
  final List<int> duration = [10000, 1000, 800, 600, 400, 200];

  ///keeping track of all three factors - even index will do the task
  int selectedIndex = 0;
  Color lightColor = const Color(0xFF7054FF);
  String fanImage = 'assets/images/fan.png';
  late final AnimationController _controller;
  late final AnimationController _noController;

  int getDuration(double speed) {
    if (speed == 0) return duration[0].toInt();
    if (speed == 20) {
      return duration[1].toInt();
    }
    if (speed == 40) {
      return duration[2].toInt();
    }
    if (speed == 60) {
      return duration[3].toInt();
    }
    if (speed == 80) {
      return duration[4].toInt();
    }
    if (speed == 100) {
      return duration[5].toInt();
    } else {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    _noController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1000),
    )..repeat();
    if (kDebugMode) {
      print(speed);
    }
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: getDuration(speed)),
    )..repeat();
  }

  void changespeed(AnimationController c) {
    c.duration = Duration(milliseconds: getDuration(speed));
    if (c.isAnimating) c.forward();
    c.repeat();
  }

  @override
  void dispose() {
    _noController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void fanSwitch(bool value) {
    setState(() {
      isFanOff = value;
    });
  }

  void onToggleTapped(int index) {
    for (int i = 0; i < isSelected.length; i++) {
      setState(() {
        isSelected[i] = i == index;
      });
    }
  }

  void changeSpeed(newVal) {
    setState(() {
      speed = newVal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 15,
                top: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Text(
                              'Living\nRoom',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontSize: 45,
                                    color: const Color(0xFFBDBDBD)
                                        .withOpacity(0.5),
                                  ),
                            ),
                            Text(
                              widget.fanName + "\n" + widget.fanID,
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Text(
                          'Power',
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Switch.adaptive(
                          inactiveThumbColor: const Color(0xFFE4E4E4),
                          inactiveTrackColor: Colors.white,
                          activeColor: Colors.white,
                          activeTrackColor: const Color(0xFF464646),
                          value: isFanOff,
                          onChanged: (value) {
                            fanSwitch(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(width: 10,),
            Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 350,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Lottie.asset(
                    'assets/lottie/fan.json',
                    // width: 260,
                    // height: 250,
                    fit: BoxFit.contain,
                    animate: isFanOff ? true : false,
                    controller: isFanOff ? _controller : _noController,
                  ),
                )
              ],
            ),
            const Padding(
                padding: EdgeInsets.only(
              right: 10,
            )),
          ],
        ),
        SizedBox(
          height: 50,
        ),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Mode', style: TextStyle(fontSize: 18)),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: Center(
                  child: ToggleButtons(
                    selectedColor: Colors.white,
                    fillColor: const Color(0xFF464646),
                    renderBorder: false,
                    borderRadius: BorderRadius.circular(15),
                    textStyle: TextStyle(fontSize: 20),
                    children: <Widget>[
                      SizedBox(
                        width: 100,
                        child: const Text(
                          'Air',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: const Text(
                          'Mild',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: const Text(
                          'Breeze',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    onPressed: (int index) {
                      onToggleTapped(index);
                    },
                    isSelected: isSelected,
                  ),
                ),
              )
            ])),
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Speed',
                style: TextStyle(fontSize: 18),
              ),
              Text(
                '${speed.toInt()}',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SfSlider(
            min: 0,
            max: 100,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            value: speed,
            interval: 20,
            // showLabels: true,
            stepSize: 20,
            // showTicks: true,
            enableTooltip: true,
            onChanged: (dynamic value) {
              setState(() {
                changespeed(_controller);
                speed = value;
              });
            },
          ),
        ),
      ],
    ));
  }
}
