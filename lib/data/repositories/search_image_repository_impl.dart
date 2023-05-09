import 'package:flutter_clean_architecture/data/models/search_image_model.dart';
import 'package:flutter_clean_architecture/data/sources/api_client.dart';
import 'package:flutter_clean_architecture/domain/repositories/search_image_repository.dart';
import 'package:http/http.dart';

class SearchImageRepositoryImpl implements SearchImageRepository {
  final _api = ApiClient(client: Client());

  @override
  Future<SearchImageModel> searchImage({
    required String query,
    String? sort,
    int? page,
    int? size,
  }) {
    return _api.searchImage(
      query: query,
      page: page,
      size: size,
      sort: sort,
    );
  }
}
