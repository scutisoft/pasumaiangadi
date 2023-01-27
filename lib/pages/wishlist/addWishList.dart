
import '../../notifiers/themeNotifier.dart';
import '../../utils/constants.dart';
import '../../utils/size.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'wishListView.dart';

class AddWishListView extends StatefulWidget {

  @override
  _AddWishListViewState createState() => _AddWishListViewState();
}

class _AddWishListViewState extends State<AddWishListView> {
  int selectTopSale=0;
  List<dynamic> Category=[
    {"CatgImg":"assets/theme/icons/category-1.svg","CatgName":"Areca Products",},
    {"CatgImg":"assets/theme/icons/category-2.svg","CatgName":"Farm Fresh",},
    {"CatgImg":"assets/theme/icons/category-10.svg","CatgName":"Organic Vegetables & Fruits",},
    {"CatgImg":"assets/theme/icons/category-3.svg","CatgName":"TinToys",},
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
          body: Stack(
            children: [
              Container(
                width: width,
                height: height,
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomAppBar(title: "WishList"),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: CompanySettingsTextField(
                        hintText: "Collection Name",
                        img: "",
                        borderRadius: textFieldBR,
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      alignment: Alignment.topLeft,
                      child: Text('Suggestion',style: TextStyle(fontFamily: 'RR',fontSize:14,color: Color(0xff000000)),),
                    ),
                    Container(
                        width: SizeConfig.screenWidth,
                        height: 70,
                        //  padding: EdgeInsets.only(bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: Category.length,
                          shrinkWrap: true,
                          itemBuilder: (ctx,i){
                            return  GestureDetector(
                              onTap: (){
                                setState(() {
                                  selectTopSale=i;
                                  // Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ViewAllItems()));
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 400),
                                curve: Curves.easeIn,
                                decoration:i==selectTopSale? BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color:tn.primaryColor.withOpacity(0.5),
                                      blurRadius: 5.0, // soften the shadow
                                      spreadRadius: 2, //extend the shadow
                                      offset: Offset(
                                        2.0, // Move to right 10  horizontally
                                        2.0, // Move to bottom 10 Vertically
                                      ),
                                    )
                                  ],
                                  color:tn.primaryColor,
                                ):BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(color: Color(0xffE2E2E2),style:BorderStyle.solid ),
                                  color:Color(0xffF8F8FA),
                                ) ,
                                margin: EdgeInsets.only(right: 10,top: 10,bottom: 10,left: i==0?10:0),
                                padding: EdgeInsets.only(right: 10,top: 10,bottom: 10,left:10),
                                height:45 ,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(Category[i]['CatgImg'],fit: BoxFit.cover,width: SizeConfig.screenWidth,height:20 ,),
                                    SizedBox(width: 5,),
                                    Text(Category[i]['CatgName'],style: TextStyle(fontFamily: 'RR',fontSize: 14,color: i==selectTopSale? Colors.white:Color(0xff959595))),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      alignment: Alignment.topLeft,
                      child: Text('Share Settings',style: TextStyle(fontFamily: 'RB',fontSize:14,color: Color(0xff000000)),),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.lock,size: 20,color: Colors.grey),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Private',style: TextStyle(fontFamily: 'RB',fontSize:14,color: Color(0xff000000)),),
                              Text('Only you can View',style: TextStyle(fontFamily: 'Rr',fontSize:12,color: Colors.grey),),
                            ],
                          ),
                          Spacer(),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                border:Border.all(color: tn.primaryColor,width: 2.0),
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape:BoxShape.circle,
                                color: tn.primaryColor,
                                border:Border.all(color:Colors.white,width: 2.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.group,size: 20,color: Colors.grey),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Shared',style: TextStyle(fontFamily: 'RB',fontSize:14,color: Color(0xff000000)),),
                              Text('Only people with link can View',style: TextStyle(fontFamily: 'Rr',fontSize:12,color: Colors.grey),),
                            ],
                          ),
                          Spacer(),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                border:Border.all(color: tn.primaryColor2,width: 2.0),
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape:BoxShape.circle,
                                color: tn.primaryColor2,
                                border:Border.all(color:Colors.white,width: 2.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.wb_twilight,size: 20,color: Colors.grey),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Publice',style: TextStyle(fontFamily: 'RB',fontSize:14,color: Color(0xff000000)),),
                              Text('Any one search for and View',style: TextStyle(fontFamily: 'Rr',fontSize:12,color: Colors.grey),),
                            ],
                          ),
                          Spacer(),
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                                border:Border.all(color: tn.primaryColor2,width: 1.0),
                                borderRadius: BorderRadius.circular(50)
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  shape:BoxShape.circle,
                                  color: tn.primaryColor2,
                                  border:Border.all(color:Colors.white,width: 3.0),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

              ),
              Positioned(
                  bottom: 0,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WishListView()));
                    },
                    child: Container(
                      width:  SizeConfig.screenWidth,
                      padding: EdgeInsets.only(left: 25,right: 25),
                      height: 50,
                      alignment: Alignment.center,
                      color: tn.primaryColor,
                      child: Text('Add Create New Collection',style: ts16(text2,fontfamily: 'RB'),),
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
