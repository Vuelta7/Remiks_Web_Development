import 'dart:math';

import 'package:flutter/material.dart';
import 'package:remiksweb/home/home_main.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _loadingController;
  late Animation<double> _logoAnimation;
  late Animation<double> _loadingAnimation;

  final List<String> _products = [
    'assets/chili_shots.png',
    'assets/ginisang_alamang.png',
    'assets/sawsaw_suka.png',
    'assets/chicken_pastil.png',
    'assets/hot_sauce.png',
    'assets/chili_garlic.png',
  ];

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _loadingController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _logoAnimation = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeIn,
    );

    _loadingAnimation = CurvedAnimation(
      parent: _loadingController,
      curve: Curves.easeIn,
    );

    _logoController.forward();
    _loadingController.forward();

    _loadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeMain(),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _loadingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 32, 35),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            FadeTransition(
              opacity: _logoAnimation,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                child: Image.asset('assets/remiks_logo.png', width: 150),
              ),
            ),
            FadeTransition(
              opacity: _logoAnimation,
              child: SizedBox(
                width: 600,
                height: 600,
                child: Center(
                  child: Stack(
                    children: _products.asMap().entries.map((entry) {
                      int index = entry.key;
                      String product = entry.value;
                      double angle =
                          (index / _products.length) * 2 * 3.141592653589793;
                      return AnimatedBuilder(
                        animation: _loadingAnimation,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(
                              160 *
                                  cos(angle +
                                      _loadingAnimation.value *
                                          2 *
                                          3.141592653589793),
                              160 *
                                  sin(angle +
                                      _loadingAnimation.value *
                                          2 *
                                          3.141592653589793),
                            ),
                            child: child,
                          );
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.hexagon_rounded,
                              size: 140,
                              color: Colors.white,
                            ),
                            Image.asset(
                              product,
                              width: 100,
                              height: 100,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
