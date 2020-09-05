import 'package:newsappbloc/model/Article.dart';
import 'package:newsappbloc/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final NewsRepository _repository =NewsRepository();
  final BehaviorSubject<Article>_subject=
  BehaviorSubject<Article>();
  search(String value)async{
    if(value==""){
 
    }else{
 Article response = await _repository.search(value);
    _subject.sink.add(response);
    }
  
  }
  dispose(){
    _subject.close();
  }
  BehaviorSubject<Article> get subject => _subject;
}
final searchBloc = SearchBloc();