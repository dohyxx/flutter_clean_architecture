import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/data/models/search_image_model.dart';
import 'package:flutter_clean_architecture/data/sources/api_config.dart';
import 'package:flutter_clean_architecture/data/sources/api_request.dart';
import 'package:http/http.dart';

class ApiClient {
  final Client client;
  final ApiRequest _request;

  ApiClient({
    required this.client,
    ApiRequest? request,
  }) : _request = request ?? ApiRequest(client);

  //이미지 검색 요청
  Future<SearchImageModel> searchImage({
    required String query,
    String? sort,
    int? page,
    int? size,
  }) async {
    const url = '${ApiConfig.baseUrl}/v2/search/image';
    final params = <String, dynamic>{};

    params['query'] = query;

    if (sort != null) {
      params['sort'] = sort;
    }
    if (page != null) {
      params['page'] = page;
    }
    if (size != null) {
      params['size'] = size;
    }

    final result = await _request(
      method: RequestMethod.get,
      headers: ApiConfig.headers,
      url: url,
      params: params,
    );

    if (result.statusCode == 200) {
      //print('ApiClient: ${result.statusCode} ');
      return SearchImageModel.fromJson(result.body);
    } else {
      throw PlatformException(
        code: 'SYSYEM_ERROR',
        details: {
          'statusCode' : result.statusCode,
          'boby' : result.body ?? '',
        },
      );
    }
  }
}
