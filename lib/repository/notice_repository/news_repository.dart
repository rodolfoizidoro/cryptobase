import 'package:crypto_base/support/conection/api.dart';
import 'model/news.dart';
import 'package:http/http.dart';

abstract class NewsRepository {
  Future<List<News>> loadNews();

  Future<List<News>> loadSearch(String query);
}

class NewsRepositoryImpl implements NewsRepository {
  final Api _api;

  NewsRepositoryImpl(this._api);

  Future<List<News>> loadNews() async {
    final List result = await _api.get(
        "https://cryptocontrol.io/api/v1/public/news?key=8c697a23a2ce987425a5f54510df25d4");
    List<News> list = List();
    result.forEach((item) {
      list.add(new News.fromMap(item));
    });

    return list;
  }

  Future<List<News>> loadSearch(String query) async {
    final List result = await _api.get(
        "https://cryptocontrol.io/api/v1/public/news/coin/$query?latest=true&key=8c697a23a2ce987425a5f54510df25d4");

    if (result.isNotEmpty) {
      List<News> list = List();
      result.forEach((item) {
        list.add(new News.fromMap(item));
      });
      return list;
    } else {
      return List();
    }
  }
}
