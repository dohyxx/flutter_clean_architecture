import 'package:flutter/material.dart';


class PhotosEmptyView extends StatelessWidget {
  const PhotosEmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '검색 결과가 없습니다.',
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
