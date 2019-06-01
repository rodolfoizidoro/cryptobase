import 'package:crypto_base/pages/featured/featured_events.dart';
import 'package:crypto_base/pages/featured/featured_streams.dart';
import 'package:crypto_base/repository/notice_repository/model/highlight.dart';
import 'package:crypto_base/repository/notice_repository/notice_repository.dart';
import 'package:crypto_base/support/conection/api.dart';
import 'package:bsev/bsev.dart';

class FeaturedBloc extends BlocBase<FeaturedStreams, FeaturedEvents> {
  final NoticeRepository repository;

  FeaturedBloc(this.repository);

  @override
  void initView() {
    _load();
  }

  @override
  void eventReceiver(FeaturedEvents event) {
    if (event is LoadFeatured) {
      _load();
    }
  }

  _load() {
    streams.progress.set(true);
    streams.errorConnection.set(false);

    repository
        .loadNewsRecent()
        .then((news) => _showNews(news))
        .catchError(_showImplError);
  }

  _showNews(List<Highlight> news) {
    streams.progress.set(false);
    streams.highlights.set(news);
  }

  _showImplError(onError) {
    print(onError);
    if (onError is FetchDataException) {
      print("codigo: ${onError.code()}");
    }
    streams.errorConnection.set(true);
    streams.progress.set(false);
  }
}
