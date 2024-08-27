import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/PopularBottomLogic.dart';
import 'package:gamestopup/Model/PopularItemModel.dart';


class PopularItems {

 Widget popularItems(List<PopularItemsModel> allItems) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const Center(
          child: Text(
            AllText.popularItemsTitleText,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        allItems.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: allItems.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 2,
                    childAspectRatio: 2 / 2.5,
                    mainAxisExtent: 155),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      PopularBottomController.myBottom(
                          index, allItems, context);
                    },
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 5,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Hero(
                                tag: allItems[index].categoryName.toString(),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          allItems[index].ctaImg.toString(),
                                      imageBuilder:
                                          (context, imageProvider) =>
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
                            ),
                          ),
                          FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${allItems[index].categoryName}",
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 13),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ],
    );
  }
}
