import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamestopup/AllApiUrl/ApiEndpoint.dart';
import 'package:gamestopup/Controller/Provider/HomeScreenProvider.dart';
import 'package:gamestopup/Controller/launchUrl.dart';
import 'package:lecle_flutter_carousel_pro/lecle_flutter_carousel_pro.dart';
import 'package:provider/provider.dart';

class SliderWidget {
  static mySliderWidget(List sliderImagesList) {
    return sliderImagesList.isEmpty
        ? const Center(child: Text("আমাদের সার্ভিস চালু আছে"))
        : Card(
      child: Consumer<HomeScreenProvider>(
        builder: (context, value, child) => InkWell(
          onTap: () => LaunchUrl.launchUrl(
            Uri.parse(value.noticeAndContract[0]['tutorial']),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final screenHeight = MediaQuery.of(context).size.height;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                height: screenHeight * 0.17, // 20% of the screen height
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    dotBgColor: Colors.transparent,
                    dotColor: Colors.white,
                    images: List.generate(
                      growable: true,
                      sliderImagesList.length,
                          (index) => CachedNetworkImage(
                        imageUrl:
                        "${ApiEndPoint.mainUrl}/${sliderImagesList[index]}",
                        imageBuilder: (context, imageProvider) =>
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}