import 'package:crypto_base/pages/featured/featured_view.dart';
import 'package:crypto_base/pages/home/home_bloc.dart';
import 'package:crypto_base/pages/home/home_streams.dart';
import 'package:crypto_base/pages/info/info.dart';
import 'package:crypto_base/pages/news/news_view.dart';
import 'package:crypto_base/widgets/bottom_navigation.dart';
import 'package:crypto_base/widgets/search.dart';
import 'package:bsev/bsev.dart';
import 'package:flutter/material.dart';

class HomeView extends BlocStatelessView<HomeBloc,HomeStreams> {

  @override
  void eventReceiver(EventsBase event) {
  }

  @override
  Widget buildView(BuildContext context, HomeStreams streams) {
    return new Scaffold(
      body: new Container(
        color: Colors.grey[200],
        child:  new Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Container(child: new SearchWidget(),),
            new Expanded(
                child: _getContent(streams)
            )
          ],
        ),
      ),
      bottomNavigationBar: new BottomNavigation((index){
        streams.tabPosition.set(index);
      }),
    );
  }

  Widget _getContent(HomeStreams streams){
    return StreamBuilder(
        stream: streams.tabPosition.get,
        initialData: 0,
        builder:  (BuildContext context, AsyncSnapshot snapshot){

          var position = snapshot.hasData ? snapshot.data:0;

          switch(position){
            case 0:return FeaturedView().create();break;
            case 1: return NewsView().create();break;
            case 2: return Info();
          }

        }
    );
  }

}
