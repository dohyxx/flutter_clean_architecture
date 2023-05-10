import 'package:flutter/cupertino.dart';

class PhotosInitView extends StatelessWidget {
  const PhotosInitView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        CupertinoIcons.arrow_up,
        size: 40,
      ),
    );
  }
}
