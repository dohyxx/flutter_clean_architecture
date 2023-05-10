import 'package:flutter/material.dart';

class PhotosErrorView extends StatelessWidget {
  const PhotosErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '다른 검색어로 검색해주세요.',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
