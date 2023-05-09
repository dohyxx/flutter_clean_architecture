import 'dart:convert';
import 'package:get/get.dart' as gets;
import 'package:http/http.dart';


enum RequestMethod { get }

class ApiRequest {
  final Client _client;

  ApiRequest(Client client) : _client = client;

  Future<ApiResponse> call({
    required RequestMethod method,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? params,
  }) async {
    final httpResponse = await _requestHttp(method, url, headers, params);
    final response = ApiResponse.fromHttpResponse(httpResponse);

    return response;
  }


  Future<Response> _requestHttp(
      RequestMethod method,
      String url,
      Map<String, String>? headers,
      Map<String, dynamic>? params,
  ){
    Future<Response> result;

    switch(method){
      case RequestMethod.get :
        if(params?.isNotEmpty ?? false){
          url += '?${_queryParameters(params!)}';
        }
        result = _client.get(
          Uri.parse(url),
          headers: headers,
        );
        break;
    }

    return result;
  }

  String _queryParameters(Map<String, dynamic> params){
    return params.entries.map((e) => '${e.key}=${e.value}').join('&');
  }

}


// 서버 응답 상태 체크
class ApiResponse {
  int statusCode;
  dynamic body;

  ApiResponse({
    required this.statusCode,
    this.body,
  });

  factory ApiResponse.fromHttpResponse(Response res) {
    final response = ApiResponse(statusCode: res.statusCode);

    if(res.body.isNotEmpty){
      final decodeData = utf8.decode(res.bodyBytes);
      response.body = jsonDecode(decodeData);
    }

    return response;
  }
}



