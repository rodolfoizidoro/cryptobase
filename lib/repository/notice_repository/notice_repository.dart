import 'package:crypto_base/repository/notice_repository/model/highlight.dart';
import 'package:crypto_base/support/conection/api.dart';

abstract class NoticeRepository{
  Future<List<Highlight>> loadNewsRecent();
}
class NoticeRepositoryImpl implements NoticeRepository{
  final Api _api;
  NoticeRepositoryImpl(this._api);
  Future<List<Highlight>> loadNewsRecent() async {
    final List result = await _api.get("https://cryptocontrol.io/api/v1/public/news?latest=true&key=8c697a23a2ce987425a5f54510df25d4");

    List<Highlight> list = List();

    result.forEach((item){
      list.add(Highlight.fromMap(item));
    });

    return list;
  }
}

