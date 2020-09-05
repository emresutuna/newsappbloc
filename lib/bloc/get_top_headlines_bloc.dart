import 'package:newsappbloc/model/Article.dart';
import 'package:newsappbloc/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class GetTopHeadlinesBloc {
  final NewsRepository _repository =NewsRepository();
  final BehaviorSubject<Article>_subject=
  BehaviorSubject<Article>();
  getHeadlines()async{
    Article response =await _repository.getTopHeadlines();
    _subject.sink.add(response);
  }
  dipose(){
    _subject.close();
  }
  BehaviorSubject<Article> get subject => _subject;
}
final getTopHeadlinesBloc = GetTopHeadlinesBloc();