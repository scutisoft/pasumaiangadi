import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../api/apiUtils.dart';

import '../notifiers/getUiNotifier.dart';
import 'colorUtil.dart';
import 'constants.dart';


class General{


  static String userLandingPage=!MyConstants.fromUrl?"assets/json/landingPage_01.json":"30B98355-5A47-4D0F-BA41-8405506A695F";
  static String productListPage=!MyConstants.fromUrl?"assets/json/productList_02.json":"22B7AB65-CD8D-4990-9FB9-9C2294440A14";

  static String eventName="eventName";
  static String FormSubmit="FormSubmit";
  static String Navigation="Navigation";
  static String openDrawer="OpenDrawer";
  static String formSubmitNavigate="FormSubmitNavigate";
  static String formDataJson_ApiCall="formDataJson_ApiCall";

  static String changeValues="changeValues";
  static String changeValuesArray="changeValuesArray";
  static String locationClick="locationClick";
  static String navigateToPage="navigateToPage";
  static String typeOfNavigation="typeOfNavigation";
  static String actionType="actionType";
  static String openMap="openMap";
  static String dynamicPageGuid="dynamicPageGuid";
  static String changePageViewIndex="changePageViewIndex";
  static String pageViewPrevious="pageViewPrevious";
  static String openDialer="OpenDialer";
  static String openDialog="openDialog";
  static String openDatePicker="openDatePicker";
  static String reload="reload";
  static String getByIdArray="getByIdArray";

  checkApiCall(Map clickEvent,var res,String pageId) async{
    var val="";
    Get.defaultDialog(
      title: "",
      content: CircularProgressIndicator(),
      barrierDismissible: false,
    );
    await GetUiNotifier().postUiJson( await getLoginId(), pageId, res,clickEvent).then((value){
      Get.back();
      log("checkApiCall response $value");
      if(value[0]){
        val=value[1];
      }
      else{
        Get.dialog(  CupertinoAlertDialog(
          title: Icon(Icons.error_outline,color: Colors.red,size: 50,),
          content: Text("${value[1]}",
            style: TextStyle(fontSize: 18),),
        ));
      }
      //val=value;

    });
    return val;
  }


  showAlertPopUp(String message){
    Get.defaultDialog(
        title: "",
        titleStyle: TextStyle(height: 0.0),
        middleTextStyle: TextStyle(height: 0.0),
        middleText: "",
        content: Column(
          children: [
            Image.asset("assets/icons/sucess.gif",height: 150,),
            SizedBox(height: 15,),
            Text("$message",style: ts18(ColorUtil.text2),textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: ColorUtil.theme
                ),
                alignment: Alignment.center,
                child: Text("Ok",style: ts15(ColorUtil.primary),),
              ),
            )
          ],
        )
    );
  }

  showSuccessPopUp(String message){
    Get.defaultDialog(
        title: "",
        titleStyle: TextStyle(height: 0.0),
        middleTextStyle: TextStyle(height: 0.0),
        middleText: "",
        content: Column(
          children: [
            Image.asset("assets/icons/sucess.gif",height: 150,),
            SizedBox(height: 15,),
            Text("$message",style: ts18(ColorUtil.text2),textAlign: TextAlign.center,),
            SizedBox(height: 15,),
            GestureDetector(
              onTap: (){
                Get.back();
              },
              child: Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: ColorUtil.theme
                ),
                alignment: Alignment.center,
                child: Text("Ok",style: ts15(ColorUtil.primary),),
              ),
            )
          ],
        )
    );
  }


  getPage(String page,{String dynamicPageIdentifier="",String dataJson=""}){
    switch(page){
    }
    return Container();
  }


}