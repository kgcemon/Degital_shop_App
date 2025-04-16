import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gamestopup/AllText.dart';
import 'package:gamestopup/Controller/PopularBottomLogic.dart';
import 'package:gamestopup/Model/PopularItemModel.dart';

class PopularItems {
  Widget popularItems(List<PopularItemsModel> allItems) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        final int crossAxisCount = _getCrossAxisCount(maxWidth);
        final double aspectRatio = _getAspectRatio(maxWidth);

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Text(
                AllText.popularItemsTitleText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 10),
            allItems.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: allItems.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: aspectRatio,
              ),
              itemBuilder: (context, index) {
                return _buildGridItem(context, allItems[index],allItems);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildGridItem(BuildContext context, PopularItemsModel item,List<PopularItemsModel> allItems) {
    return GestureDetector(
      onTap: () {
        PopularBottomController.myBottom(
            allItems.indexOf(item), allItems, context);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
            color: const Color(0xff0D6EFC).withOpacity(0.051)),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: item.categoryName.toString(),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CachedNetworkImage(
                        imageUrl: item.ctaImg.toString(),
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Text(
                  item.categoryName ?? "",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11,fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getCrossAxisCount(double width) {
    if (width > 1200) return 6;
    if (width > 900) return 5;
    if (width > 600) return 4;
    if (width > 400) return 3;
    return 3;
  }

  double _getAspectRatio(double width) {
    if (width > 1200) return 1.2;
    if (width > 900) return 1.1;
    if (width > 600) return 1.0;
    if (width > 400) return 0.9;
    return 0.8;
  }
}