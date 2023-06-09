import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/data/models/search_image_model.dart';
import 'package:get/get.dart';

class PhotosDetailView extends StatelessWidget {
  final ImageDocument document;

  const PhotosDetailView({
    super.key,
    required this.document,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ExtendedImage.network(
              document.imageUrl,
              fit: BoxFit.fitWidth,
              width: Get.width,
              cacheWidth: Get.width.toInt(),
              cache: true,
              clearMemoryCacheIfFailed: true,
              clearMemoryCacheWhenDispose: true,
            ),
            Visibility(
              visible: document.displaySitename.isNotEmpty,
              child: Text(
                '데이터 출처: ${document.displaySitename}',
              ),
            ),
            Visibility(
              visible: document.datetime.toString().isNotEmpty,
              child: Text(
                '문서 작성 시간: ${document.datetime.toString()}',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
