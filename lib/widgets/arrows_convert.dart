import 'package:flutter/material.dart';

class ArrowsConvert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_downward, color: Colors.white, size: 20,),
          Icon(Icons.arrow_upward, color: Colors.white, size: 20,)
        ],
      ),
    );
  }
}
