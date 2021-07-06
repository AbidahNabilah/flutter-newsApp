import 'package:flutter/material.dart';
import 'package:news_app/constants.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/views/read_news_view.dart';
import 'package:news_app/widgets/primary_card.dart';
import 'package:news_app/widgets/secondary_card.dart';
 
import '../widgets/primary_card.dart';
import 'read_news_view.dart';
 
class PopularTabView extends StatefulWidget {
  @override
 _PopularTabViewState createState() => _PopularTabViewState();
}
 
class _PopularTabViewState extends State<PopularTabView> {
 
 late Future<List<News>> getNews;
 
 @override
 void initState(){
   super.initState();
   getNews = ApiService().getNews();
 }
 
 @override
 Widget build(BuildContext context) {
   return Container(
     child: ListView(
       children: [
         Container(
           width: double.infinity,
           height: 300.0,
           padding: EdgeInsets.only(left: 18.0),
           child: FutureBuilder (
             future: getNews,
             builder: (context,snapshot) {
               if(snapshot.hasData){
                 List<News> news = snapshot.data as List<News>;
                 return ListView.builder(
                   itemCount: news.length,
                   scrollDirection: Axis.horizontal,
                   shrinkWrap: true,
                   physics: ScrollPhysics(),
                   itemBuilder: (context, index){
                     var _headlines = news[index];
                     return InkWell(
                       onTap : () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => ReadNewsView(news:_headlines),)),
                      //  Navigator.of(context).push(
                      //      MaterialPageRoute(
                      //        builder: (context) => ReadNewsView(news: _headlines)
                      //      ),
                      //    );
                       child: Container(
                         margin: EdgeInsets.only(right: 12.0),
                         child: PrimaryCard(news: _headlines),
                       ),
                     );
                   }
                 );
               } else if (snapshot.hasError) {
                 return Text("${snapshot.error}");
               }
 
               return Center (
                 child: CircularProgressIndicator(),
               );
             },
           ),
         ),
         SizedBox(height: 25.0),
         Align(
           alignment: Alignment.topLeft,
           child: Padding(
             padding: EdgeInsets.only(left: 19.0),
             child: Text("BASED ON YOUR READING HISTORY",
                 style: kNonActiveTabStyle),
           ),
         ),
         ListView.builder(
           itemCount: recentList.length,
           scrollDirection: Axis.vertical,
           shrinkWrap: true,
           physics: ScrollPhysics(),
           itemBuilder: (context, index) {
             var recent = recentList[index];
             return InkWell(
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => ReadNewsView(news: recent),
                   ),
                 );
               },
               child: Container(
                 width: double.infinity,
                 height: 135.0,
                 margin: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
                 child: SecondaryCard(news: recent),
               ),
             );
           },
         )
       ],
     ),
   );
 }
}
