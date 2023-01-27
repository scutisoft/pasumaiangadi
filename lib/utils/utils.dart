import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pasumaiangadi/api/apiUtils.dart';
import 'package:pasumaiangadi/utils/size.dart';

getImageByType({int imageType=1,String path="",BoxFit boxFit=BoxFit.cover,double? width,String dataType="png",double? height}){
  if(imageType==1){
    if(dataType=="png"){
      return Image.asset(path,fit: boxFit,width: width??SizeConfig.screenWidth,height: height,);
    }
    else if(dataType=="svg"){
      return SvgPicture.asset(path,fit: boxFit,width: width??SizeConfig.screenWidth,height: height);
    }
  }
  else if(imageType==2){
    path=GetImageBaseUrl()+path;
    if(dataType=="png"){
      return Image.network(path,fit: boxFit,width: width??SizeConfig.screenWidth,height: height);
    }
    else if(dataType=="svg"){
      return SvgPicture.network(path,fit: boxFit,width: width??SizeConfig.screenWidth,height: height);
    }
  }
}

void fadeRoute(Widget widget) {
  Get.to(widget,transition: Transition.fadeIn,duration: const Duration(milliseconds: 400),opaque: true);
}

String timeAgo(DateTime fatchedDate) {
  DateTime currentDate = DateTime.now();

  var different = currentDate.difference(fatchedDate);
  //print(different.inHours);

  if (different.inDays > 365) {
    return "${(different.inDays / 365).floor()} ${(different.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (different.inDays > 30) {
    return "${(different.inDays / 30).floor()} ${(different.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (different.inDays > 7) {
    return "${(different.inDays / 7).floor()} ${(different.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (different.inDays > 0) {
    return "${different.inDays} ${different.inDays == 1 ? "day" : "days"} ago";
  }
  if (different.inHours > 0) {
    return "${different.inHours} ${different.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (different.inMinutes > 0) {
    return "${different.inMinutes} ${different.inMinutes == 1 ? "min" : "mins"} ago";
  }
  if (different.inMinutes == 0) return 'Just Now';

  return fatchedDate.toString();
}
String timeLeft(DateTime fatchedDate) {
  DateTime currentDate = DateTime.now();

  var different = currentDate.difference(fatchedDate);
  //print(different.inHours);

  if (different.inDays > 365) {
    return "${(different.inDays / 365).floor()} ${(different.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  }
  if (different.inDays > 30) {
    return "${(different.inDays / 30).floor()} ${(different.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  }
  if (different.inDays > 7) {
    return "${(different.inDays / 7).floor()} ${(different.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  }
  if (different.inDays > 0) {
    return "${different.inDays} ${different.inDays == 1 ? "day" : "days"} ago";
  }
  if (different.inHours > 0) {
    return "${different.inHours} ${different.inHours == 1 ? "hour" : "hours"} ago";
  }
  if (different.inMinutes > 0) {
    return "${different.inMinutes} ${different.inMinutes == 1 ? "min" : "mins"} ago";
  }
  if (different.inMinutes == 0) return 'Just Now';

  return fatchedDate.toString();
}




parseDouble(var value){
  try{
    return double.parse(value.toString());
  }catch(e){}
  return 0.0;
}
parseInt(var value){
  try{
    return int.parse(value.toString());
  }catch(e){}
  return 0;
}

String checkAndRemoveZero(dynamic a){
  String z=a.toString();
  if(z.contains('.')){
    var y=z.split('.');
    int x=parseInt(y[1]);
    if(x>0){
      return z;
    }
    else{
      return y[0];
    }
  }
  return z;
}