import 'package:main_app/initializeApp.dart';
import 'package:main_app/splash/screen/splash_view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? bearerToken =  "eyJhbGciOiJIUzI1NiJ9.eyJuYmYiOjE3MjcxMDY5NTgsImV4cCI6MTcyOTY5ODk1OCwiaWF0IjoxNzI3MTA2OTU4LCJqdGkiOiJlMzhjY2ViZC0wOTA3LTRlYjUtYjQ1OC1jMmYyOGE3ODU1YmYiLCJpc3MiOiJpc3N1ZXIgdmFsdWUiLCJhdWQiOiJhdWRpZW5jZSB2YWx1ZSIsInN1YiI6IjIyNDk2NWRlLTU5ZjMtNDljMy1hYTFiLTcyZjg4NjdhMWFhYiJ9.2kTaMig57_xone_K6J4nsFaOFJZJhdkNP0-VXYzd3zU";

  await initializeApp(const SplashView(), environment: 'dev',token: bearerToken);

}