
import '../../notifiers/themeNotifier.dart';
import '../../utils/size.dart';
import '../../widgets/customAppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/innerShadowTBContainer.dart';

class QuestionsAnswerView extends StatefulWidget {

  @override
  _QuestionsAnswerViewState createState() => _QuestionsAnswerViewState();
}

class _QuestionsAnswerViewState extends State<QuestionsAnswerView>with TickerProviderStateMixin {
  late TabController _tabController;
  late  double width,height,width2,height2;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2,  vsync: this);
  }

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
              children: [
                CustomAppBar(title: "My Questions & Answers"),
                Container(
                  padding: EdgeInsets.only(left: 25,right: 25),
                  color:tn.primaryColor2,
                  child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicatorPadding: EdgeInsets.only(top: 45),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0,),
                        color: tn.primaryColor,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 6,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black54,
                      unselectedLabelStyle: TextStyle(fontSize: 14,fontFamily: 'RR'),
                      labelStyle: TextStyle(fontSize: 14,fontFamily: 'RR'),
                      tabs: [
                        Tab(text:"Questions"),
                        Tab(text:"Answer"),
                      ]
                  ),
                ),
                Container(
                  height: SizeConfig.screenHeight!-170,
                  width: SizeConfig.screenWidth!*1,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Align(
                        alignment:Alignment.topCenter,
                        child: Container(
                          width: SizeConfig.screenWidth!*1,
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              InnerShadowTBContainer(
                                height: SizeConfig.screenHeight!-230,
                                width: SizeConfig.screenWidth!*1,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: 1,
                                  physics: BouncingScrollPhysics(),
                                  itemBuilder: (ctx,i){
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 15,left: 20,right: 20,top:i==0? 10:0),
                                      width: SizeConfig.screenWidth!*1,
                                      padding: EdgeInsets.only(top: 10,bottom: 10),
                                      decoration:i==0? BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Color(0XFFF5F5F5)),
                                        boxShadow: [
                                          BoxShadow(color: Colors.black26, spreadRadius: 0,blurRadius: 9,
                                            offset: Offset(
                                              0.0, // Move to right 10  horizontally
                                              5.0, // Move to bottom 10 Vertically),
                                            ),),
                                        ],
                                        color: Color(0XFFffffff),
                                      ): BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Color(0XFFF5F5F5)),
                                        color: Color(0XFFffffff),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  margin: EdgeInsets.only(left: 10, right: 10),
                                                  alignment: Alignment.center,
                                                  child: Image.asset("assets/product/Carrot2.png",width: 60,),
                                                ),
                                                SizedBox(width: 10,),
                                                Flexible(child: Text('Carrots fructose and glucose content are primarily due to them being high in fiber',style: TextStyle(fontSize: 13,fontFamily: 'RR',color: Color(0xffA1A1A1),),))
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 10,right: 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Q : ',style: TextStyle(fontFamily: 'RB',fontSize:14,color: Color(0xff000000)),),
                                                    Flexible(child: Text('laptop, Power Adaptor, User Guide,Warranty Document ?',style: TextStyle(fontFamily: 'RR',fontSize:12,color: Color(0xff000000)),)),
                                                  ],
                                                ),
                                                Text('No Answer received yet',style: TextStyle(fontFamily: 'RR',fontSize:12,color:Colors.black38),),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment:Alignment.topCenter,
                        child: Container(
                          width: SizeConfig.screenWidth!*1,
                          child: Column(
                            children: [
                              SizedBox(height: 20,),

                              //

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
