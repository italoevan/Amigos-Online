class SocialNetworkModel {
  int whatsapp;
  String facebook;
  String instagram;
  String telegram;
  String tiktok;

  SocialNetworkModel();
  SocialNetworkModel.fromJson(Map<String, dynamic> json) {
    whatsapp = json['whatsapp'] != null ? json['whatsapp'] : null;
    facebook = json['facebook'] != null ? json['facebook'] : null;
    instagram = json['instagram'] != null ? json['instagram'] : null;
    telegram = json['telegram'] != null ? json['telegram'] : null;
    tiktok = json['tiktok'] != null ? json['tiktok'] : null;
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
