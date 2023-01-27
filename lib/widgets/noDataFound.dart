import 'package:flutter/material.dart';

import '../utils/constants.dart';

class NoData extends StatelessWidget {
  const NoData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            child: Image.asset("assets/errors/no-search-items.png",errorBuilder: (a,b,c){
              return Container();
            },),
          ),
         // SizedBox(height: 10,),
          Text("No data found",style: ts16(Color(0xff787878)),)
        ],
      ),
    );
  }
}
