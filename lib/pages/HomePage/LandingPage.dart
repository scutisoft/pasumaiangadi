import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../../HappyExtension/extensionHelper.dart';
import '../../utils/colorUtil.dart';
import '../../utils/utils.dart';
import '../../notifiers/themeNotifier.dart';
import '../../utils/constants.dart';
import '../../utils/general.dart';
import '../../utils/size.dart';
import '../../widgets/bottomPainter.dart';
import '../../widgets/companySettingsTextField.dart';
import '../../widgets/innerShadowTBContainer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Cartpage.dart';
import 'ViewProductList.dart';


class HomePage extends StatefulWidget {
  VoidCallback voidCallback;
  HomePage({required this.voidCallback});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HappyExtensionHelper implements HappyExtensionHelperCallback{

  late  double width,height,width2,height2,gridWidth;


  int selectTopSale=0;
  bool isGridView=true;
  int selectAddRemove=-1;
  List<dynamic> TrendingFood=[
    {"Img":"assets/slider/slider-03.jpg","ItemName":"Don\'t miss amazing grocery deals","Order":"Order Now1","Subtitle":"Save upto 50% off on your first order","Colorblack":0xff000000,"Colorlight":0xff7A7A7A,},
    {"Img":"assets/banner/coriander-seeds.webp","ItemName":"Don\'t miss amazing grocery deals","Order":"Order Now2","Subtitle":"Save upto 50% off on your first order","ColorCatg":0xffFF0022,"Colorblack":0xffffffff,"Colorlight":0xffF0F5F9,},
    {"Img":"assets/banner/Cumin-Seeds.jpg","ItemName":"Don\'t miss amazing grocery deals","Order":"Order Now3","Subtitle":"Save upto 50% off on your first order","ColorCatg":0xffFF0022,"Colorblack":0xffffffff,"Colorlight":0xffF0F5F9,},
  ];
  List<dynamic> Category=[
    {"CatgImg":"assets/theme/icons/category-1.svg","CatgName":"Areca Products",},
    {"CatgImg":"assets/theme/icons/category-2.svg","CatgName":"Farm Fresh",},
    {"CatgImg":"assets/theme/icons/category-10.svg","CatgName":"Organic Vegetables & Fruits",},
    {"CatgImg":"assets/theme/icons/category-3.svg","CatgName":"TinToys",},
  ];


  //DEV
  var offerSliders=[].obs;
  var categoryList=[].obs;
  var featureBrandsList=[].obs;
  var todaysDealList=[].obs;
  var topSaleList=[].obs;

  @override
  void initState(){
    assignWidgets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    gridWidth=width-30;
    width2=width-16;
    height2=height-16;
    SizeConfig().init(context);
    return SafeArea(
        child: Consumer<ThemeNotifier>(
          builder:(ctx,tn,child)=> Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                body: Container(
                  height: height,
                  width: width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Container(
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                        color: tn.primaryColor
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5,),
                          Container(
                           child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(onPressed: (){
                                  widget.voidCallback();
                                //  Navigator.push(context, MaterialPageRoute(builder: (ctx)=>AddressHomePage()));
                                },
                                icon: Image.asset('assets/menu.png',width:20,),
                               //   icon: Icon(Icons.menu,color: Colors.white,size: 30,),
                                ),
                                Container(
                                  padding: EdgeInsets.only(right: 15.0),
                                  child:   Row(
                                    children: [
                                      Image.asset('assets/logo.png',width:150,),
                                    ],
                                  )
                                ),

                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // method to show the search bar
                                    showSearch(
                                        context: context,
                                        // delegate to customize the search bar
                                        delegate: CustomSearchDelegate()
                                    );
                                  },
                                  child: Container(
                                    width:width*0.8,
                                      height: 45,
                                      child: CompanySettingsTextField(
                                        enable: false,
                                          hintText: "Search Product", img: "assets/search.png")
                                  ),
                                ),
                                Container(
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
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                      InnerShadowTBContainer(
                        height: height-200,
                        width: width,
                        child: ListView(

                          children: [
                            SizedBox(height: 10,),
                            Container(
                              color: Color(0XFFF5F5F5),
                                child:  Obx(() => CarouselSlider(
                                  options: CarouselOptions(
                                    // aspectRatio: 16/9,
                                    height: 200,
                                    viewportFraction: 1,
                                    // initialPage: 0,
                                    enableInfiniteScroll: true,
                                    reverse: false,
                                    autoPlay: true,
                                    autoPlayInterval: Duration(seconds: 3),
                                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enlargeCenterPage: false,
                                    scrollDirection: Axis.horizontal,
                                    // enlargeCenterPage: false,
                                  ),
                                  items: offerSliders
                                      .map((item) => Container(
                                    child: Stack(
                                      children: [
                                        getImageByType(imageType:item["ImageType"],path: item["ImagePath"]),
                                        Container(
                                          margin: EdgeInsets.only(left: 20,top: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  width:SizeConfig.screenWidth!*0.4,
                                                  child: Text(item['Title'],style: TextStyle(fontFamily: 'RB',fontSize: 24,color:ColorUtil.parseColor(item["TitleColor"]),fontWeight: FontWeight.bold),)
                                              ),
                                              SizedBox(height: 10,),
                                              Container(
                                                  width:SizeConfig.screenWidth!*0.4,
                                                  child: Text(item['Description'],style: TextStyle(fontFamily: 'RR',fontSize: 12,color: ColorUtil.parseColor(item["DescColor"])),)
                                              ),
                                              SizedBox(height: 20,),
                                              Container(
                                                padding: EdgeInsets.fromLTRB(8,1,8,1),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(5.0),
                                                  color:Color(0xff6A8528),
                                                ) ,
                                                child: Text(item['ButtonText'],style: TextStyle(fontFamily: 'RR',fontSize: 14,color: Color(0xffffffff)),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                                      .toList(),
                                ))
                            ),
                            SizedBox(height: 10,),
                            Container(
                              width: SizeConfig.screenWidth,
                              margin: EdgeInsets.only(left: 10,right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Categories',style: TextStyle(fontFamily: 'RB',fontSize: 18,color: Color(0xff000000),fontWeight: FontWeight.bold),),
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
                                            border: Border.all(color: Color(0xff5D5C51),style:BorderStyle.solid )

                                        ) ,
                                        child:   Icon(isGridView?Icons.dashboard_outlined:Icons.list,
                                          color: Color(0xff5D5C51),)
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 5,),
                            Container(
                                width: SizeConfig.screenWidth,
                                height: 70,
                                //  padding: EdgeInsets.only(bottom: 10),
                                alignment: Alignment.centerLeft,
                                child: Obx(() => ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoryList.length,
                                  shrinkWrap: true,
                                  itemBuilder: (ctx,i){
                                    return  GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          selectTopSale=i;
                                        });
                                        fadeRoute(ViewAllItems());
                                      },
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 400),
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
                                            getImageByType(
                                              imageType: categoryList[i]['ImageType'],
                                              dataType: categoryList[i]['ImageDataType'],
                                              path: categoryList[i]['ImagePath'],
                                              height: 20
                                            ),
                                            //SvgPicture.asset(categoryList[i]['CatgImg'],fit: BoxFit.cover,width: SizeConfig.screenWidth,height:20 ,),
                                            const SizedBox(width: 5,),
                                            Text(categoryList[i]['CategoryName'],style: TextStyle(fontFamily: 'RR',fontSize: 14,color: i==selectTopSale? Colors.white:Color(0xff959595))),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ))
                            ),
                            const SizedBox(height: 10,),

                            //Feature Brands
                            Obx(() =>
                              Visibility(
                                visible: featureBrandsList.isNotEmpty,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: SizeConfig.screenWidth,
                                      margin: EdgeInsets.only(left: 10,right: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Text('Featured Brands',style: TextStyle(fontFamily:'RB',fontSize: 18,color: Color(0xff000000),fontWeight: FontWeight.bold),),
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right: 8.0),
                                                child: GestureDetector(
                                                    onTap: (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ViewAllItems()));
                                                    },
                                                    child: Text('View All',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:tn.primaryColor),)),
                                              ),
                                              Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.
                                                      circular(5.0),
                                                      //border: Border.all(color: Color(0xff5D5C51),style:BorderStyle.solid )
                                                      color:tn.primaryColor
                                                  ) ,
                                                  child:   Icon(Icons.chevron_right,color: Color(0xffffffff),size: 15,)
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                        width: SizeConfig.screenWidth,
                                        height: 140,
                                        padding: const EdgeInsets.only(left: 10,top: 10),
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: featureBrandsList.length,
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (ctx,i){
                                            return   GestureDetector(
                                              onTap: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ViewAllItems()));
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(right: 10.0),
                                                width:SizeConfig.screenWidth!*0.6,
                                                height: 140,
                                                child: Stack(
                                                  children: [
                                                    getImageByType(
                                                      imageType: featureBrandsList[i]['ImageType'],
                                                      dataType: featureBrandsList[i]['ImageDataType'],
                                                      path: featureBrandsList[i]['ImagePath'],
                                                    ),
                                                    Container(
                                                      margin: const EdgeInsets.only(left: 20,top: 10),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(featureBrandsList[i]['Title'],style: TextStyle(fontFamily: 'RI',fontSize: 18,color: ColorUtil.parseColor(featureBrandsList[i]["TitleColor"]),fontWeight: FontWeight.bold),),
                                                          Text(featureBrandsList[i]['Description'],style: TextStyle(fontFamily: 'RI',fontSize: 12,color: ColorUtil.parseColor(featureBrandsList[i]["DescColor"])),),
                                                          const SizedBox(height: 2,),
                                                          Container(
                                                            padding: EdgeInsets.fromLTRB(8,3,8,3),
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(5.0),
                                                              color:Color(0xff6A8528),
                                                            ) ,
                                                            child: Text(featureBrandsList[i]['ButtonText'],style: TextStyle(fontFamily: 'RR',fontSize: 12,color: Color(0xffffffff)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                    ),
                                  ],
                                ),
                              )
                            ),
                            const SizedBox(height: 10,),

                            //Today Deal
                            Obx(() => Visibility(
                              visible: todaysDealList.isNotEmpty,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth,
                                    margin: EdgeInsets.only(left: 10,right: 10),
                                    child: Row(
                                      //    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('Today\'s Deal   ',style: TextStyle(fontFamily:'RB',fontSize: 18,color: Color(0xff000000),fontWeight: FontWeight.bold),),
                                        Container(
                                          color: tn.primaryColor1,
                                          padding: const EdgeInsets.fromLTRB(3, 1, 3, 1),
                                          child: Text("2:2:01",style: ts14(Colors.white),),
                                        ),
                                        Spacer(),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ViewAllItems()));
                                                  },
                                                  child: Text('View All',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:tn.primaryColor),)),
                                            ),
                                            Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.
                                                    circular(5.0),
                                                    //border: Border.all(color: Color(0xff5D5C51),style:BorderStyle.solid )
                                                    color:tn.primaryColor
                                                ) ,
                                                child:   const Icon(Icons.chevron_right,color: Color(0xffffffff),size: 15,)
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Container(
                                      width: SizeConfig.screenWidth,
                                      height: 140,
                                      padding: const EdgeInsets.only(left: 10,top: 10),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: todaysDealList.length,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (ctx,i){
                                          return Container(
                                            margin: const EdgeInsets.only(right: 10.0),
                                            width:SizeConfig.screenWidth!*0.6,
                                            height: 140,
                                            child: Stack(
                                              children: [
                                                getImageByType(
                                                  imageType: todaysDealList[i]['ImageType'],
                                                  dataType: todaysDealList[i]['ImageDataType'],
                                                  path: todaysDealList[i]['ImagePath'],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(left: 20,top: 10),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(todaysDealList[i]['Title'],style: TextStyle(fontFamily: 'RI',fontSize: 18,color: ColorUtil.parseColor(todaysDealList[i]["TitleColor"]),fontWeight: FontWeight.bold),),
                                                      Text(todaysDealList[i]['Description'],style: TextStyle(fontFamily: 'RI',fontSize: 12,color: ColorUtil.parseColor(todaysDealList[i]["DescColor"])),),
                                                      const SizedBox(height: 2,),
                                                      Container(
                                                        padding: EdgeInsets.fromLTRB(8,3,8,3),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          color:Color(0xff6A8528),
                                                        ) ,
                                                        child: Text(todaysDealList[i]['ButtonText'],style: TextStyle(fontFamily: 'RR',fontSize: 12,color: Color(0xffffffff)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                  ),
                                ],
                              ),
                            )),
                            const SizedBox(height: 10,),


                            //Top Sale
                            Obx(() => Visibility(
                              visible: topSaleList.isNotEmpty,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: SizeConfig.screenWidth,
                                    margin: EdgeInsets.only(left: 10,right: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text('Top Sale',style: TextStyle(fontFamily:'RB',fontSize: 18,color: Color(0xff000000),fontWeight: FontWeight.bold),),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 8.0),
                                              child: GestureDetector(
                                                  onTap: (){
                                                    Navigator.push(context, MaterialPageRoute(builder: (ctx)=>ViewAllItems()));
                                                  },
                                                  child: Text('View All',style: TextStyle(fontFamily: 'RR',fontSize: 14,color:tn.primaryColor),)),
                                            ),
                                            Container(
                                                width: 20,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.
                                                    circular(5.0),
                                                    //border: Border.all(color: Color(0xff5D5C51),style:BorderStyle.solid )
                                                    color:tn.primaryColor
                                                ) ,
                                                child:   Icon(Icons.chevron_right,color: Color(0xffffffff),size: 15,)
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      width: SizeConfig.screenWidth,
                                      height: 140,
                                      padding: const EdgeInsets.only(left: 10,top: 10),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: topSaleList.length,
                                        physics: const BouncingScrollPhysics(),
                                        itemBuilder: (ctx,i){
                                          return Container(
                                            margin: const EdgeInsets.only(right: 10.0),
                                            width:SizeConfig.screenWidth!*0.6,
                                            height: 140,
                                            child: Stack(
                                              children: [
                                                getImageByType(
                                                  imageType: topSaleList[i]['ImageType'],
                                                  dataType: topSaleList[i]['ImageDataType'],
                                                  path: topSaleList[i]['ImagePath'],
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(left: 20,top: 10),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(topSaleList[i]['Title'],style: TextStyle(fontFamily: 'RI',fontSize: 18,color: ColorUtil.parseColor(topSaleList[i]["TitleColor"]),fontWeight: FontWeight.bold),),
                                                      Text(topSaleList[i]['Description'],style: TextStyle(fontFamily: 'RI',fontSize: 12,color: ColorUtil.parseColor(topSaleList[i]["DescColor"])),),
                                                      const SizedBox(height: 2,),
                                                      Container(
                                                        padding: EdgeInsets.fromLTRB(8,3,8,3),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(5.0),
                                                          color:Color(0xff6A8528),
                                                        ) ,
                                                        child: Text(topSaleList[i]['ButtonText'],style: TextStyle(fontFamily: 'RR',fontSize: 12,color: Color(0xffffffff)),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      )
                                  ),
                                ],
                              ),
                            )),
                            const SizedBox(height: 20,),
                          ],
                        ),
                      ),

                    ],
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

  addRemoveBtn(Widget icon){
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
          color:Colors.white,
          borderRadius:BorderRadius.circular(5)
      ),
      child: Center(
        child: icon,
      ),
    );
  }

  @override
  void assignWidgets() async{
    offerSliders.value=[];
    categoryList.value=[];
    featureBrandsList.value=[];
    todaysDealList.value=[];
    topSaleList.value=[];
    await parseJson([],General.userLandingPage);
    try{
      offerSliders.value=valueArray.where((element) => element['key']=="OfferSlider").toList()[0]['value'];
      categoryList.value=valueArray.where((element) => element['key']=="CategoryList").toList()[0]['value'];
      featureBrandsList.value=valueArray.where((element) => element['key']=="FeatureBrandsList").toList()[0]['value'];
      todaysDealList.value=valueArray.where((element) => element['key']=="TodaysDeal").toList()[0]['value'];
      topSaleList.value=valueArray.where((element) => element['key']=="TopSaleList").toList()[0]['value'];
    }catch(e){}
  }

}
class CustomSearchDelegate extends SearchDelegate {
  // Demo list to show querying
  List<String> searchTerms = [
    "Men",
    "Women",
    "Kids",
    "Sarees",
    "Tops",
  ];

  // first overwrite to
  // clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  // second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  // third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

  // last overwrite to show the
  // querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}