import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late Animation<double> rippleAnimation;
  late Animation<double> scaleAnimation;

  late AnimationController rippleController;
  late AnimationController scaleController;
  @override
  void initState() {
    rippleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    rippleAnimation =
        Tween<double>(begin: 80, end: 90).animate(rippleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rippleController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              rippleController.forward();
            }
          });
    scaleController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..addStatusListener((status) {});
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(scaleController);
    rippleController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(children: [
        itemPage(image: 'assets/images/1.jpg'),
        itemPage(image: 'assets/images/2.jpg'),
        itemPage(image: 'assets/images/3.jpg'),
      ]),
    );
  }

  Widget itemPage({image}) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover)),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, stops: [
          0.1,
          0.9
        ], colors: [
          Colors.black.withOpacity(.1),
          Colors.black.withOpacity(.7)
        ])),
        child: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Exerciese',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '15',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Minutes',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '3',
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Exerciese',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30),
                ),
                SizedBox(
                  height: 120,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Start the moring with your health',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.4), fontSize: 35),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: AnimatedBuilder(
                          animation: rippleAnimation,
                          builder: (context, child) => Container(
                                width: rippleAnimation.value,
                                height: rippleAnimation.value,
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(.4)),
                                  child: InkWell(
                                    onTap: () {
                                      scaleController.forward();
                                    },
                                    child: AnimatedBuilder(
                                      animation: scaleAnimation,
                                      builder: (context, child) =>
                                          Transform.scale(
                                        scale: scaleAnimation.value,
                                        child: Container(
                                          margin: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
