
import '../../model/orderedReceivedModel.dart';
import '../../notifiers/themeNotifier.dart';
import '../../pages/Profile/myProfileEdit.dart';
import '../../utils/constants.dart';
import '../../utils/size.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/innerShadowTBContainer.dart';
import '../myOrder/orderNoPage.dart';



class MyOrderView extends StatefulWidget {

  @override
  _MyOrderViewState createState() => _MyOrderViewState();
}

class _MyOrderViewState extends State<MyOrderView> {
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
                    CustomAppBar(title: "My Order"),
                    Align(
                      alignment: Alignment.center,
                      child: InnerShadowTBContainer(
                        height: SizeConfig.screenHeight!-154,
                        width:width*0.95,
                        child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: 7,
                            itemBuilder: (ctx,i){
                              return Column(
                                children: [
                                  // SizedBox(height: 20,),
                                  Container(
                                    width: width,
                                    height: 85,
                                    margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 15),
                                    padding: const EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(color:text1.withOpacity(0.2),),
                                    ),
                                    child:GestureDetector(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>OrderNoDetails()));
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset('assets/product/Carrot2.png'),
                                          SizedBox(width: 5,),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width:SizeConfig.screenWidth!-129,
                                                  child:Row(
                                                    children: [
                                                      Text('Rs.2,532.00',style: TextStyle(fontFamily: 'RM',fontSize: 16,color: text1,),),
                                                      Spacer(),
                                                      Row(
                                                        children: [
                                                          Icon(Icons.menu,color:tn.primaryColor,size: 20,),
                                                          SizedBox(width: 2,),
                                                          // Text('Nov-14-2021',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:text1.withOpacity(0.5),),),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                              ),
                                              SizedBox(height: 5,),
                                              Row(
                                                children: [
                                                  Container(
                                                    child:Text('Order id : ',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:text1.withOpacity(0.9),),),
                                                  ),
                                                  Text.rich(
                                                    TextSpan(
                                                      text: '32352342 ',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:text1.withOpacity(0.9),), // default text style
                                                      children: [
                                                        TextSpan(text: '   Delivery ', style: TextStyle(fontFamily: 'RR',fontSize: 12,color:tn.primaryColor)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5,),
                                              Container(
                                                width:SizeConfig.screenWidth!-129,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      child:Text('28 Items  ',style: TextStyle(fontFamily: 'RI',fontSize: 13,color:text1.withOpacity(0.5),),),
                                                    ),
                                                    Text('View Product',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:tn.primaryColor),),
                                                    Spacer(),
                                                    Text('Reorder',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:tn.primaryColor),)
                                                  ],
                                                ),
                                              ),

                                              SizedBox(width: 10,),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                  ],
                ),

              ),
              // Positioned(
              //     bottom: 0,
              //     child: GestureDetector(
              //       onTap: (){
              //         Navigator.push(context, MaterialPageRoute(builder: (ctx)=>WishListView()));
              //       },
              //       child: Container(
              //         width:  SizeConfig.screenWidth,
              //         padding: EdgeInsets.only(left: 25,right: 25),
              //         height: 50,
              //         alignment: Alignment.center,
              //         color: tn.primaryColor,
              //         child: Text('Add Create New Collection',style: ts16(text2,fontfamily: 'RB'),),
              //       ),
              //     )
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
