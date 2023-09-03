class CampaignModel {
  String? name;
  String campaignTitle;
  String story;
  DateTime? startDate;
  List backer;
  double? goalPrice;
  double collectedInvestment;
  String endDate;
  String? endStamp;
  String imageUrl;

  CampaignModel({
    this.name,
    required this.campaignTitle,
    required this.story,
    this.startDate,
    this.endStamp,
    required this.backer,
    required this.collectedInvestment,
    required this.imageUrl,
    this.goalPrice,
    required this.endDate,

  });

  factory CampaignModel.fromMap(map) {
    return CampaignModel(
      name: map["name"],
      campaignTitle: map["campaignTitle"],
      story: map["story"],
      imageUrl: map["imageUrl"],
      collectedInvestment: map["collectedInvestment"],
      backer: map["backer"],
      goalPrice: map["goalPrice"],
      endDate: map['endData'],
      endStamp: map['endStamp'],
      startDate: map['startDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "campaignTitle": campaignTitle,
      "story": story,
      "imageUrl": imageUrl,
      "startDate": startDate,
      "endStamp": endStamp,
      "collectedInvestment": collectedInvestment,
      "backer": backer,
      "endData":endDate,
      "goalPrice": goalPrice,
      "name": name,
    };
  }
}

