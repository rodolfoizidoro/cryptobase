import 'package:crypto_base/repository/notice_repository/model/highlight.dart';
import 'package:bsev/bsev.dart';

class FeaturedStreams implements StreamsBase{

  BehaviorSubjectCreate<bool> progress = BehaviorSubjectCreate();
  BehaviorSubjectCreate<bool> errorConnection = BehaviorSubjectCreate();
  BehaviorSubjectCreate<List<Highlight>> highlights = BehaviorSubjectCreate();

  @override
  void dispose() {
    progress.close();
    errorConnection.close();
    highlights.close();
  }

}
