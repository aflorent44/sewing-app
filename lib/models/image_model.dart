import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImageModel {
  final String id;
  final String url;
  final String type;
  final String? refId;
  final String? userId;
  final String? alt;

  ImageModel({
    required this.id,
    required this.url,
    required this.type,
    this.refId,
    this.userId,
    this.alt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['_id'],
      url: json['url'],
      type: json['type'],
      refId: json['refId'],
      userId: json['user_id'],
      alt: json['alt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'type': type,
      if (refId != null) 'refId': refId,
      if (userId != null) 'user_id': userId,
      if (alt != null) 'alt': alt,
    };
  }

  String get fullUrl {
    if (url.startsWith('http')) {
      return url;
    } else {
      // Remplace ici par ta baseUrl + slash
      return '${dotenv.env['BASE_URL']!}/$url';
    }
  }

  @override
  String toString() =>
      'ImageModel{id: $id, url: $url, type: $type, refId: $refId, userId: $userId, alt: $alt}';
}
