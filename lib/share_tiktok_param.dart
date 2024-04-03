class ShareTiktokParam {
  List<String>? mediaPaths;
  String? mediaType;
  String? clientKey;
  String? shareFormat;
  String? shareSuccessMsg;

  ShareTiktokParam({
    required this.mediaPaths,
    required this.clientKey,
    required this.shareFormat,
    this.mediaType,
    this.shareSuccessMsg,
  });

  ShareTiktokParam.fromJson(Map<String, dynamic> json) {
    mediaPaths =
        (json['mediaPath'] as List<dynamic>?)?.map((e) => e as String).toList();
    mediaType = json['mediaType'] as String?;
    clientKey = json['clientKey'] as String?;
    shareFormat = json['shareFormat'] as String?;
    shareSuccessMsg = json['shareSuccessMsg'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mediaPaths'] = mediaPaths;
    data['mediaType'] = mediaType;
    data['clientKey'] = clientKey;
    data['shareFormat'] = shareFormat;
    data['shareSuccessMsg'] = shareSuccessMsg;
    return data;
  }
}
