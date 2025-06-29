import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/* Creates a Loading spinning circle with a default size of 100 from the
   spinkit package.
 */

class Loading extends StatelessWidget {
  const Loading({this.size = 100, Key? key}) : super(key: key);
  final double size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCircle(
        color: Colors.lightBlue,
        size: size,
      ),
    );
  }
}
