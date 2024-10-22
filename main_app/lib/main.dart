import 'package:main_app/initializeApp.dart';
import 'package:main_app/splash/screen/splash_view.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? bearerToken =  "eyJhbGciOiJIUzI1NiJ9.eyJuYmYiOjE3Mjk1OTY4MTcsImV4cCI6MTczMjE4ODgxNywiaWF0IjoxNzI5NTk2ODE3LCJqdGkiOiI1NTYxNjU0Yy1iMDA2LTQ3MGItOWI4Yy01MGUyMjM3MDllMzciLCJpc3MiOiJpc3N1ZXIgdmFsdWUiLCJhdWQiOiJhdWRpZW5jZSB2YWx1ZSIsInN1YiI6IjA4ZWI4MTBlLWQzOWItNGZlNS05ZDZlLTYxZjE4YzIxNTQwMyJ9.jow37lsrS8ZKoUGuJxRmAiKmNFlnL5bpc8T1QNfCSk4";

  await initializeApp(const SplashView(), environment: 'dev',token: bearerToken);

}