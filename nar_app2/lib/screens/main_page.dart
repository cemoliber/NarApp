// Gerekli paketleri içe aktarın
// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:nar_app2/constant.dart';
import 'package:nar_app2/screens/a_twoPage.dart';
import 'package:nar_app2/screens/b_onePage.dart';
import 'package:nar_app2/screens/b_twoPage.dart';
import 'package:nar_app2/screens/home_screen.dart';

import '../services/google_ads.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(MyHomePage());
}

class _MyHomePageState extends State<MyHomePage> {
  //For Google Ads
  final GoogleAds _googleAds = GoogleAds();

  @override
  void initState() {
    //GoogleAds().loadInterstitialAd();
    GoogleAds().loadBannerAd(
      adLoaded: () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        shadowColor: Colors.transparent,
        title: Text('Nar App'),
      ),
      body: Center(
        // Center the buttons horizontally
        child: Column(
          // Arrange buttons vertically
          mainAxisAlignment: MainAxisAlignment.center, // Center vertically
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('A1 Testine Başla'),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                minimumSize:
                    Size(250, 60), // Yükseklik ve genişlik (piksel cinsinden)
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PageaTwo()),
                );
              },
              child: Text('A2 Testine Başla'),
              style: ElevatedButton.styleFrom(
                minimumSize:
                    Size(250, 60), // Yükseklik ve genişlik (piksel cinsinden)
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PagebOne()),
                );
              },
              child: Text('B1 Testine Başla'),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink,
                minimumSize:
                    Size(250, 60), // Yükseklik ve genişlik (piksel cinsinden)
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PagebTwo()),
                );
              },
              child: Text('B2 Testine Başla'),
              style: ElevatedButton.styleFrom(
                primary: Colors.purple,
                minimumSize:
                    Size(250, 60), // Yükseklik ve genişlik (piksel cinsinden)
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
