import 'package:crypto_base/support/di/inject_bloc.dart';
import 'package:crypto_base/support/di/inject_repository.dart';
import 'package:crypto_base/support/localization/MyLocalizationsDelegate.dart';
import 'package:bsev/bsev.dart';
import 'package:bsev/flavors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:crypto_base/pages/home/home_view.dart';

void main() => runApp(new NewsApp());

class NewsApp extends StatelessWidget {
  MyLocalizationsDelegate myLocation = const MyLocalizationsDelegate();

  NewsApp() {
    Flavors.configure(Flavor.PROD);
    injectRepository(Injector.appInstance);
    injectBloc(Injector.appInstance);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CryptoNinja',
      theme: new ThemeData(
          primarySwatch: Colors.deepOrange,
          primaryColor: Colors.deepOrange,
          accentColor: Colors.deepOrange,
          brightness: Brightness.light),
      supportedLocales: MyLocalizationsDelegate.supportedLocales(),
      localizationsDelegates: [
        myLocation,
        DefaultCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: myLocation.resolution,
      home: HomeView().create(),
    );
  }
}
