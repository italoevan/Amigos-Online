class SocialNetworkModel {
  String whatsapp;
  String facebook;
  String instagram;
  String telegram;


SocialNetworkModel.fromJson(Map<String,dynamic> json){
  whatsapp = json['whatsapp'];
  facebook = json['facebook'];
  instagram = json['instagram'];
  telegram = json['telegram'];


}

}
