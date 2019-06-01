
import 'package:crypto_base/repository/notice_repository/model/news.dart';
import 'package:crypto_base/repository/notice_repository/model/notice.dart';
import 'package:bsev/bsev.dart';

class SearchStreams implements StreamsBase{

  BehaviorSubjectCreate<bool> progress = BehaviorSubjectCreate();

  BehaviorSubjectCreate<bool> error = BehaviorSubjectCreate();

  BehaviorSubjectCreate<bool> empty = BehaviorSubjectCreate();

  BehaviorSubjectCreate<List<Notice>> noticies = BehaviorSubjectCreate();
  BehaviorSubjectCreate<List<News>> news = BehaviorSubjectCreate();

  @override
  void dispose() {
    progress.close();
    error.close();
    empty.close();
    noticies.close();
    news.close();
  }

}
