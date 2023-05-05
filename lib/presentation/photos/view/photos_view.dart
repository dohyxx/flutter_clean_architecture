import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/presentation/photos/viewModel/photos_view_model.dart';
import 'package:get/get.dart';

class PhotosView extends GetView<PhotosViewModel> {
  const PhotosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          toolbarHeight: 90,
          title: Form(
            child: TextFormField(
              autofocus: true,
              decoration: _inputTextFormField,
              cursorHeight: 20.0,
              textInputAction: TextInputAction.search,
              //onChanged: controller.,
            ),
          ),
        ),
      ],
    ));
  }
}




// 상단 이미지 검색 Input Form
InputDecoration get _inputTextFormField {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(
      16.0
    ),
    borderSide: BorderSide.none,
  );

  return InputDecoration(
    filled: true,
    fillColor: Colors.grey[100],
    hintText: '검색할 키워드를 입력해주세요.',
    enabledBorder: border,
    focusedBorder: border,
    errorBorder: border.copyWith(
      borderSide: BorderSide(color: Colors.red[600]!),
    ),
    border: border,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    prefixIcon: const Icon(
      // Icons.search,
      CupertinoIcons.search,
      size: 16,
    ),
  );
}
