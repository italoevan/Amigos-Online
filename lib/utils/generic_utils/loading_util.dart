import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingUtil extends StatelessWidget {
  final Widget widget;
  final bool loading;

  LoadingUtil({@required this.widget, @required this.loading});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget,
        Visibility(
            visible: loading, child: SpinKitHourGlass(color: Colors.green))
      ],
    );
  }
}
