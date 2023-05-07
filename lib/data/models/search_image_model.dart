
class SearchImageModel {
  final int totalCount;
  final int pageableCount;
  final bool isEnd;
  final List<ImageDocument> document;

  SearchImageModel({
    required this.totalCount,
    required this.pageableCount,
    required this.isEnd,
    required this.document,
  });

  factory SearchImageModel.fromJson(Map<String, dynamic> json) {
    final jsonDocument = json['document'] as List;
    final document = <ImageDocument>[];
    for (var jsonDocument in jsonDocument) {
      document.add(ImageDocument.fromJson(jsonDocument));
    }

    return SearchImageModel(
      totalCount: json['meta']['total_count'],
      pageableCount: json['meta']['pageable_count'],
      isEnd: json['meta']['is_end'],
      document: document,
    );
  }
}

class ImageDocument {
  final String collection;
  final String thumbnailUrl;
  final String imageUrl;
  final int width;
  final int height;
  final String displaySitename;
  final String docUrl;
  final DateTime datetime;

  ImageDocument({
    required this.collection,
    required this.thumbnailUrl,
    required this.imageUrl,
    required this.width,
    required this.height,
    required this.displaySitename,
    required this.docUrl,
    required this.datetime,
  });

  factory ImageDocument.fromJson(Map<String, dynamic> json) {
    return ImageDocument(
      collection: json['collection'],
      thumbnailUrl: json['thumbnail_url'],
      imageUrl: json['image_url'],
      width: json['width'],
      height: json['height'],
      displaySitename: json['display_sitename'],
      docUrl: json['doc_url'],
      datetime: DateTime.parse(json['datetime']).toLocal(),
    );
  }
}
