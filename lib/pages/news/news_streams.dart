import 'package:crypto_base/repository/notice_repository/model/news.dart';
import 'package:bsev/bsev.dart';

class NewsStreams implements StreamsBase {
  BehaviorSubjectCreate<bool> errorConection = BehaviorSubjectCreate();
  BehaviorSubjectCreate<bool> progress = BehaviorSubjectCreate();
  BehaviorSubjectCreate<List<News>> news = BehaviorSubjectCreate();
  BehaviorSubjectCreate<List<String>> categoriesName = BehaviorSubjectCreate();

  @override
  void dispose() {
    progress.close();
    errorConection.close();
    news.close();
    categoriesName.close();
  }
}
