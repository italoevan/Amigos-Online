import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingUtil extends StatelessWidget {
  final Widget widget;
  final bool loading;
  final Color color;

  LoadingUtil({@required this.widget, @required this.loading, this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget,
        Visibility(
            visible: loading, child: SpinKitHourGlass(color:color != null ? color :  Colors.green))
      ],
    );
  }
}
