import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasumaiangadi/utils/utils.dart';
import 'package:pasumaiangadi/widgets/noDataFound.dart';
import '../../HappyExtension/extensionHelper.dart';
import 'package:provider/provider.dart';
import '../../notifiers/themeNotifier.dart';
import '../../utils/colorUtil.dart';
import '../../utils/constants.dart';
import '../../utils/general.dart';
import '../../utils/size.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';
import 'viewProductDetail.dart';



class ViewAllItems extends StatefulWidget {
  const ViewAllItems({Key? key}) : super(key: key);

  @override
  _ViewAllItemsState createState() => _ViewAllItemsState();
}

class _ViewAllItemsState extends State<ViewAllItems> with HappyExtensionHelper implements HappyExtensionHelperCallback{
  late  double width,height,width2,height2, gridWidth;
  int selectTopSale=0;
  bool isGridView=true;
  int selectAddRemove=-1;
  List<dynamic> FavItems=[
    {"FavImg":"assets/shop/thumbnail-1.jpg","FavItemName":"Carrot","Rate":"₹5","Rate1":"₹23.00","discount":"10%","kg":"1Kg",},
    {"FavImg":"assets/shop/thumbnail-2.jpg","FavItemName":"Capsicum","Rate":"₹5","Rate1":"₹23.00","discount":"10%","kg":"1Kg",},
    {"FavImg":"assets/product-image/apple__1_-removebg-preview.png","FavItemName":"Apple","Rate":"₹5","Rate1":"₹23.00","discount":"10%","kg":"1Kg",},
    {"FavImg":"assets/shop/thumbnail-5.jpg","FavItemName":"WaterMelon","Rate":"₹5","Rate1":"₹23.00","discount":"10%","kg":"1Kg",},
    {"FavImg":"assets/shop/thumbnail-8.jpg","FavItemName":"Mango Slice","Rate":"₹5","Rate1":"₹23.00","discount":"10%","kg":"1Kg",},
  ];


  var productList=[].obs;

