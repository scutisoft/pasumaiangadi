import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorUtil{
  static Color theme=const Color(0xffffffff);
  static Color themeWhite=const Color(0xffffffff);
  static Color themeBlack=const Color(0xff2C2C2D);
  static Color primary=const Color(0xff062778);
  static Color primaryColor=const Color(0xff062778);
  static Color primaryOpa01=const Color(0xff5F6FA1);
  static Color primaryOpa005=const Color(0xffE2E5ED);
  static Color primaryOpa02=const Color(0xff062778).withOpacity(0.2);
  static Color primaryOpa03=const Color(0xff062778).withOpacity(0.3);
  static Color primaryOpa04=const Color(0xff062778).withOpacity(0.4);
  static Color primaryOpa05=const Color(0xff062778).withOpacity(0.5);
  static Color primaryOpa06=const Color(0xff062778).withOpacity(0.6);
  static Color secondary=const Color(0xff019342);
  static Color secondaryOpa01=const Color(0xff019342).withOpacity(0.1);
  static Color secondaryOpa02=const Color(0xff019342).withOpacity(0.2);
  static Color secondaryOpa03=const Color(0xff019342).withOpacity(0.3);
  static Color secondaryOpa04=const Color(0xff019342).withOpacity(0.4);
  static Color secondaryOpa05=const Color(0xff019342).withOpacity(0.5);
  static Color secondaryOpa06=const Color(0xff019342).withOpacity(0.6);
  static Color secondaryOpa07=const Color(0xff019342).withOpacity(0.7);
  static Color greyBorder=const Color(0xff808080);
  static Color greyFill=const Color(0xff656565);
  static Color text1=const Color(0xff979797);
  static Color text2=const Color(0xff452800);
  static Color text3=const Color(0xff828282);
  static Color text4=const Color(0xffA6A6A6);
  static Color text5=const Color(0xff6E6E6E);
  static Color lightBlue=const Color(0xffF4F7FC);
  static Color red=const Color(0xffE1433A);
  static Color grey1=const Color(0xffF7F7F9);
  static TextStyle textStyle18=TextStyle(fontFamily: 'RR',fontSize: 18,color: Color(0xff2C2C2D));
  static TextStyle notiText=TextStyle(fontFamily: 'RR',color: Color(0xFFffffff),fontSize: 10);

  static const Color menu=Color(0xFF858585);
  static const Color bgColor=Color(0xFFF1F3F6);
  static const Color primaryTextColor2=Color(0xFF383838);

  static Color rejectClr=const Color(0xffE1433A);
  static Color paidClr=const Color(0xff019342);
  static Color partiallyPaidClr=const Color(0xffE4BE49);
  static Color payClr=const Color(0xff062778);
  static Color approvedClr=const Color(0xff019342);

  static TextStyle payableTS=TextStyle(fontFamily: 'RR',fontSize: 15,color: ColorUtil.primary);
  static TextStyle paidTS=TextStyle(fontFamily: 'RR',fontSize: 15,color: ColorUtil.secondary);
  static TextStyle pendingTS=TextStyle(fontFamily: 'RR',fontSize: 15,color: Color(0xffE4BE49));

  static const TextStyle fseAccRejGridTS=TextStyle(fontFamily: 'USB',fontSize: 18,color:ColorUtil.primaryTextColor2);
  static const TextStyle fseAccRejGridBosyTS=TextStyle(fontFamily: 'RR',fontSize: 15,color:Color(0xff6E6E6E));

  static Color avatarBorderColor=Color(0xFFC7D0D8);
  static Color disableColor=Color(0xFFe8e8e8);

  //rawScrollBar Properties
  static const Color srollBarColor=Colors.grey;
  static const double scrollBarRadius=5.0;
  static const double scrollBarThickness=4.0;

  static const Color pop4Text1=Color(0xFF484848);

  static Color parseColor(String color){
    if(color=="titleDark"){
      return Colors.black;
    }
    else if(color=="titleLight"){
      return Colors.white;
    }
    else if(color=="descDark"){
      return Color(0xffF0F5F9);
    }
    else if(color=="descLight"){
      return  Color(0xff7A7A7A);
    }
    else if(color=="feaTitleDark"){
      return  Color(0xffF82023);
    }
    else if(color=="feaDescDark"){
      return  Color(0xff5D5C51);
    }
    return Colors.transparent;
  }

}