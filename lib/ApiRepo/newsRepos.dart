import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/Model/SearchModel.dart';
import 'package:newsapp/Model/TopHeadlines.dart';

class NewsRepository {


  Future<TopHeadlines> fetchNewsCategoires() async {
    String newsUrl =
         'https://newsapi.org/v2/top-headlines?country=in&apiKey=75749098b51144fe8385d42614058111';
    final response = await http.get(Uri.parse(newsUrl));

    if(response.statusCode == 429){
      print("You have sent many request");
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      return TopHeadlines.fromJson(body);
    } else {
      throw Exception('Error');
    }
  }

  Future<SearchModel> getSearched(String query) async {
    final url = 'https://newsapi.org/v2/everything?q=$query&apiKey=75749098b51144fe8385d42614058111';
    print(url);
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
      '75749098b51144fe8385d42614058111'
    });
    if(response.statusCode == 429){
      print("You have send many request");
    }
    else if (response.statusCode == 200) {
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load');
  }
}