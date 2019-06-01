import 'dart:async';
import 'package:crypto_base/pages/news/news_bloc.dart';
import 'package:crypto_base/pages/news/news_events.dart';
import 'package:crypto_base/pages/news/news_streams.dart';
import 'package:crypto_base/repository/notice_repository/model/news.dart';
import 'package:crypto_base/widgets/AnimatedContent.dart';
import 'package:crypto_base/widgets/custom_tab.dart';
import 'package:crypto_base/widgets/erro_conection.dart';
import 'package:flutter/material.dart';
import 'package:bsev/bsev.dart';

class NewsView extends BlocStatelessView<NewsBloc,NewsStreams> {

  @override
  Widget buildView(BuildContext context, NewsStreams streams) {

    return new Container(
        padding: EdgeInsets.only(top: 2.0),
        child: new Stack(
          children: <Widget>[
            _getListViewWidget(streams),
            _buildConnectionError(streams),
            _getProgress(streams),
            _getListCategory(streams),
          ],
        ));
  }

  Widget _buildConnectionError(NewsStreams streams) {
    return StreamBuilder(
        stream: streams.errorConection.get,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return ErroConection(tryAgain: () {
              dispatch(LoadNews()..data = false);
            });
          } else {
            return Container();
          }
        });
  }

  Widget _getListViewWidget(NewsStreams streams) {
    return Container(
      child: StreamBuilder(
          stream: streams.news.get,
          initialData: List<News>(),
          builder: (_, AsyncSnapshot snapshot) {

            if(snapshot.hasData){

              List news = snapshot.data;

              ListView listView = new ListView.builder(
                  itemCount: news.length,
                  padding: new EdgeInsets.only(top: 5.0),
                  itemBuilder: (context, index) {

                    if (index == 0) {

                      return Container(
                        margin: EdgeInsets.only(top: 50.0),
                        child: news[index],
                      );

                    } else {

                      if (index + 1 >= news.length) {
                        dispatch(LoadMoreNews());
                      }

                      return news[index];
                    }
                  });

              return AnimatedContent(
                show: news.length > 0,
                child: RefreshIndicator(onRefresh: myRefresh, child: listView),
              );

            }else{

              return Container();

            }

          }
          ),
    );
  }

  Widget _getProgress(NewsStreams streams) {
    return Center(
      child: StreamBuilder(
          stream: streams.progress.get,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data) {
              return new CircularProgressIndicator();
            } else {
              return new Container();
            }
          }),
    );
  }

  Widget _getListCategory(NewsStreams streams) {
    return StreamBuilder(
      stream: streams.categoriesName.get,
      builder: (_,snapshot){

        if(snapshot.hasData){
          List<String> list = snapshot.data;
          return AnimatedOpacity(
            opacity: 1,
            duration: Duration(milliseconds: 300),
            child: CustomTab(
              itens: list,
              tabSelected: (index) {
                dispatch(ClickCategory()..data = index);
              },
            ),
          );
        }else{
          return AnimatedOpacity(
            opacity: 0,
            duration: Duration(milliseconds: 300),
          );
        }

      },
    );

  }

  Future<Null> myRefresh() async {
    dispatch(LoadNews());
  }

  @override
  void eventReceiver(EventsBase event) {

  }

}
