
import 'package:crypto_base/pages/search/search_events.dart';
import 'package:crypto_base/pages/search/search_streams.dart';
import 'package:crypto_base/repository/notice_repository/model/news.dart';
import 'package:crypto_base/repository/notice_repository/news_repository.dart';
import 'package:crypto_base/support/conection/api.dart';
import 'package:bsev/bsev.dart';

class SearchBloc extends BlocBase<SearchStreams,SearchEvents>{

  final NewsRepository repository;

  SearchBloc(this.repository);

  @override
  void initView() {
  }

  @override
  void eventReceiver(SearchEvents event) {
    if(event is LoadSearch){
      _load(event.data);
    }
  }

  _load(String query){

    if(streams.news.value != null){
      return;
    }

    streams.progress.set(true);
    streams.error.set(false);

    repository.loadSearch(query)
        .then((news) => _showNews(news))
        .catchError(_showImplError);

  }

  _showNews(List<News> news) {

    streams..progress.set(false);
    if(news.length > 0) {
      streams.news.set(news);
      dispatchView(InitAnimation());
      streams.empty.set(false);
    }else{
      streams.empty.set(true);
    }
  }

  _showImplError(onError) {

    print(onError);
    if(onError is FetchDataException){
      print("codigo: ${onError.code()}");
    }
    streams.error.set(true);
    streams.progress.set(false);

  }

}
