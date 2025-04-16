import 'package:flutter/material.dart';
import 'package:gamestopup/Allscreen/fullnews.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Controller/Provider/admob_controller_provider.dart';
import 'package:gamestopup/Widget/slider.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import '../Model/PopularItemModel.dart';
import '../local_notification_service.dart';
import 'PopularItems.dart';

class MyBody {
  static Widget myBody(List<PopularItemsModel> allItems, List sliderList,
      int selectedIndex, BuildContext context) {
    LocalNotificationService.initialize(context);
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: constraints.maxWidth * 0.01),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: constraints.maxHeight * 0.02),
                      SizedBox(
                        height: constraints.maxHeight * 0.04,
                        child: Consumer<HomeScreenProvider>(
                          builder: (context, value, child) => Marquee(
                            text: value.noticeAndContract[0]['notice'],
                            style: TextStyle(fontSize: constraints.maxWidth * 0.04),
                          ),
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight * 0.01),
                      SliderWidget.mySliderWidget(sliderList),
                      PopularItems().popularItems(allItems),
                      SizedBox(height: constraints.maxHeight * 0.02),
                      Center(
                        child: Text(
                          "Update News",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      Consumer<HomeScreenProvider>(
                        builder: (context, value, child) => value.allNews.isEmpty
                            ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xff0D6EFC),
                          ),
                        )
                            : ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: value.allNews.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xff0D6EFC).withOpacity(0.051)),
                              child: ListTile(
                                onTap: () {
                                  Provider.of<AdmobAdsController>(context,
                                      listen: false)
                                      .interstitialAd
                                      ?.show();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => FullNews(
                                        fullNewsMap: value.allNews[index],
                                      ),
                                    ),
                                  );
                                },
                                trailing: FittedBox(
                                  child: Row(
                                    children: [
                                      Icon(Icons.remove_red_eye_outlined, size: constraints.maxWidth * 0.04),
                                      Text(value.allNews[index]['views'] ?? '0',
                                          style: TextStyle(fontSize: constraints.maxWidth * 0.03))
                                    ],
                                  ),
                                ),
                                title: Text(
                                  value.allNews[index]['title'],
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxWidth * 0.04),
                                ),
                                subtitle: Text(
                                  value.allNews[index]['fullnews'],
                                  maxLines: 1,
                                  style: TextStyle(fontSize: constraints.maxWidth * 0.03),
                                ),
                                leading: SizedBox(
                                  width: constraints.maxWidth * 0.2,
                                  child: Image.network(
                                    'https://${value.allNews[index]['images'].toString().split("htdocs\/")[1]}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}