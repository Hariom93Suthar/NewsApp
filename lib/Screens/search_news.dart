import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/ApiRepo/newsRepos.dart';
import 'package:newsapp/Screens/news_detail.dart';
import 'package:get/get.dart';
class SearchNews extends StatefulWidget {
  const SearchNews({super.key});

  @override
  State<SearchNews> createState() => _SearchNewsState();
}

class _SearchNewsState extends State<SearchNews> {
  TextEditingController searchController = TextEditingController();
  NewsRepository newsRepository = NewsRepository();
  @override
    Widget build(BuildContext context) {
      final height = MediaQuery.of(context).size.height*1;
      final width =  MediaQuery.of(context).size.width*1;
      return Scaffold(
        appBar: AppBar(
          title:   CupertinoSearchTextField(
              controller: searchController,
              padding: const EdgeInsets.all(10.0),
              prefixIcon: const Icon(
                CupertinoIcons.search,
                color: Colors.grey,
              ),
              suffixIcon: const Icon(
                Icons.cancel,
                color: Colors.grey,
              ),
              style: const TextStyle(color: Colors.white),
              backgroundColor: Colors.grey.withOpacity(0.3),
              onChanged: (value) {
                if (value.isEmpty) {
                  Text("hii");
                }
                else {
                  Text('Error');
                }
              }),
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
        ),
        body: FutureBuilder(
            future: newsRepository.getSearched(searchController.text),
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
                                height: height *.25,
                                width: width*.90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Center(
                                    child: Image.network(
                                        fit: BoxFit.cover,
                                        snapshot.data!.articles![index].urlToImage.toString()
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
