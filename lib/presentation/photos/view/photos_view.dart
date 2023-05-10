import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_clean_architecture/presentation/commons/utils/util_validator.dart';
import 'package:flutter_clean_architecture/presentation/photos/view/photos_empty_view.dart';
import 'package:flutter_clean_architecture/presentation/photos/view/photos_error_view.dart';
import 'package:flutter_clean_architecture/presentation/photos/view/photos_init_view.dart';
import 'package:flutter_clean_architecture/presentation/photos/viewModel/photos_controller.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PhotosView extends GetView<PhotosController> {
  const PhotosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.dismissKeyboard,
      child: Scaffold(
        body: Obx(
          () => CustomScrollView(
            cacheExtent: Get.height * 2,
            slivers: [
              SliverAppBar(
                toolbarHeight: 90,
                floating: true,
                title: Form(
                  key: controller.formKey,
                  child: TextFormField(
                    autofocus: true,
                    decoration: _inputTextFormField,
                    cursorHeight: 20.0,
                    textInputAction: TextInputAction.search,
                    validator: UtilValidator.displayNameValidator,
                    onChanged: controller.onSearchQuery,
                  ),
                ),
              ),

              //이미지 화면
              _buildBody(),


              //이미지 paging
              if(controller.showPagingIndicator)
                SliverToBoxAdapter(
                  child: VisibilityDetector(
                    key: const Key('load-more'),
                    onVisibilityChanged: controller.onPaging,
                    child: const SizedBox(
                      height: 50,
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                )

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (!controller.searchInitialized) {
      return const SliverToBoxAdapter(
        child: PhotosInitView(),
      );
    }
    if (controller.showEmptyScreen) {
      return const SliverToBoxAdapter(
        child: PhotosEmptyView(),
      );
    }
    if (controller.showErrorScreen) {
      return const SliverToBoxAdapter(
        child: PhotosErrorView(),
      );
    }

    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        _buildGridTitle,
        addRepaintBoundaries: true,
        addAutomaticKeepAlives: true,
        addSemanticIndexes: true,
        childCount: controller.document.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
    );
  }

  Widget _buildGridTitle(_, int index) {
    final imageSize = Get.width * 1 / 3;
    final url = controller.document[index].imageUrl;

    return GestureDetector(
      onTap: () => controller.onRouteDetailPage(index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(2.0),
        child: ExtendedImage.network(
          url,
          cacheWidth: imageSize.toInt(),
          cacheHeight: imageSize.toInt(),
          cache: true,
          clearMemoryCacheIfFailed: true, // image load 실패 시 메모리 삭제
          clearMemoryCacheWhenDispose: true, // image가 tree에서 remove될 때, 메모리 삭제
          compressionRatio: .5,
          loadStateChanged: (state) { //이미지 상태 컨트롤
            switch (state.extendedImageLoadState) {
              case LoadState.loading:
                return const Icon(CupertinoIcons.photo);
              case LoadState.completed:
                return FadeIn(
                    preferences: const AnimationPreferences(
                      duration: Duration(milliseconds: 500),
                    ),
                    child: ExtendedRawImage(
                      key: Key(url),
                      image: state.extendedImageInfo?.image,
                      fit: BoxFit.cover,
                      width: imageSize,
                      height: imageSize,
                    ));
              case LoadState.failed:
                return const Icon(CupertinoIcons.eye_slash_fill);
            }
          },
        ),
      ),
    );
  }

  // 상단 이미지 검색 Input Form
  InputDecoration get _inputTextFormField {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16.0),
      borderSide: BorderSide.none,
    );

    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      hintText: '검색할 키워드를 입력해주세요.',
      enabledBorder: border,
      focusedBorder: border,
      errorBorder: border.copyWith(
        borderSide: BorderSide(color: Colors.red[600]!),
      ),
      border: border,
      prefixIcon: const Icon(
        // Icons.search,
        CupertinoIcons.search,
        size: 16,
      ),
    );
  }
}
