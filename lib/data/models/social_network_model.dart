class SocialNetworkModel {
  String whatsapp;
  String facebook;
  String instagram;
  String telegram;
  String tiktok;

  SocialNetworkModel.fromJson(Map<String, dynamic> json) {
    whatsapp = json['whatsapp'];
    facebook = json['facebook'];
    instagram = json['instagram'];
    telegram = json['telegram'];
    tiktok = json['tiktok'];
  }

  Map toJson() {
    Map<String, dynamic> json = Map();

    json['whatsapp'] = whatsapp;
    json['facebook'] = facebook;
    json['instagram'] = instagram;
    json['telegram'] = telegram;
    json['tiktok'] = tiktok;

    return json;
  }
}
