import 'dart:convert';

import '../models/news.dart';
import 'package:http/http.dart' as http;

class ApiService {
 final endPointUrl = "https://newsapi.org/v2/top-headlines?country=id&apiKey=3947d865affd4e57a6ec0a7564afea76";

 Future <List<News>> getNews() async{
   final response = await http.get(Uri.tryParse(endPointUrl)!);

   if (response.statusCode == 200) {
     Map<String, dynamic> json = jsonDecode(response.body);

     List<dynamic> body = json['articles'];

     List<News> news = body.map((item) => News.fromJson(item)).toList();

     return news;
   } else {
     throw Exception("Can't get the News!");
   }
 }
}
