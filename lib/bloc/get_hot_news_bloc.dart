import 'package:newsappbloc/model/Article.dart';
import 'package:newsappbloc/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class GetHotNewsBloc {
  final NewsRepository _repository =NewsRepository();
  final BehaviorSubject<Article>_subject=
  BehaviorSubject<Article>();

getHotNews()async{
  Article response= await _repository.getHotNews();
  _subject.sink.add(response);
}
dispose(){
  _subject.close();
}
BehaviorSubject<Article> get subject =>_subject;
}
final getHotNewsBloc=GetHotNewsBloc();