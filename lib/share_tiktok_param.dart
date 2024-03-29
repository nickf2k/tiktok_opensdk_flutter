class ShareTiktokParam {
  List<String>? mediaPaths;
  String? mediaType;
  String? clientKey;
  String? shareFormat;

  ShareTiktokParam(
      {this.mediaPaths, this.mediaType, this.clientKey, this.shareFormat});

  ShareTiktokParam.fromJson(Map<String, dynamic> json) {
    mediaPaths =
        (json['mediaPath'] as List<dynamic>?)?.map((e) => e as String).toList();
    mediaType = json['mediaType'] as String?;
    clientKey = json['clientKey'] as String?;
    shareFormat = json['shareFormat'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mediaPaths'] = mediaPaths;
    data['mediaType'] = mediaType;
    data['clientKey'] = clientKey;
    data['shareFormat'] = shareFormat;
    return data;
  }
}
