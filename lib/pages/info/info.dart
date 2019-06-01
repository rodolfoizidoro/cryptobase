import 'package:crypto_base/support/util/StringsLocation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));

    CurvedAnimation curve =
        CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animation = Tween(begin: 0.0, end: 1.0).animate(curve);

    super.initState();

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new ScaleTransition(
      scale: animation,
      child: new Container(
        margin: new EdgeInsets.all(30.0),
        child: new Center(
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              _getTittle(),
              _getContent(getString("text_info")),
              _getContentSecond(
                  "Framework", "flutter.io", "https://flutter.io/"),
              _getContentSecond("Repository", "Crypto Base",
                  "https://github.com/rodolfoizidoro/cryptobase"),
              _getContentSecond("Developer", "Lucas Pedrazoli",
                  "https://github.com/lucaspedrazoli"),
              _getContentSecond("Developer", "Rodolfo Izidoro",
                  "https://github.com/rodolfoizidoro"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getTittle() {
    return Center(
      child: new Text(
        "CryptoNinja",
        style: new TextStyle(color: Colors.black, fontSize: 50.0),
      ),
    );
  }

  Widget _getContent(String text) {
    return new Container(
      margin: new EdgeInsets.only(top: 20.0, bottom: 10.0),
      child: new Text(text,
          textAlign: TextAlign.center, style: new TextStyle(fontSize: 20.0)),
    );
  }

  Widget _getContentSecond(tittle, tittleLink, link) {
    return new Container(
      margin: new EdgeInsets.only(top: 10.0),
      child: new Column(
        children: <Widget>[
          new Text(
            tittle,
            style: new TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          new GestureDetector(
            child: new Text(
              tittleLink,
              style: new TextStyle(color: Colors.deepOrange, fontSize: 25.0),
            ),
            onTap: () {
              _launchURL(link);
            },
          )
        ],
      ),
    );
  }

  _launchURL(url) async {
    await launch(url);
  }
}
