import 'package:flutter/material.dart';
import 'package:gamestopup/Allscreen/fullnews.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Widget/slider.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import '../Model/PopularItemModel.dart';
import 'PopularItems.dart';

class MyBody {
  static Widget myBody(
      List<PopularItemsModel> allItems, List sliderList, int selectedIndex) {
    return Expanded(
      child: CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              SizedBox(
                height: 20,
                child: Consumer<HomeScreenProvider>(builder: (context, value, child) => Marquee(
                  text: value.noticeAndContract[0]['notice'],
                  style: const TextStyle(
                      fontSize: 16),
                ),),
              ),
              const SizedBox(height: 10,),
              SliderWidget.mySliderWidget(sliderList),
              PopularItems().popularItems(allItems),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Update News",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Consumer<HomeScreenProvider>(
                builder: (context, value, child) => value.allNews.isEmpty
                    ? const Center(child: CircularProgressIndicator(color: Colors.green,),)
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.allNews.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Card(
                          color: Colors.white,
                          child: ListTile(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FullNews(fullNewsMap: value.allNews[index],),
                                )),
                            trailing: FittedBox(
                              child: Row(
                                children: [
                                  const Icon(Icons.remove_red_eye_outlined),
                                  Text(value.allNews[index]['views'] ??
                                      0.toString())
                                ],
                              ),
                            ),
                            title: Text(value.allNews[index]['title'],
                                maxLines: 2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(
                              value.allNews[index]['fullnews'],
                              maxLines: 1,
                            ),
                            leading: SizedBox(
                              width: 80,
                              child: Image.network(
                                  'https://${value.allNews[index]['images'].toString().split("htdocs\/")[1].toString()}',
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 30,)
            ],
          ),
        ),
      ]),
    );
  }
}
