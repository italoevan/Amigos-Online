class InitialDialogModel {
  DialogModel dialogModel;

  InitialDialogModel.fromJson(Map<String, dynamic> json) {
    if (json['remote'] != null) {
      dialogModel = DialogModel.fromJson(json['remote']);
    }
  }
}

class DialogModel {
  bool hasInitialDialog;
  bool hasImage;
  String content;
  String linkImage;
  String title;

  DialogModel();
  DialogModel.fromJson(Map<String, dynamic> json) {
    this.hasInitialDialog = json['hasInitialDialog'];
    this.hasImage = json['hasImage'];
    this.content = json['content'];
    this.linkImage = json['linkImage'];
    this.title = json['title'];
  }
}