  @override
  void initState(){
    assignWidgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    width2=width-16;
    height2=height-16;
    gridWidth=width-30;
    return Scaffold(
      body: SafeArea(
        child: Consumer<ThemeNotifier>(
          builder:(ctx,tn,child)=> NestedScrollView(
           floatHeaderSlivers: true,
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(

                  elevation: 0,

                  backgroundColor: tn.primaryColor,
                  leading: Container(),
                  actions: [
                    Container(
                      width:SizeConfig.screenWidth ,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width:width*0.8,
                              height: 45,
                              child: CompanySettingsTextField(
                                  enable: false,
                                  hintText: "Search Product", img: "assets/search.png")
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                isGridView=!isGridView;
                                selectAddRemove=-1;
                              });
                            },
                            child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(color: Color(0xffffffff),style:BorderStyle.solid )

                                ) ,
                                child:   Icon(isGridView?Icons.dashboard_outlined:Icons.list,
                                  color: Color(0xffffffff),)
                            ),
                          ),
                          /*Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: tn.primaryColor1,
                              ) ,
                              child:   Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/Filter.png',width: 20,),
                                ],
                              )
                          ),*/
                        ],
                      ),
                    ),
                  ],
                  floating: true,
                //  pinned: true,
                ),
              ];
            },
            body: Container(
              width: SizeConfig.screenWidth,
              color: Colors.white,
            //  clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Obx(() => InnerShadowTBContainer(
                      height: SizeConfig.screenHeight!-235,
                      width: SizeConfig.screenWidth!,
                      child:isGridView? Padding(
                        padding: EdgeInsets.only(left: 10,right: 10),
                        child: SingleChildScrollView(
                          child: Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: productList.asMap().map((key, value) => MapEntry(key, GestureDetector(
                              child: Container(
                                height: 215,
                                ///  width: width*0.48,
                                //   margin: EdgeInsets.fromLTRB(width*0.01, 5, width*0.01, 5),
                                width: gridWidth*0.5,
                                //margin: EdgeInsets.fromLTRB(10, 5, width*0.01, 5),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: lightGrey
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(17),
                                        color: Colors.white,
                                      ),
                                      clipBehavior: Clip.antiAlias,
                                      margin: EdgeInsets.all(15.0),
                                      height: 155,
                                      width: gridWidth*0.50,
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(5),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewProductDetails()),);
                                                      },
                                                      child: Container(
                                                        width: 20,
                                                        height: 20,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
                                                          color: Colors.white,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:Color(0xFF000000).withOpacity(0.15),
                                                              blurRadius: 10.0, // soften the shadow
                                                              spreadRadius: 0.1, //extend the shadow
                                                              offset: Offset(
                                                                0.0, // Move to right 10  horizontally
                                                                0.0, // Move to bottom 10 Vertically
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        child: Icon(Icons.remove_red_eye,color: tn.primaryColor2,size: 18,),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(20),
                                                        color: Colors.white,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:Color(0xFF000000).withOpacity(0.15),
                                                            blurRadius: 10.0, // soften the shadow
                                                            spreadRadius: 0.1, //extend the shadow
                                                            offset: Offset(
                                                              4.0, // Move to right 10  horizontally
                                                              4.0, // Move to bottom 10 Vertically
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      child: Icon(Icons.favorite,color: tn.primaryColor2,size: 18,),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    selectAddRemove=key;
                                                  });
                                                },
                                                child: Container(
                                                  color: Colors.transparent,
                                                  width: gridWidth*0.50,
                                                  alignment: Alignment.center,
                                                  //child: Image.asset(value['FavImg'],width: 90,fit: BoxFit.cover,),
                                                  child: getImageByType(
                                                    imageType: value['ImageType'],
                                                    path: value['ImagePath'],
                                                    dataType: value['ImageDataType'],
                                                    width: 90
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 35,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                  children: [

                                                    Container(
                                                      width: 35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                          color: tn.primaryColor2,
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(17),
                                                          )
                                                      ),
                                                      child: Center(
                                                        child: Visibility(
                                                            visible: value['IsDiscount'],
                                                            child: Text('${value['DiscountValue']} ${value['IsPercentage']?"%":rupeesString}',style: TextStyle(color:tn.primaryColor,fontSize: 14,fontFamily: 'RB'),)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),

                                          IgnorePointer(
                                            ignoring:selectAddRemove==key? false:true ,
                                            child: GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  selectAddRemove=-1;
                                                });
                                              },
                                              child: AnimatedContainer(
                                                duration: Duration(milliseconds: 300),
                                                curve: Curves.easeIn,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(17),
                                                  color:tn.primaryColor2.withOpacity(selectAddRemove==key? 0.6:0),
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                height: 155,
                                                width: gridWidth*0.50,
                                              ),
                                            ),
                                          ),

                                          selectAddRemove==key?Align(
                                            alignment: Alignment.center,
                                            child:  Container(
                                              height: 40,
                                              width: gridWidth*0.31,
                                              decoration: BoxDecoration(
                                                  color:tn.primaryColor,
                                                  borderRadius:BorderRadius.circular(10)
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  addRemoveBtn(Icon(Icons.add,color: tn.primaryColor,size: 25,)),
                                                  Text("200",style: TSWhite166,),
                                                  addRemoveBtn(Icon(Icons.remove,color: tn.primaryColor,size: 25,)),
                                                ],
                                              ),
                                            ),
                                          ):Container(),

                                        ],
                                      ),
                                    ),
                                    Positioned(
                                      left: 5,
                                      bottom: 0,
                                      child: Container(
                                        height: 40,
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(left: 7),

                                              width: (gridWidth*0.5)-50,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text('${value['ProductName']}',style: TextStyle(fontFamily: 'RB',color: Colors.black,fontSize: 13),),
                                                  ),
                                                 FittedBox(
                                                   child: Row(
                                                     children: [
                                                       Text("${value['DisplayQuantity']??1} ${value['UnitName']}",style: ts18(ColorUtil.themeBlack,fontsize: 13),),
                                                       Visibility(
                                                         visible: value['IsStrike']??false,
                                                         child: Padding(
                                                           padding: const EdgeInsets.only(left: 5),
                                                           child: Text("$rupeesString ${value['StrikePrice']}",
                                                               style: TextStyle(fontSize: 13,fontFamily: 'RR',color: Color(0XFF919191),decoration: TextDecoration.lineThrough)
                                                           ),
                                                         ),
                                                       ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 5),
                                                          child: Text("$rupeesString ${value['DisplayPrice']}",
                                                              style: ts18(tn.primaryColor,fontsize: 13,fontfamily: 'RB')
                                                          ),
                                                        )
                                                     ],
                                                   ),
                                                 )
                                                 /* Container(
                                                    child: RichText(
                                                      text: TextSpan(
                                                        text: value['kg']+' ' ,
                                                        style: TextStyle(color: Color(0xff000000),fontSize: 13,fontFamily: 'RR'),
                                                        children: <TextSpan>[
                                                          TextSpan(text: value['Rate'], style: TextStyle(fontSize: 13,fontFamily: 'RR',color: Color(0XFF919191),decoration: TextDecoration.lineThrough)),
                                                          TextSpan(text: '  '+value['Rate1'], style: TextStyle(fontSize: 13,fontFamily: 'RB',color:tn.primaryColor,),),
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
                                    ),

                                    Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: tn.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                              )
                                          ),
                                          child: Center(
                                            child: Icon(Icons.add,color: Colors.white,size: 30,),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ))).values.toList(),
                          ),
                        ),
                      ):
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount:productList.length ,
                          itemBuilder: (ctx,i){
                            return Container(
                              height: 120,
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Color(0xffF7F7F7),
                              ),
                              clipBehavior: Clip.antiAlias,
                              margin: EdgeInsets.all(10),
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: width*0.24,
                                      height: 90,
                                      margin: EdgeInsets.only(left: 10,right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.center,
                                      child: Image.asset(FavItems[i]['FavImg'],
                                        width: 70,fit: BoxFit.cover,),
                                    ),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          child: Text(FavItems[i]['FavItemName'],style: TextStyle(fontFamily: 'RB',color: Colors.black,fontSize: 14),),
                                        ),
                                        Container(
                                          child: RichText(
                                            text: TextSpan(
                                              text: FavItems[i]['kg']+"  ",
                                              style: TextStyle(color: Color(0xff000000),fontSize: 14,fontFamily: 'RR'),
                                              children: <TextSpan>[
                                                TextSpan(text: FavItems[i]['Rate'], style: TextStyle(fontSize: 14,fontFamily: 'RR',color: Color(0XFF919191),decoration: TextDecoration.lineThrough)),
                                                TextSpan(text: '  '+FavItems[i]['Rate1'], style: TextStyle(fontSize: 14,fontFamily: 'RB',color:tn.primaryColor,),),
                                              ],
                                            ),

                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
                                      width: 63,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color:tn.primaryColor,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text('Add',style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'RR'),),
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        SizedBox(height: 15,),
                                        Container(
                                          width: 20,
                                          height: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color:Color(0xFF000000).withOpacity(0.15),
                                                blurRadius: 10.0, // soften the shadow
                                                spreadRadius: 0.1, //extend the shadow
                                                offset: Offset(
                                                  4.0, // Move to right 10  horizontally
                                                  4.0, // Move to bottom 10 Vertically
                                                ),
                                              )
                                            ],
                                          ),
                                          child: Icon(Icons.favorite,color: tn.primaryColor2,size: 18,),
                                        ),
                                        Spacer(),
                                        Container(
                                          width: 50,
                                          height: 30,
                                          decoration: BoxDecoration(
                                              color: tn.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(20),
                                              )
                                          ),
                                          child: Center(
                                            child: Text(FavItems[i]['discount'],style: TSWhite166,),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                      )
                  )),
                  Obx(() => Visibility(visible:productList.isEmpty,child: const NoData()))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void assignWidgets() async{
    productList.clear();
    await parseJson([],General.productListPage);
    try{
      productList.value=valueArray.where((element) => element['key']=="ProductList").toList()[0]['value'];
    }catch(e){}
  }
}
