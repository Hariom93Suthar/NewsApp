import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newsapp/ApiRepo/newsRepos.dart';
import 'package:newsapp/Screens/news_detail.dart';
import 'package:newsapp/Screens/search_news.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    NewsRepository newsRepository = NewsRepository();
    final height = MediaQuery.of(context).size.height*1;
    final width =  MediaQuery.of(context).size.width*1;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 50,
              ),
              title: Text("User Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
            subtitle: Text("User Email")
            ),
            Divider(color: Colors.black54,)
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.blue.shade100,
        actions: [
          InkWell(
            onTap: (){
              Get.to(SearchNews());
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Icon(Icons.search_rounded,size: 30,color: Colors.black54,),
            ),
          )
        ],
        title: Text("News App",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
         body: FutureBuilder(
              future: newsRepository.fetchNewsCategoires(),
              builder: (BuildContext context, snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                    itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context,index){
                        return Column(
                          children: [
                            SizedBox(height: 20,),
                            Card(
                              color: Colors.indigo.shade50,
                              child: InkWell(
                                onTap: (){
                               Get.to(
                                   NewsDetailScreen(
                                     snapshot.data!.articles![index].urlToImage.toString(),
                                     snapshot.data!.articles![index].title.toString(),
                                     snapshot.data!.articles![index].description.toString(),));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20)
                                  ),
                                  height: height *.20,
                                  width: width*.90,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Center(
                                      child: Image.network(
                                        fit: BoxFit.fitWidth,
                                          snapshot.data!.articles![index].urlToImage.toString()
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 10,),
                            ListTile(
                              title: Text(
                                  snapshot.data!.articles![index].title.toString()
                              ,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                          ],
                        );
                      }
                  );
                }
                else{
                 return Center(
                     child:CircularProgressIndicator());
                }
              }
              ),
    );
  }
}
