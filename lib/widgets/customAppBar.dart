import '../notifiers/themeNotifier.dart';
import '../utils/constants.dart';
import '../utils/size.dart';
import '../widgets/bottomPainter.dart';
import '../widgets/companySettingsTextField.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  String title;
  Widget? prefix;
  CustomAppBar({required this.title,this.prefix});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      // width: SizeConfig.screenWidth,
      child: Row(
        children: [
          prefix==null?GestureDetector(
            onTap:(){
              Navigator.pop(context);
            },
            child: Container(
                height:50,
                width:50,
                color: Colors.transparent,
                child: Icon(Icons.arrow_back_ios_new_outlined,color: text1,size: 20,)
            ),
          ):prefix!,
          Text(title,style: ts16(text1,fontfamily: 'RM'),)
        ],
      ),
    );
  }
}
