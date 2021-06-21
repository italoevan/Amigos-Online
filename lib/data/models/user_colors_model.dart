class GridColorsModel {
  _Colors colors;

  GridColorsModel.fromJson(Map<String, dynamic> map) {
    if (map['colors'] != null) {
      colors = _Colors.fromJson(map['colors']);
    }
  }
}

class _Colors {
  List<_Color> listColors;

  _Colors.fromJson(Map<String, dynamic> map) {
    listColors = [];

    map['list'].forEach((v) {
      listColors.add(_Color.fromJson(v));
    });
  }
}

class _Color {
  String hex;
  String name;

  _Color.fromJson(Map<String, dynamic> map) {
    hex = map['hex'];
    name = map['name'];
  }
}
