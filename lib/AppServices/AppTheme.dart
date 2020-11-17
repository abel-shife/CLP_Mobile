
import 'package:flutter/material.dart';

class AppTheme{
  static final ThemeData lightTheme=ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(
            color: Colors.white,
          )
      )
  );

  static final ThemeData darkTheme=ThemeData(
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
          color: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          )
      )
  );
}