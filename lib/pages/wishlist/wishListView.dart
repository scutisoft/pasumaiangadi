
import '../../notifiers/themeNotifier.dart';
import '../../utils/constants.dart';
import '../../utils/size.dart';
import '../../widgets/customAppBar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addWishList.dart';

class WishListView extends StatefulWidget {

  @override
  _WishListViewState createState() => _WishListViewState();
}

class _WishListViewState extends State<WishListView> {
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
                  padding: EdgeInsets.only(left: 15,right: 15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomAppBar(title: "WishList"),
                      Container(
                        height: 100,
                        width: SizeConfig.screenWidth,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          children: [
                            Container(
                                width:100,
                                height: 100,
                                margin: EdgeInsets.only(right: 5),
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                clipBehavior: Clip.antiAlias,
                                child:Image.asset('assets/product-image/Areca-4.5-round-bowl.png',fit: BoxFit.cover,)
                            ),
                            Container(
                                width:100,
                                height: 100,
                                margin: EdgeInsets.only(right: 5),
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                clipBehavior: Clip.antiAlias,
                                child:Image.asset('assets/product-image/Areca-4.5-round-bowl.png',fit: BoxFit.cover,)
                            ),
                            Container(
                                width:100,
                                height: 100,
                                margin: EdgeInsets.only(right: 5),
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                clipBehavior: Clip.antiAlias,
                                child:Image.asset('assets/product-image/Areca-4.5-round-bowl.png',fit: BoxFit.cover,)
                            ),
                            Container(
                                width:100,
                                height: 100,
                                margin: EdgeInsets.only(right: 5),
                                decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  color: Colors.black12
                                ),
                                clipBehavior: Clip.antiAlias,
                                child:Image.asset('assets/product/Carrot2.png', fit: BoxFit.cover,)
                            ),
                            Container(
                              width:100,
                              height: 150,
                              margin: EdgeInsets.only(right: 5),
                              clipBehavior: Clip.antiAlias,
                              decoration:BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Stack(
                                children: [
                                  Container(
                                      width:100,
                                      height: 150,
                                      child:Image.asset('assets/product-image/Areca-4.5-round-bowl.png',fit: BoxFit.cover,)
                                  ),
                                  Positioned(
                                    child: Container(
                                      width:100,
                                      height: 150,
                                      alignment: Alignment.center,
                                      decoration:BoxDecoration(
                                          color: Colors.black.withOpacity(0.5)
                                      ),
                                      child:Text('+12',style: TextStyle(fontFamily: 'RB',fontSize:15,color: Color(0xffffffff)),),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text('My WishList',style: TextStyle(fontFamily: 'RB',fontSize:16,color: Color(0xff000000)),),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Icon(Icons.lock,size: 15,color:Colors.grey),
                            SizedBox(width: 2),
                            Text('Privat'+' . ',style: TextStyle(fontFamily: 'RR',fontSize:14,color: Colors.grey),),
                            Text('4 Items'+'.',style: TextStyle(fontFamily: 'RR',fontSize:14,color: Colors.grey,),)
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
                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddWishListView()));
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
