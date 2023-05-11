import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/data/models/search_image_model.dart';
import 'package:flutter_clean_architecture/data/repositories/search_image_repository_impl.dart';
import 'package:flutter_clean_architecture/domain/repositories/search_image_repository.dart';
import 'package:flutter_clean_architecture/presentation/photos/view/photos_detail_view.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';

class PhotosController extends GetxController {
  PhotosController({SearchImageRepository? repository})
      : _repository = repository ?? SearchImageRepositoryImpl();

  final SearchImageRepository _repository;

  final _formKey = GlobalKey<FormState>();
  final _document = <ImageDocument>[].obs;
  final _query = ''.obs;
  final _searchInitialized = false.obs;
  final _showErrorScreen = false.obs;

  var _load = false;
  var _isPagingEnd = false;
  var _page = 1;

  GlobalKey<FormState> get formKey => _formKey;

  RxList<ImageDocument> get document => _document;

  bool get searchInitialized => _searchInitialized.value;
  bool get showErrorScreen => _showErrorScreen.value;
  bool get showEmptyScreen => document.isEmpty && !_load;
  bool get showPagingIndicator {
    if (_showErrorScreen.value) return false;
    if (document.isEmpty) return false;
    if (_isPagingEnd) return false;
    if (!_searchInitialized.value) return false;
    return true;
  }

  @override
  void onInit() {
    super.onInit();

    debounce(
      _query,  //listener
      _searchImage, //callback
      time: const Duration(seconds: 1),
    );
  }

  void _searchImage(_) async {
    Get.log('검색: $_query');

    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    document.clear();
    _page = 1;
    _fetchImage();
  }


  Future<void> _fetchImage() async {
    try {
      _searchInitialized(true);
      _showErrorScreen(false);
      _load = true;

      final result = await _repository.searchImage(
        query: _query.value,
        size: 30,
        page: _page,
      );

      _isPagingEnd = result.isEnd;

      document.addAll(result.document);
    } catch (e) {
      _showErrorScreen(true);
      e.printError();

    } finally {
      _load = false;
    }
  }

  //이미지 Paging
  void onPaging(VisibilityInfo info) async {
    Get.log('onPaging: $info');
    final downScroll = info.visibleFraction != 0.0;
    final canRequest = downScroll && !_isPagingEnd;

    if(canRequest){
      _page++;
      _fetchImage();
    }
  }

  // 검색어 입력
  void onSearchQuery(String query){
    _query.value = query;
  }

  // 상세 이미지 화면으로 이동
  void onRouteDetailPage(int index){
    final document = _document[index];
    Get.to(
        PhotosDetailView(document: document)
    );
  }

  // 키보드 focus 제거
  void dismissKeyboard(){
    FocusManager.instance.primaryFocus?.unfocus();
  }

}
