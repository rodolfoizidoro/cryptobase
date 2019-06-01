
import 'package:crypto_base/repository/notice_repository/model/notice.dart';
import 'package:crypto_base/repository/notice_repository/model/highlight.dart';
import 'package:crypto_base/support/conection/api.dart';

abstract class NoticeRepository{
  Future<List<Notice>> loadNews(String category, int page);
  Future<List<Highlight>> loadNewsRecent();
  Future<List<Notice>> loadSearch(String query);
}
class NoticeRepositoryImpl implements NoticeRepository{

  final Api _api;

  NoticeRepositoryImpl(this._api);

  Future<List<Notice>> loadNews(String category, int page) async {
    final Map result = await _api.get("/notice/news/$category/$page");
    return result['data']['news'].map<Notice>( (notice) => new Notice.fromMap(notice)).toList();
  }

  Future<List<Highlight>> loadNewsRecent() async {
    final List result = await _api.get("https://cryptocontrol.io/api/v1/public/news?latest=true&key=8c697a23a2ce987425a5f54510df25d4");

    List<Highlight> list = List();

    result.forEach((item){
      list.add(Highlight.fromMap(item));
    });

    return list;
  }

  Future<List<Notice>> loadSearch(String query) async {

    final Map result = await _api.get("/notice/search/$query");

    if(result['op']){
      return result['data'].map<Notice>( (notice) => new Notice.fromMap(notice)).toList();
    }else{
      return List();
    }
  }
}

