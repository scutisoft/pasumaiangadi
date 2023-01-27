import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:scutiwidgets/animeDialog.dart';


import '../notifiers/themeNotifier.dart';
import '../utils/constants.dart';

void reviewPopUp(height,width){


  bool openText=false;
  close(){
    Timer(animeDuration, (){
      openText=false;
    });
  }
  AnimeDialog().slideFromBottomToTop(
      Get.context!,
      Scaffold(
        backgroundColor: Colors.transparent,
        body: GestureDetector(
          onTap: (){

          },
          child: StatefulBuilder(
            builder:(context,setState)=> Container(
              height: height,
              width: width,
              color: Colors.black54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // height: 600,
                    width: width*0.80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.only(top: 10,bottom: 10),
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Image.asset('assets/alert/alert-img.JPG',width: 200,fit: BoxFit.cover,),
                        SizedBox(height: 10,),

                        openText?Container(
                          height: 200,
                          margin: EdgeInsets.only(left: 20,right: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: addNewTextFieldBorder)
                          ),
                          alignment: Alignment.centerLeft,
                          child: TextField(
                            style: ts14(text1),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: "Type your feedback..",
                                hintStyle: ts14(grey),
                                //  prefixIcon: Container(width: 20,height: 20,),

                                contentPadding: EdgeInsets.symmetric(horizontal: 20)
                            ),
                            textAlignVertical: TextAlignVertical.top,
                            //  textAlign: TextAlign.start,
                          ),
                        ):Column(
                          children: [
                            Text('Order id #1234567$openText',style: ts16(text1),),
                            SizedBox(height: 10,),
                            Text('₹ 2,500.00',style: ts18(text1,fontsize: 28,fontfamily: 'RB'),),
                            SizedBox(height: 10,),
                            Text('(28 Items)',style: ts16(text1.withOpacity(0.7)),),
                            SizedBox(height: 10,),
                            Text('Delivery Successful',style: ts16(Color(0XFF40CA50)),),
                            SizedBox(height: 10,),
                            RatingBar.builder(
                              initialRating: 2.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                              unratedColor: text1.withOpacity(0.3),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Provider.of<ThemeNotifier>(context,listen: false).primaryColor,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                            SizedBox(height: 10,),
                            Text('Please give your feedback',style: ts16(text1.withOpacity(0.7)),),
                          ],
                        ),


                        SizedBox(height: 20,),
                        GestureDetector(
                          onTap: (){
                            if(openText){
                              Navigator.pop(context);
                              close();

                            }
                            else{
                              setState(() {
                                openText=true;
                              });
                            }

                          },
                          child: Container(
                            height: 45,
                            width: 100,
                            margin: EdgeInsets.only(bottom: 25),
                            decoration: BoxDecoration(
                                color: Provider.of<ThemeNotifier>(context,listen: false).primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color:Provider.of<ThemeNotifier>(context,listen: false).primaryColor.withOpacity(0.5),
                                    blurRadius: 10.0, // soften the shadow
                                    spreadRadius: 3, //extend the shadow
                                    offset: Offset(
                                      2.0, // Move to right 10  horizontally
                                      4.0, // Move to bottom 10 Vertically
                                    ),
                                  )
                                ]
                            ),
                            child: Center(
                              //  child: Image.asset("assets/items-list/cart.png",width: 30,),
                                child: Text('Submit',style: ts16(text2),)
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
        ),
      )
  );




}