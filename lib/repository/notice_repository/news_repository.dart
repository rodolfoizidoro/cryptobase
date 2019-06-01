import 'package:crypto_base/repository/notice_repository/model/notice.dart';
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
    //list.add(News("https://assets.cryptocontrol.io/thumbnails/5cf29fa6a1688d0010597a7d-1559404454664.png", "Titulo da noticia", "22 dezembro", "descrição", "categoria", "https://cryptocontrol.io/r/api/article/5cf29fa6a1688d0010597a7d?ref=5cf28af2a1688d0010492429", "orige,"));

    result.forEach((item) {
      list.add(new News.fromMap(item));
    });

    return list; //result.map<Notice>( (notice) => new Notice.fromMap(notice)).toList();
  }

  Future<List<News>> loadSearch(String query) async {
    final Map result = await _api.get("/notice/search/$query");

    if (result['op']) {
      return List(); //result['data'].map<Notice>( (notice) => new Notice.fromMap(notice)).toList();
    } else {
      return List();
    }
  }
}
