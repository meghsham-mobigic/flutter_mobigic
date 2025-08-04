class ImageUploadModel {
  ImageUploadModel({this.originalname, this.filename, this.location});

  ImageUploadModel.fromJson(Map<String, dynamic> json) {
    originalname = json['originalname'].toString();
    filename = json['filename'].toString();
    location = json['location'].toString();
  }
  String? originalname;
  String? filename;
  String? location;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['originalname'] = this.originalname;
    data['filename'] = this.filename;
    data['location'] = this.location;
    return data;
  }
}
