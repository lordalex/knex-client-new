import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyCGLVJ17ORtlZDj9HJy_m-ve1JT-X6pGoE",
            authDomain: "knex-client24.firebaseapp.com",
            projectId: "knex-client24",
            storageBucket: "knex-client24.appspot.com",
            messagingSenderId: "1045566810040",
            appId: "1:1045566810040:web:5e2c46c1cec3256028514d",
            measurementId: "G-E04LF7XRFQ"));
  } else {
    await Firebase.initializeApp();
  }
}
