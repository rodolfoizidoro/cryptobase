import 'package:crypto_base/pages/featured/featured_events.dart';
import 'package:crypto_base/pages/featured/featured_bloc.dart';
import 'package:crypto_base/pages/featured/featured_streams.dart';
import 'package:crypto_base/repository/notice_repository/model/highlight.dart';
import 'package:crypto_base/widgets/erro_conection.dart';
import 'package:crypto_base/widgets/pageTransform/intro_page_item.dart';
import 'package:crypto_base/widgets/pageTransform/page_transformer.dart';
import 'package:bsev/bsev.dart';
import 'package:flutter/material.dart';

class FeaturedView extends BlocStatelessView<FeaturedBloc,FeaturedStreams> {

  @override
  Widget buildView(BuildContext context, FeaturedStreams streams) {

    return Stack(
      children: <Widget>[
        new Stack(
          children: <Widget>[
            new Container(
              child: _buildFeatureds(streams),
            ),
            _getProgress(streams)
          ],
        ),
        _buildErrorConnection(streams)
      ],
    );
  }

  Widget _getProgress(FeaturedStreams streams) {

    return StreamBuilder(
        initialData: false,
        stream: streams.progress.get,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return new Container(
              child: new Center(
                child: new CircularProgressIndicator(),
              ),
            );
          } else {
            return new Container();
          }
        }
        );
  }

  _buildFeatureds(FeaturedStreams streams) {

    return StreamBuilder(
        initialData: List<Highlight>(),
        stream: streams.highlights.get, //my model
        builder: (BuildContext context, AsyncSnapshot snapshot) {

          List _destaque = snapshot.data;
          var length = snapshot.hasData ? _destaque.length : 0;

          Widget fearured = PageTransformer(
              pageViewBuilder: (context, visibilityResolver) {
                return new PageView.builder(
                  controller: new PageController(viewportFraction: 0.9),
                  itemCount: length,
                  itemBuilder: (context, index) {
                    final item = IntroNews.fromNotice(_destaque[index]);
                    final pageVisibility =
                    visibilityResolver.resolvePageVisibility(index);
                    return new IntroNewsItem(
                        item: item, pageVisibility: pageVisibility);
                  },
                );
              });

          return AnimatedOpacity(
              opacity: length > 0 ? 1 : 0,
              duration: Duration(milliseconds: 300),
              child: fearured,
          );

        });
  }

  Widget _buildErrorConnection(FeaturedStreams streams) {
    return StreamBuilder(
        stream: streams.errorConnection.get,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return ErroConection(tryAgain: () {
              dispatch(LoadFeatured());
            });
          } else {
            return Container();
          }
        });
  }

  @override
  void eventReceiver(EventsBase event) {
  }

}
