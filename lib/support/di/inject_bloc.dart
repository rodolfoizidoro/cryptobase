import 'package:crypto_base/pages/featured/featured_bloc.dart';
import 'package:crypto_base/pages/featured/featured_streams.dart';
import 'package:crypto_base/pages/home/home_bloc.dart';
import 'package:crypto_base/pages/home/home_streams.dart';
import 'package:crypto_base/pages/news/news_bloc.dart';
import 'package:crypto_base/pages/news/news_streams.dart';
import 'package:crypto_base/pages/search/search_result_bloc.dart';
import 'package:crypto_base/pages/search/search_streams.dart';
import 'package:bsev/bsev.dart';

injectBloc(Injector injector) {
  injector.registerDependency((i) => NewsBloc(i.getDependency()));
  injector.registerDependency((i) => NewsStreams());

  injector.registerDependency((i) => FeaturedBloc(i.getDependency()));
  injector.registerDependency((i) => FeaturedStreams());

  injector.registerDependency((i) => HomeBloc());
  injector.registerDependency((i) => HomeStreams());

  injector.registerDependency((i) => SearchBloc(i.getDependency()));
  injector.registerDependency((i) => SearchStreams());
}
