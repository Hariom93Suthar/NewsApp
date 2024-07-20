import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewsDetailScreen extends StatefulWidget {
  String newsImage;
  String newsTitle;
  String newsDesc;
  NewsDetailScreen(this.newsImage, this.newsTitle, this.newsDesc);


  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double Kwidth = MediaQuery.of(context).size.width;
    double Kheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.grey[600],
            )),
      ),
      body: Stack(
        children: [
          Container(
            child: Container(
              height: Kheight * 0.30,
              width: Kwidth,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                child: CachedNetworkImage(
                  imageUrl: "${widget.newsImage}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Kheight * 0.4),
            padding: EdgeInsets.only(top: 20, right: 20, left: 20),
            height: Kheight * 0.6,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: ListView(
              children: [
                Text('${widget.newsTitle}',
                    style:TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                SizedBox(height: Kheight * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          '${widget.newsDesc}',
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    // Text(
                    //   '${format.format(dateTime)}',
                    //   softWrap: true,
                    //   overflow: TextOverflow.ellipsis,
                    //   style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)
                    // ),
                  ],
                ),
                SizedBox(
                  height: Kheight * 0.03,
                ),
                Text('${widget.newsDesc}',
                    style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                SizedBox(
                  height: Kheight * 0.03,
                ),
                SizedBox(
                  height: Kheight * 0.03,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}