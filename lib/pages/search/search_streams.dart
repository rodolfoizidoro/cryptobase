
import 'package:crypto_base/repository/notice_repository/model/news.dart';
import 'package:bsev/bsev.dart';

class SearchStreams implements StreamsBase{

  BehaviorSubjectCreate<bool> progress = BehaviorSubjectCreate();

  BehaviorSubjectCreate<bool> error = BehaviorSubjectCreate();

  BehaviorSubjectCreate<bool> empty = BehaviorSubjectCreate();

  BehaviorSubjectCreate<List<News>> news = BehaviorSubjectCreate();

  @override
  void dispose() {
    progress.close();
    error.close();
    empty.close();
    news.close();
  }

}
