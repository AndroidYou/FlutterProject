import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterproject/view/GradientCircularProgressIndicator.dart';

import '../home/HomeRoute.dart';

class SplashRoute extends StatefulWidget {
  const SplashRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  var imageUrl =
      "https://img2.baidu.com/it/u=676258172,2884080302&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889";
  int currentTimer = 0;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      currentTimer++;
      if (currentTimer == 4) {
        timer.cancel();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const NewHomeRoute()), (route) => false);

      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    if (timer.isActive) {
      timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
              right: 10,
              top: 10,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GradientCircularProgressIndicator(
                      radius: 20, value: currentTimer / 4),
                  Text(
                    '$currentTimer',
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        color: Colors.amber),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
