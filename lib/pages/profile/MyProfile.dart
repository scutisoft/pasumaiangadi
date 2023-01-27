
import '../../model/profileModel.dart';
import '../../notifiers/themeNotifier.dart';
import '../../pages/OrderView/OrderView.dart';
import '../../pages/address/addressHome.dart';
import '../../pages/giftCoupons/giftCouponsPage.dart';
import '../../pages/profile/myProfileEdit.dart';
import '../../pages/Profile/superCoin.dart';
import '../../pages/pancard/panCard.dart';
import '../../pages/questionAnswer/QuestionAnswer.dart';
import '../../pages/reviews/reviews.dart';
import '../../pages/wishlist/wishListView.dart';
import '../../utils/constants.dart';
import '../../utils/size.dart';
import '../../widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../card/card.dart';

class MyProfile extends StatefulWidget {
  VoidCallback voidCallback;
  MyProfile({required this.voidCallback});

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  List<ProfileModel> list=[
    ProfileModel(img: "assets/side-icon/settings.svg", title: "My Order"),
    ProfileModel(img: "assets/side-icon/settings.svg", title: "My Wishlist"),
    ProfileModel(img: "assets/side-icon/settings.svg", title: "Gift & Coupons"),
    ProfileModel(img: "assets/side-icon/settings.svg", title: "My Review"),
    ProfileModel(img: "assets/side-icon/settings.svg", title: "Qus & Ans"),
    ProfileModel(img: "assets/side-icon/settings.svg", title: "My Address"),
    ProfileModel(img: "assets/side-icon/settings.svg", title: "My Cards"),
    ProfileModel(img: "assets/side-icon/settings.svg", title: "Pan Card"),
    ProfileModel(img: "assets/side-icon/settings.svg", title: "Super Coins"),
    ProfileModel(img: "assets/side-icon/settings.svg", title: "Logout"),
  ];
  @override
  late  double width,height,width2,height2;
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    return SafeArea(
      child:Consumer<ThemeNotifier>(
        builder:(ctx,tn,child)=> Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: SizeConfig.screenWidth,
                height:400 ,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    Container(
                     width: width,
                     height: 250,
                     color: Color(0XFFEBEBEB),
                     alignment: Alignment.topCenter,
                     child:Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         CustomAppBar(
                           title: "My profile",
                           prefix: IconButton(onPressed: (){
                             widget.voidCallback();
                             //  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddressHomePage()));
                           },
                             icon: Image.asset('assets/menu.png',width:20,color: Colors.black,),
                             //   icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                           ),
                         ),
                         GestureDetector(
                           onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MyProfileEdit()));
                           },
                           child: Padding(
                             padding: EdgeInsets.only(right: 8.0),
                             child: Icon(Icons.edit,color:tn.primaryColor,),
                           ),
                         )
                       ],
                     ),
                   ),
                    Positioned(
                      top: 80,
                      // left: 22,
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: SizeConfig.screenWidth!*0.9,
                          height: 300,
                          decoration: BoxDecoration(
                            color: tn.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow:[
                              BoxShadow(
                                color: tn.primaryColor.withOpacity(0.5),
                                blurRadius: 25.0, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  0.0, // Move to right 10  horizontally
                                  10.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width:80,
                                height: 80,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white)
                                ),
                                child: Image.asset("assets/profile.png",width: 40,height: 40,),
                              ),
                              SizedBox(height: 10,),
                              Text('Balasubramaniyan',style:ts14(text2,fontfamily: 'RM',),),
                              SizedBox(height: 10,),
                              Text('90923-22264',style:ts14(text2,fontfamily: 'RR',),),
                              SizedBox(height: 10,),
                              Icon(Icons.add_location_outlined,color:text2,size: 40,),
                              SizedBox(height: 5,),
                              Text('Delivery Address',style:ts14(text2,fontfamily: 'RB',),),
                              SizedBox(height: 10,),
                              Container(
                                width: SizeConfig.screenWidth!-100,
                                child: Text("No: 4B/7, Sai Sadan, 1st Floor, MMDA 1st Main Rd, Maduravoyal, Chennai, Tamil Nadu 600095",
                                  style: ts14(text2,fontfamily: 'RR'),textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: SizeConfig.screenHeight!-450,
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runSpacing: 30,
                    spacing: 40,
                    children: [
                      for(int i=0;i<list.length;i++)
                      GestureDetector(
                        onTap:(){
                          if(i==0){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>MyOrderView()));
                          }
                          else if(i==1){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WishListView()));
                          }
                          else if(i==2){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>GiftCouponsPage()));
                          }
                          else if(i==3){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ReviewsPageView()));
                          }
                          else if(i==4){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>QuestionsAnswerView()));
                          }
                          else if(i==5){
                              Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddressHomePage()));
                          }
                          else if(i==6){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>CardDetails()));
                          }
                          else if(i==7){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>PanCardDetails()));
                          }
                          else if(i==8){
                            Navigator.push(context, MaterialPageRoute(builder: (ctx)=>SuperCoins()));
                          }
                          else if(i==9){

                          }
                        },
                        child: Container(
                          width: 90,
                          color: Colors.transparent,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(list[i].img,height: list[i].imgHeight,color: tn.primaryColor1,),
                             // Icon(Icons.add_location_outlined,color:tn.primaryColor,size: 40,),
                              SizedBox(height: 5,),
                              Text(list[i].title,style:ts18(text1,fontfamily: 'RR',fontsize: 13),),
                            ],
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
