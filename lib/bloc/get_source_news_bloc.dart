import 'package:flutter/material.dart';
import 'package:newsappbloc/model/Article.dart';
import 'package:newsappbloc/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class GetSourceNewsBloc {
  final NewsRepository _repository=NewsRepository();
  final BehaviorSubject<Article> _subject=
        BehaviorSubject<Article>();
  GetSourceNews(String sourceId )async{
    Article response=await _repository.getSourceNews(sourceId);
    _subject.sink.add(response);
  }
  void drainStream(){_subject.value=null;}
  @mustCallSuper
  void dispose()async{
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<Article>get subject=> _subject;
}
final getSourceNewsBloc =GetSourceNewsBloc();