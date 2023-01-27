
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
import 'package:provider/provider.dart';

class PanCardDetails extends StatefulWidget {

  @override
  _PanCardDetailsState createState() => _PanCardDetailsState();
}

class _PanCardDetailsState extends State<PanCardDetails> {
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
        builder:(ctx,tn,child)=> Stack(
          children: [
           Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              width: width,
              height: height,
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomAppBar(title: "Pan Card Details"),

                  CompanySettingsTextField(
                    hintText: "Enter Pan Card Name",
                    img: "",
                    borderRadius: textFieldBR,
                  ),
                  SizedBox(height: 15,),
                  CompanySettingsTextField(
                    hintText: "Enter Pan Card Number",
                    img: "",
                    borderRadius: textFieldBR,
                  ),
                  SizedBox(height: 15,),
                ],
              ),

            ),
             bottomNavigationBar: BottomNavi(),
          ),
            BottomCenterIcon(
                ontap: (){
                  Navigator.pop(context);
                },
                widget: Icon(Icons.done,color: Colors.white,size: 30,)
            )
          ],

        ),
      ),
    );
  }
}
