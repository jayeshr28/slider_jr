class FanData {
  String fanName, fanID;

  FanData({
    required this.fanName,
    required this.fanID,
  });

  FanData.fromJson(Map<String, dynamic> json)
      : fanName = json['fanName'],
        fanID = json['fanID'];

  Map<String, dynamic> toJson() => {
        'fanName': fanName,
        'fanID': fanID,
      };
}
