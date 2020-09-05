import 'package:dio/dio.dart';
import 'package:newsappbloc/model/Article.dart';
import 'package:newsappbloc/model/SourceReponse.dart';

class NewsRepository {
  static String mainUrl = "http://newsapi.org/v2/";
  static String apiKey = "e4b0e0346cd54056a4706de35f8546fe";
  final Dio _dio = Dio();
  var getSourcesUrl = "$mainUrl/sources";
  var getTopHeadLinesUrl = "$mainUrl/top-headlines";
  var everythingUrl = "$mainUrl/everything";

  Future <SourceResponse>getSources()async{
    var params ={
      "apiKey" :apiKey,
      "language": "en",
      "country":"us"
    };
    try {
      Response response = await _dio.get(getSourcesUrl,queryParameters: params);
      return SourceResponse.fromJson(response.data);
    } catch (error,stacktrace) {
      print('Exception occured: $error stacktrace: $stacktrace');
      throw Exception();
    } 
  }

  Future <Article>getTopHeadlines()async{
    var params ={
      "apiKey" :apiKey,      
      "country":"us"
    };
    try {
      Response response = await _dio.get(getTopHeadLinesUrl,queryParameters: params);
      return Article.fromJson(response.data);
    } catch (error,stacktrace) {
      print('Exception occured: $error stacktrace: $stacktrace');
      throw Exception();
    } 
  }

  Future <Article>getHotNews()async{
    var params ={
      "apiKey" :apiKey,
      "q":"apple",      
      "sortBy":"popularity"
    };
    try {
      Response response = await _dio.get(everythingUrl,queryParameters: params);
      return Article.fromJson(response.data);
    } catch (error,stacktrace) {
      print('Exception occured: $error stacktrace: $stacktrace');
      throw Exception();
    } 
  }

  Future <Article>getSourceNews(String sourceId)async{
    var params ={
      "apiKey" :apiKey,      
      "sources":sourceId
    };
    try {
      Response response = await _dio.get(getTopHeadLinesUrl,queryParameters: params);
      return Article.fromJson(response.data);
    } catch (error,stacktrace) {
      print('Exception occured: $error stacktrace: $stacktrace');
      throw Exception();
    } 
  }
  Future <Article>search(String searchValue)async{
    var params ={
      "apiKey" :apiKey,
      "q":searchValue,
    };
    try {
      Response response = await _dio.get(getTopHeadLinesUrl,queryParameters: params);
      return Article.fromJson(response.data);
    } catch (error,stacktrace) {
      print('Exception occured: $error stacktrace: $stacktrace');
      //throw Exception();
    } 
  }
}
