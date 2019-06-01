import 'package:bsev/bsev.dart';
import 'package:crypto_base/pages/news/news_events.dart';
import 'package:crypto_base/pages/news/news_streams.dart';
import 'package:crypto_base/repository/notice_repository/model/news.dart';
import 'package:crypto_base/repository/notice_repository/news_repository.dart';
import 'package:crypto_base/support/conection/api.dart';
import 'package:crypto_base/support/util/StringsLocation.dart';

class NewsBloc extends BlocBase<NewsStreams, NewsEvents> {
  final NewsRepository repository;

  int _page = 0;
  int _currentCategory = 0;
  List<String> _categories = [
    'bitcoin',
    'ethereum',
    'ripple',
    'litecoin',
    'dash',
    'iota'
  ];
  List<String> _categoriesNames = List();
  List<News> _newsInner = List();
  bool _carregando = false;

  NewsBloc(this.repository) {
    _categoriesNames.add(getString("category_btc"));
    _categoriesNames.add(getString("category_eth"));
    _categoriesNames.add(getString("category_xrp"));
    _categoriesNames.add(getString("category_ltc"));
    _categoriesNames.add(getString("category_dash"));
    _categoriesNames.add(getString("category_iota"));
  }

  @override
  void initView() {
    streams.categoriesName.set(_categoriesNames);
    _load(false);
  }

  @override
  void eventReceiver(event) {
    if (event is LoadNews) {
      _load(false);
    }

    if (event is LoadMoreNews) {
      _load(true);
    }

    if (event is ClickCategory) {
      _currentCategory = event.data;
      cleanList();
      _load(false);
    }
  }

  _load(bool isMore) {
    if (!_carregando) {
      _carregando = true;

      if (isMore) {
        _page++;
      } else {
        _page = 0;
      }

      streams.errorConection.set(false);

      streams.progress.set(true);

      String category = _categories[_currentCategory];

      repository
          .loadNews()
          .then((news) => _showNews(news, isMore))
          .catchError(_showImplError);
    }
  }

  _showNews(List<News> news, bool isMore) {
    streams.progress.set(false);

    if (isMore) {
      _newsInner.addAll(news);
    } else {
      _newsInner = news;
    }

     streams.news.set(_newsInner);

    _carregando = false;
  }

  _showImplError(onError) {
    print(onError);
    if (onError is FetchDataException) {
      print("codigo: ${onError.code()}");
    }
    streams.errorConection.set(true);
    streams.progress.set(false);
    _carregando = false;
  }

  void cleanList() {
    _newsInner = List();
    //streams.noticies.set(_newsInner);
  }
}
