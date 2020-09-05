import 'package:newsappbloc/model/SourceReponse.dart';
import 'package:newsappbloc/repository/Repository.dart';
import 'package:rxdart/rxdart.dart';

class GetSourceBloc {
  final NewsRepository _repository =NewsRepository();
  final BehaviorSubject<SourceResponse>_subject=
  BehaviorSubject<SourceResponse>();
  getSources()async{
    SourceResponse response=await _repository.getSources();
    _subject.sink.add(response);
  }
  dispose(){
    _subject.close();
  }
  BehaviorSubject<SourceResponse> get subject=> _subject;
}
final getSourcesBloc=GetSourceBloc();