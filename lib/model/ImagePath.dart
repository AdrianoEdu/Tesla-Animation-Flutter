class ImagePath {
  String path = '';
  String key = '';

  ImagePath(this.path, this.key);

  factory ImagePath.fromJson(dynamic json) {
    return ImagePath(json['path'] as String, json['key'] as String);
  }
}
