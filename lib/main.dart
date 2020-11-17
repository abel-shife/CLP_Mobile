import 'dart:convert';

import 'package:finalloyal/AppServices/AppTheme.dart';
import 'package:finalloyal/AppServices/RouteGenerator.dart';
import 'package:finalloyal/Screens/both/getting_started.dart';
import 'package:finalloyal/models/client_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Screens/SignedUp/SignedUpHome.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  Client client;
  if (preferences.getString('client') != null)
    client = Client.fromJson(jsonDecode(preferences.getString('client')));

  runApp(MaterialApp(
      title: 'Loyal',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
      routes: {
        '/': (context) => client == null ? GettingStarted() : SignedUpHome(client),
      }));
}
