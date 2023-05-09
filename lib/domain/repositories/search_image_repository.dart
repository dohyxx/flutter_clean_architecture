import 'package:flutter_clean_architecture/data/models/search_image_model.dart';

abstract class SearchImageRepository {

  Future<SearchImageModel> searchImage(
      {required String query, String? sort, int? page, int? size});
}
