import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../notifiers/themeNotifier.dart';
import '../../utils/constants.dart';
import '../../utils/size.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/linearProgressBar.dart';
import '../address/addressHome.dart';
import 'Cartpage.dart';

final List<String> imgList = [
  'assets/product/Carrot1.png',
  'assets/product/Carrot2.png',
  'assets/product/Carrot3.png',
];
class ViewProductDetails extends StatefulWidget {
  @override
  _ViewProductDetailsState createState() => _ViewProductDetailsState();
}
int _current = 0;
final CarouselController _controller = CarouselController();
final List<Widget> imageSliders = imgList
    .map((item) => Container(
  child: Container(
    //margin: EdgeInsets.all(5.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Image.asset(item, fit: BoxFit.cover,),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),

              ),
            ),
          ],
        )),
  ),
))
    .toList();
@override
class _ViewProductDetailsState extends State<ViewProductDetails>with TickerProviderStateMixin {

  late TabController _tabController;
  late  double width,height,width2,height2;
  TextEditingController textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3,  vsync: this);
  }
  bool value = false;

  Widget build(BuildContext context) {
    SizeConfig().init(context);
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    return SafeArea(
      child:Consumer<ThemeNotifier>(
        builder:(ctx,tn,child)=> Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.white,
              body: Container(
                width: width,
                 height: height,
                 margin: EdgeInsets.only(left: 15,right: 15),
                 alignment: Alignment.topCenter,
                 child: SingleChildScrollView(
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Container(
                         height: 80,
                         width: width*1,
                         child:Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             GestureDetector(
                               onTap: (){
                                 Navigator.pop(context,);
                               },
                               child: Container(
                                   width: 40,
                                   height: 40,
                                   decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(10.0),
                                       //border: Border.all(color: Color(0xff5D5C51),style:BorderStyle.solid )
                                       color:Color(0xffF1F1F1),
                                   ) ,
                                   alignment: Alignment.center,
                                   child:   Icon(Icons.chevron_left,color: Color(0xff000000 ),size: 25,)
                               ),
                             ),
                             Container(
                               child: Text('Details',style: TextStyle(fontFamily: 'RB',fontSize:16,color: Color(0xff000000)),),
                             ),
                             Container(
                                 // width: 40,
                                 // height: 40,
                                 // decoration: BoxDecoration(
                                 //   borderRadius: BorderRadius.circular(10.0),
                                 //   //border: Border.all(color: Color(0xff5D5C51),style:BorderStyle.solid )
                                 //   color:Color(0xffF1F1F1),
                                 // ) ,
                                 // alignment: Alignment.center,
                                 // child:   Icon(Icons.chevron_left,color: Color(0xff000000 ),size: 25,)
                             )
                           ],
                         ),
                       ),
                       SizedBox(height: 10,),
                       Container(
                         width: width*1,
                         child:Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Container(
                               width: 80,
                               height: 30,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(25),
                                 color:tn.primaryColor,
                               ),
                               alignment: Alignment.center,
                               child: Text('Off 20%',style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'RI',fontWeight: FontWeight.bold),),
                             ),
                             Container(
                               width: 35,
                               height: 35,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(20),
                                 color: Colors.white,
                                 boxShadow: [
                                   BoxShadow(
                                     color:Color(0xFF000000).withOpacity(0.15),
                                     blurRadius: 10.0, // soften the shadow
                                     spreadRadius: 0.0, //extend the shadow
                                     offset: Offset(
                                       0.0, // Move to right 10  horizontally
                                       0.0, // Move to bottom 10 Vertically
                                     ),
                                   )
                                 ],
                               ),
                               child: Icon(Icons.favorite,color: tn.primaryColor2,size: 22,),
                             ),
                           ],
                         ),
                       ),
                       Container(
                         alignment: Alignment.topCenter,
                         child: Column(
                           mainAxisSize: MainAxisSize.min,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Container(
                               height:250,
                               width: 1000,
                               child: Column(
                                 children: [
                                   Expanded(
                                     child: CarouselSlider(
                                       items: imageSliders,
                                       carouselController: _controller,
                                       options: CarouselOptions(
                                           autoPlay: false,
                                           viewportFraction: 1,
                                           pageSnapping: false,
                                           enlargeCenterPage: true,
                                           aspectRatio: 2.0,
                                           onPageChanged: (index, reason) {
                                             setState(() {
                                               _current = index;
                                             });
                                           }),
                                     ),
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     children: imgList.asMap().entries.map((entry) {
                                       return GestureDetector(
                                         onTap: () => _controller.animateToPage(entry.key),
                                         child: Container(
                                           width: 12.0,
                                           height: 12.0,
                                           margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                                           decoration: BoxDecoration(
                                               shape: BoxShape.circle,
                                               color: (Theme.of(context).brightness == Brightness.dark
                                                   ? Colors.white
                                                   : Color(0XFF657D26))
                                                   .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                                         ),
                                       );
                                     }).toList(),
                                   ),
                                 ],
                               ),
                             ),
                             // Container(
                             //   child: Image.asset('assets/items-list/tomato.png',width: 200,fit: BoxFit.cover,),
                             //
                             // ),
                             Container(
                               alignment: Alignment.topCenter,
                               child: Column(
                                 mainAxisSize: MainAxisSize.min,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Container(
                                     child: Text('Carrot',style: TextStyle(fontFamily: 'RB',color: Colors.black,fontSize: 18),),
                                   ),
                                   SizedBox(height: 5,),
                                   Container(
                                     child: RichText(
                                       text: TextSpan(
                                         text: '1 Kg ',
                                         style: TextStyle(color: Color(0xff000000),fontSize: 13,fontFamily: 'RR'),
                                         children: <TextSpan>[
                                           TextSpan(text: ' 35.00', style: TextStyle(fontSize: 13,fontFamily: 'RR',color: Color(0XFF919191),decoration: TextDecoration.lineThrough)),
                                           TextSpan(text: ' Rs.23.00', style: TextStyle(fontSize: 13,fontFamily: 'RB',color:tn.primaryColor,),),
                                         ],
                                       ),

                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             SizedBox(height: 15,),
                             Container(
                               width: width*1,
                               height: 160,
                               padding: EdgeInsets.all(10),
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(10.0),
                                 //border: Border.all(color: Color(0xff5D5C51),style:BorderStyle.solid )
                                 color:Color(0xffF1F1F1),
                               ) ,
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text('Description',style: TextStyle(fontFamily: 'RB',color: Colors.black,fontSize: 16),),
                                   SizedBox(height: 5,),
                                   Text('Carrot, (Solanum lycopersicum), flowering plant of the nightshade family (Solanaceae), cultivated extensively for its edible fruits. ... The fruits are commonly eaten raw in salads, served as a cooked vegetable, used as an ingredient of various prepared dishes, and pickled.',style: TextStyle(fontFamily: 'RR',color: Colors.black,fontSize: 14),),
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                       SizedBox(height: 30,),
                       Container(
                         width: SizeConfig.screenWidth!*1,
                       // height: 200,
                         alignment: Alignment.topCenter,
                         decoration: BoxDecoration(
                             border: Border.all(color: Color(0XFFECECEC))
                         ),
                         child: Column(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             Container(
                               padding: EdgeInsets.only(left: 10,right: 10),
                               child: TabBar(
                                   isScrollable: true,
                                   controller: _tabController,
                                   // give the indicator a decoration (color and border radius)
                                   indicatorPadding: EdgeInsets.only(top: 45),
                                   indicator: BoxDecoration(
                                     borderRadius: BorderRadius.circular(20.0,),
                                     color: tn.primaryColor1,
                                   ),
                                  // indicatorSize: TabBarIndicatorSize.tab,
                                   indicatorWeight: 6,
                                   labelColor: tn.primaryColor,
                                   unselectedLabelColor: Color(0XFF262626),
                                   unselectedLabelStyle: TextStyle(fontSize: 14,fontFamily: 'RR',),
                                   labelStyle: TextStyle(fontSize: 14,fontFamily: 'RR'),
                                   tabs: [
                                     Tab(text:"Specifications",),
                                     Tab(text:"Additional Info"),
                                     Tab(text:"View all"),
                                   ]
                               ),
                             ),
                             Container(
                                height: SizeConfig.screenHeight!-450,
                                width: SizeConfig.screenWidth!*1,
                               child: TabBarView(
                                 controller: _tabController,
                                 children: [
                                   Container(
                                     alignment: Alignment.topLeft,
                                     width: SizeConfig.screenWidth!*1,
                                     padding: EdgeInsets.only(left: 15,right: 15),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         SizedBox(height: 20,),
                                         Text('General',style: ts18(grey,fontsize: 17),),
                                         Expanded(
                                           child: ListView.builder(
                                             itemCount: 10,
                                             itemBuilder: (ctx,i){
                                               return Row(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Container(
                                                     width:(SizeConfig.screenWidth!*0.5)-37,
                                                     padding: EdgeInsets.only(top: 8,bottom: 8),
                                                     alignment: Alignment.centerLeft,
                                                     child: Text("Sales Package",style: ts12(grey.withOpacity(0.7)),),
                                                   ),
                                                   Container(
                                                     width:(SizeConfig.screenWidth!*0.5)-36,
                                                     padding: EdgeInsets.only(top: 8,bottom: 8),
                                                     alignment: Alignment.centerLeft,
                                                     child: Text("Laptop, Power Adaptar",style: ts12(text1),),
                                                   ),
                                                 ],
                                               );
                                             },
                                           ),
                                         )
                                       ],
                                     ),
                                   ),
                                   Container(
                                     alignment: Alignment.topLeft,
                                     width: SizeConfig.screenWidth!*1,
                                     padding: EdgeInsets.only(left: 15,right: 15),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         SizedBox(height: 20,),
                                         Text('Information',style: ts18(grey,fontsize: 17),),
                                         Expanded(
                                           child: ListView.builder(
                                             itemCount: 10,
                                             itemBuilder: (ctx,i){
                                               return Row(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Container(
                                                     width:(SizeConfig.screenWidth!*0.5)-37,
                                                     padding: EdgeInsets.only(top: 8,bottom: 8),
                                                     alignment: Alignment.centerLeft,
                                                     child: Text("Sales Package",style: ts12(grey.withOpacity(0.7)),),
                                                   ),
                                                   Container(
                                                     width:(SizeConfig.screenWidth!*0.5)-36,
                                                     padding: EdgeInsets.only(top: 8,bottom: 8),
                                                     alignment: Alignment.centerLeft,
                                                     child: Text("Laptop, Power Adaptar",style: ts12(text1),),
                                                   ),
                                                 ],
                                               );
                                             },
                                           ),
                                         )
                                       ],
                                     ),
                                   ),
                                   Container(
                                     alignment: Alignment.topLeft,
                                     width: SizeConfig.screenWidth!*1,
                                     padding: EdgeInsets.only(left: 15,right: 15),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         SizedBox(height: 20,),
                                         Text('General',style: ts18(grey,fontsize: 17),),
                                         Expanded(
                                           child: ListView.builder(
                                             itemCount: 10,
                                             itemBuilder: (ctx,i){
                                               return Row(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Container(
                                                     width:(SizeConfig.screenWidth!*0.5)-37,
                                                     padding: EdgeInsets.only(top: 8,bottom: 8),
                                                     alignment: Alignment.centerLeft,
                                                     child: Text("Sales Package",style: ts12(grey.withOpacity(0.7)),),
                                                   ),
                                                   Container(
                                                     width:(SizeConfig.screenWidth!*0.5)-36,
                                                     padding: EdgeInsets.only(top: 8,bottom: 8),
                                                     alignment: Alignment.centerLeft,
                                                     child: Text("Laptop, Power Adaptar",style: ts12(text1),),
                                                   ),
                                                 ],
                                               );
                                             },
                                           ),
                                         )
                                       ],
                                     ),
                                   ),

                                   /*  Align(
                                   alignment:Alignment.topCenter,
                                   child: Container(
                                     width: SizeConfig.screenWidth!*1,
                                     child: Column(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         SizedBox(height: 20,),
                                         Text('hhhghghg')
                                       ],
                                     ),
                                   ),
                                 ),
                                 Align(
                                   alignment:Alignment.topCenter,
                                   child: Container(
                                     width: SizeConfig.screenWidth!*1,
                                     child: Column(
                                       mainAxisSize: MainAxisSize.min,
                                       children: [
                                         SizedBox(height: 20,),
                                             Text('hhhghghg')
                                       ],
                                     ),
                                   ),
                                 ),*/
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                       SizedBox(height: 10,),
                       Container(
                         width: width*1,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Container(
                                 child: Row(
                               children: [
                                 Text('Quantity :',style: TextStyle(fontFamily: 'RB',color: Colors.black,fontSize: 16),),
                                 Container(
                                   child: RichText(
                                     text: TextSpan(
                                       text: '1 Kg ',
                                       style: TextStyle(color: Color(0xff000000),fontSize: 14,fontFamily: 'RR'),
                                       children: <TextSpan>[
                                         TextSpan(text: ' 35.00', style: TextStyle(fontSize: 14,fontFamily: 'RR',color: Color(0XFF919191),decoration: TextDecoration.lineThrough)),
                                         TextSpan(text: ' Rs.23.00', style: TextStyle(fontSize: 14,fontFamily: 'RB',color:tn.primaryColor,),),
                                       ],
                                     ),

                                   ),
                                 ),
                               ],
                             )),

                             Align(
                               alignment: Alignment.center,
                               child:  Container(
                                 height: 36,
                                 width: width*0.25,
                                 margin: EdgeInsets.only(left: 15),
                                 decoration: BoxDecoration(
                                     color:tn.primaryColor,
                                     borderRadius:BorderRadius.circular(10)
                                 ),
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                   children: [
                                     addRemoveBtn(Icon(Icons.add,color: tn.primaryColor,size: 20,)),
                                     Text("1",style: TSWhite166,),
                                     addRemoveBtn(Icon(Icons.remove,color: tn.primaryColor,size: 20,)),
                                   ],
                                 ),
                               ),
                             )
                           ],
                         ),
                       ),
                       SizedBox(height: 10,),
                       // GestureDetector(
                       //   onTap: (){
                       //     Navigator.pop(context,);
                       //   },
                       //   child: Container(
                       //     width: 200,
                       //     height: 50,
                       //     decoration: BoxDecoration(
                       //         color:tn.primaryColor,
                       //         borderRadius:BorderRadius.circular(10)
                       //     ),
                       //     alignment: Alignment.center,
                       //     child: Text('Add',style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'RR'),),
                       //   ),
                       // ),
                       // SizedBox(height: 10,),
                       Container(
                         padding: EdgeInsets.only(top: 10,bottom: 10),
                         decoration: BoxDecoration(
                           color:Colors.white,
                           border: Border(top:BorderSide(color: tn.primaryColor2,),bottom:BorderSide(color: tn.primaryColor2,) )
                         ),
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Container(
                                     child: Row(
                                         children: [
                                         Text('Delivery To :',style: TextStyle(fontFamily: 'RR',color: Colors.black,fontSize: 14),),
                                         Text('Bala, 600077 ',style: TextStyle(fontFamily: 'RB',color: Colors.black,fontSize: 14),),
                                         Container(
                                           padding: EdgeInsets.all(5),
                                           decoration: BoxDecoration(
                                               color:tn.primaryColor2,
                                               borderRadius:BorderRadius.circular(10)
                                           ),
                                           alignment: Alignment.center,
                                           child: Text('Home',style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'RR'),),
                                         ),
                                       ],
                                     )
                                 ),
                                 Container(
                                   child:Text('N0:49,Tts Nagar, 4th Street, Thiruverkadu',style: TextStyle(fontFamily: 'RR',color: Colors.grey,fontSize: 13),),
                                 ),
                               ],
                             ),
                             GestureDetector(
                               onTap: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddressHomePage()));
                               },
                               child: Container(
                                 padding: EdgeInsets.all(10),
                                 decoration: BoxDecoration(
                                     color:tn.primaryColor2,
                                     borderRadius:BorderRadius.circular(3)
                                 ),
                                 alignment: Alignment.center,
                                 child: Text('Change',style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: 'RR'),),
                               ),
                             ),
                           ],
                         ),
                       ),
                       SizedBox(height: 10,),
                       Container(
                         padding: EdgeInsets.only(top: 10,bottom: 10),
                         decoration: BoxDecoration(
                             color:Colors.white,
                             border: Border(top:BorderSide(color: tn.primaryColor2,),bottom:BorderSide(color: tn.primaryColor2,) )
                         ),
                         child:  Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Container(
                                 child: Row(
                                   children: [
                                     Text('Sold by :',style: TextStyle(fontFamily: 'RR',color: Colors.black,fontSize: 14),),
                                     Text('BalaGroceryFarm ',style: TextStyle(fontFamily: 'RR',color: Colors.black,fontSize: 14),),
                                     Container(
                                       padding: EdgeInsets.all(2),
                                       decoration: BoxDecoration(
                                           color:tn.primaryColor2,
                                           borderRadius:BorderRadius.circular(10)
                                       ),
                                       alignment: Alignment.center,
                                       child: Text('4.5 ⋆',style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: 'RB'),),
                                     ),
                                   ],
                                 )
                             ),
                             Text('Delivery in',style: TextStyle(fontFamily: 'RR',color: Colors.black,fontSize: 13),),
                             Text('2 Days, Monday',style: TextStyle(fontFamily: 'RB',color: Colors.black,fontSize: 14),),
                             Text('if Ordered before 7:56 PM',style: TextStyle(fontFamily: 'RR',color: Colors.black,fontSize: 10),),
                           ],
                         ),
                       ),
                       SizedBox(height: 10,),
                       Container(
                         alignment: Alignment.topLeft,
                         child: Text('Ratings & reviews',style: TextStyle(fontFamily: 'RB',fontSize:16,color: Color(0xff000000)),),
                       ),
                       SizedBox(height: 10,),
                       Container(
                         padding: EdgeInsets.only(top: 10,bottom: 10),
                         height: 140,
                         child: Row(
                           children: [
                             Container(
                               width: SizeConfig.screenWidth!*0.4,
                               child: Column(
                                 children: [
                                   RatingBar.builder(
                                     initialRating: 2.5,
                                     minRating: 1,
                                     direction: Axis.horizontal,
                                     allowHalfRating: true,
                                     itemCount: 5,
                                     itemSize: 20,
                                     itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                                     unratedColor: text1.withOpacity(0.3),
                                     itemBuilder: (context, _) => Icon(
                                       Icons.star,
                                       color: tn.primaryColor,
                                     ),
                                     onRatingUpdate: (rating) {
                                       print(rating);
                                     },
                                   ),
                                   Text('3.3',style: TextStyle(fontFamily: 'RB',fontSize:28,color: Color(0xff000000)),),
                                   Text('Avg.Rating',style: TextStyle(fontFamily: 'RB',fontSize:14,color: text1.withOpacity(0.3)),),
                                   SizedBox(height: 10,),
                                   Text('3 Ratings',style: TextStyle(fontFamily: 'RB',fontSize:18,color: Color(0xff000000)),),
                                 ],
                               ),
                             ),
                             Container(
                               color: Colors.grey,
                               width: 1,
                               height:SizeConfig.screenHeight,
                             ),
                             Container(
                               width: SizeConfig.screenWidth!*0.5,
                               padding: EdgeInsets.only(left: 10,right: 0),
                               child: Column(
                                 children: [
                                   LinearPercentIndicator(
                                     width: 150.0,
                                     leading: Text('5',style: TextStyle(fontFamily: 'RB',fontSize:15,color: Color(0xff000000)),),
                                     trailing: Text('4',style: TextStyle(fontFamily: 'RB',fontSize:15,color: Color(0xff828282)),),
                                     lineHeight: 8.0,
                                     percent: 0.4,
                                     progressColor: tn.primaryColor,
                                   ),
                                   LinearPercentIndicator(
                                     width: 150.0,
                                     leading: Text('4',style: TextStyle(fontFamily: 'RB',fontSize:15,color: Color(0xff000000)),),
                                     trailing: Text('2',style: TextStyle(fontFamily: 'RB',fontSize:15,color: Color(0xff828282)),),
                                     lineHeight: 8.0,
                                     percent: 0.2,
                                     progressColor: tn.primaryColor,
                                   ),
                                   LinearPercentIndicator(
                                     width: 150.0,
                                     leading: Text('3',style: TextStyle(fontFamily: 'RB',fontSize:15,color: Color(0xff000000)),),
                                     trailing: Text('0',style: TextStyle(fontFamily: 'RB',fontSize:15,color: Color(0xff828282)),),
                                     lineHeight: 8.0,
                                     percent: 0,
                                     progressColor: tn.primaryColor,
                                   ),
                                   LinearPercentIndicator(
                                     width: 150.0,
                                     leading: Text('2',style: TextStyle(fontFamily: 'RB',fontSize:15,color: Color(0xff000000)),),
                                     trailing: Text('1',style: TextStyle(fontFamily: 'RB',fontSize:15,color: Color(0xff828282)),),
                                     lineHeight: 8.0,
                                     percent: 0.4,
                                     progressColor: tn.primaryColor,
                                   ),
                                   LinearPercentIndicator(
                                     width: 150.0,
                                     leading: Text('1',style: TextStyle(fontFamily: 'RB',fontSize:15,color: Color(0xff000000)),),
                                     trailing: Text('0',style: TextStyle(fontFamily: 'RB',fontSize:15,color: Color(0xff828282)),),
                                     lineHeight: 8.0,
                                     percent: 0,
                                     progressColor: tn.primaryColor,
                                   ),
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                       SizedBox(height: 10,),
                       Wrap(
                       spacing: 10,
                       runSpacing: 10,
                       runAlignment: WrapAlignment.start,
                       children: [
                         Container(
                           width:100,
                           height: 100,
                           decoration:BoxDecoration(
                             borderRadius: BorderRadius.circular(10),
                             color: Colors.black12
                           ),
                           clipBehavior: Clip.antiAlias,
                           child:Image.asset('assets/product/Carrot1.png',)
                         ),
                         Container(
                             width:100,
                             height: 100,
                             decoration:BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.black12
                             ),
                             clipBehavior: Clip.antiAlias,
                             child:Image.asset('assets/product/Carrot2.png',)
                         ),
                         Container(
                             width:100,
                             height: 100,
                             decoration:BoxDecoration(
                                 borderRadius: BorderRadius.circular(10),
                                 color: Colors.black12
                             ),
                             clipBehavior: Clip.antiAlias,
                             child:Image.asset('assets/product/Carrot3.png',)
                         ),
                         Container(
                           width:100,
                           height: 100,
                           clipBehavior: Clip.antiAlias,
                           decoration:BoxDecoration(
                               borderRadius: BorderRadius.circular(10)
                           ),
                           child: Stack(
                             children: [
                               Container(
                                  child:Image.asset('assets/product/Carrot2.png',)
                               ),
                               Positioned(
                                   child: Container(
                                       width:100,
                                       height: 100,
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
                       SizedBox(height: 10,),
                       Container(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: [
                             Text('Question & Answer',style: TextStyle(fontFamily: 'RB',fontSize:16,color: Color(0xff000000)),),
                             AnimSearchBar(
                               width: SizeConfig.screenWidth!-167,
                               textController: textController,
                               onSubmitted: (a){},
                               onSuffixTap: () {
                                 setState(() {
                                   textController.clear();
                                 });
                               },
                             ),
                           ],
                         ),
                       ),
                       SizedBox(height: 10,),
                       Column(
                         children: [
                           Container(
                             width: SizeConfig.screenWidth,
                             child: Row(
                               children: [
                                 Text('Q : ',style: TextStyle(fontFamily: 'RB',fontSize:14,color: Color(0xff000000)),),
                                 Text('laptop, Power Adaptor, User Guide,Warranty Document ?',style: TextStyle(fontFamily: 'RR',fontSize:12,color: Color(0xff000000)),),
                               ],
                             ),
                           ),
                           Row(
                             children: [
                               Text('A : ',style: TextStyle(fontFamily: 'RB',fontSize:14,color: Color(0xff000000)),),
                               Container(
                                 width: SizeConfig.screenWidth!-52,
                                 child: Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Text('laptop, Power Adaptor, User Guide',style: TextStyle(fontFamily: 'RR',fontSize:12,color: Colors.grey,),),
                                     Row(
                                       children: [
                                         LikeButton(
                                           size: 20,
                                           likeCount: 665,
                                           isLiked: true,
                                         ),
                                         SizedBox(width: 5,),
                                         LikeButton(
                                           size: 20,
                                           likeCount: 65,
                                           isLiked: false,
                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                             ],
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: <Widget>[
                               SizedBox(width: 10), //SizedBox
                               /** Checkbox Widget **/
                               Checkbox(
                                 value: this.value,
                                 onChanged: ( value) {
                                   setState(() {
                                     this.value = true;
                                   });
                                 },
                               ),
                               SizedBox(
                                 width: 5,
                               ), //SizedBox
                               Text(
                                 'Do you Want raise new question: ',
                                 style: TextStyle(fontSize: 12.0),
                               ), //Text//Checkbox
                             ], //<Widget>[]
                           ),
                         ],
                       ),
                       TextField(
                         onChanged: (value) {
                           //Do something with the user input.
                         },
                         decoration: InputDecoration(
                           hintText: 'Enter your Questions.',helperStyle:TextStyle(fontSize: 12),
                           contentPadding:
                           EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.all(Radius.circular(3.0)),
                           ),
                           enabledBorder: OutlineInputBorder(
                             borderSide:
                             BorderSide(color:Colors.grey, width: 1.0),
                             borderRadius: BorderRadius.all(Radius.circular(3.0)),
                           ),
                           focusedBorder: OutlineInputBorder(
                             borderSide:
                             BorderSide(color: tn.primaryColor, width: 1.0),
                             borderRadius: BorderRadius.all(Radius.circular(3.0)),
                           ),
                         ),
                       ),
                       SizedBox(height: 10,),
                       Container(
                         width: SizeConfig.screenWidth,
                         height: 50,
                         decoration: BoxDecoration(
                             color:tn.primaryColor,
                             borderRadius:BorderRadius.circular(10)
                         ),
                         alignment: Alignment.center,
                         child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'RR'),),
                       ),
                       SizedBox(height: 100,),
                     ],
                   ),
                 ),
              ),

            ),
            Positioned(
                bottom: -15,
                child: BottomNavi()
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()),);
                  },
                  child: Container(
                      width: 60,
                      height: 60,
                      margin: EdgeInsets.only(bottom: 15),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:tn.primaryColor,
                        boxShadow: [
                          BoxShadow(
                            color: tn.primaryColor.withOpacity(0.3),
                            blurRadius: 25.0, // soften the shadow
                            spreadRadius: 5.0, //extend the shadow
                            offset: Offset(
                              0.0, // Move to right 10  horizontally
                              10.0, // Move to bottom 10 Vertically
                            ),
                          )
                        ],
                      ),
                      child: Stack(
                        children: [
                          Image.asset("assets/items-list/cart.png",width: 30,),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              width: 15,
                              height: 15,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:Color(0xff9E203F),
                              ),
                              child: Text('12',style: TextStyle(fontFamily: 'RM',fontSize: 10,color:Colors.white),),
                            ),
                          )
                        ],
                      )
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}






addRemoveBtn(Widget icon){
  return Container(
    height: 25,
    width: 25,
    decoration: BoxDecoration(
        color:Colors.white,
        borderRadius:BorderRadius.circular(5)
    ),
    child: Center(
      child: icon,
    ),
  );
}


