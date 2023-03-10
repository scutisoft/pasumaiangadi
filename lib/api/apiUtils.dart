


import '../model/parameterMode.dart';
import '../notifiers/configuration.dart';
import '../utils/constants.dart';


int loginUserId=0;
String databaseName="";
int outletId=0;
String outletName="";

String GetBaseUrl(){
  //return "https://scutisoft.in/zoomnshop";
  return MyConstants.isLive?"http://45.126.252.78/Rad_ECS": "http://45.126.252.78/Radiant_ECS";
}
String GetImageBaseUrl(){
  return MyConstants.isLive?"http://45.126.252.78/Rad_ECS/AppAttachments/": "http://45.126.252.78/Radiant_ECS/AppAttachments/";
}


getParameterEssential({bool needOutletId=false}) async{
  return [
    ParameterModel(Key: "LoginUserId", Type: "int", Value: await getLoginId()),
    ParameterModel(Key: "IsMobile", Type: "int", Value: 1),
    ParameterModel(Key: "database", Type: "String", Value: getDatabase()),
    ParameterModel(Key: "DeviceId", Type: "String", Value: getDeviceId()),
    if(needOutletId)
      ParameterModel(Key: "OutletId", Type: "String", Value: await getOutletId()),
  ];
}

getLoginId() async{
  //SharedPreferences sp=await SharedPreferences.getInstance();
  // return sp.getInt("LoginUserId");
  return await getSharedPrefString(SP_USER_ID);
}

getDatabase(){
//  SharedPreferences sp=await SharedPreferences.getInstance();
//  return sp.getString("DatabaseName");
  return  MyConstants.isLive?"RadiantECS":"RadiantDevUIECS";
}

getOutletId() async{
//  SharedPreferences sp=await SharedPreferences.getInstance();
//  return sp.getString("DatabaseName");
  return outletId;
}
getOutletName() async{
//  SharedPreferences sp=await SharedPreferences.getInstance();
//  return sp.getString("DatabaseName");
  return outletName;
}