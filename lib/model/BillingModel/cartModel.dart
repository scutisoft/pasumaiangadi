import 'dart:async';

import 'package:math_expressions/math_expressions.dart';
import 'package:rational/rational.dart';

import '../../utils/utils.dart';
import '../../widgets/calculation.dart';
import '../parameterMode.dart';
import 'addonsModel.dart';
import 'paymentTypeModel.dart';
import 'productModel.dart';
import 'totalOrderModel.dart';

class OrderModel {
  String? tableNumber;
  bool? isDynamicTable;
  int? totalSeats;
  int? covers;
  int? waiterId;
  int? captainId;
  int? customerId;
  int? billId;
  double? tips;
  bool? isBillCredit;
  bool? isMergeTable;
  bool? isHold;
  bool? isTax;
  bool? isOverAllDiscount;
  bool? isOverAllTax;
  bool? isDiscount;
  bool? isPercentage;
  bool? isTaxExemption;
  bool? isRoundOffExemption;
  double? subTotal;
  double? taxAmount;
  double? taxValue;
  double? discountAmount;
  double? discountedSubTotal;
  double? discountValue;
  double? additionalDiscount;
  double? grandTotalAmount;
  double? roundOffAmount;
  List<ProductModel>? productList;
  List<OtherChargesMapping>? taxList;
  List<OtherChargesMapping>? otherChargesList;
  List<OtherChargesMapping>? productTaxMappingList ;
  List<ConsolidateOtherChargess>? consolidateOtherCharges;
  double? addonAmount=0.0;
  List<KOTCommentandAddOnMapping>? addOnCommentsList;
  List<dynamic>? seatMappingList;
  List<OrderWithKoT>? totalOrderKotWiseList;
  List<ProductModel>? consolidateProducts;
  List<ProductModel>? totalProductList;
  List<dynamic>? shiftItems;
  bool? isBillSplit;
  bool? isCoversSplit;
  List<dynamic>? billSplitDetailArr;
  int? orderId;
  int? orderNumber;
  int? tableId;
  int? floorId;
  String? floorName;
  int? orderTypeId;
  String? orderTypeName;

  bool? isBillCompliment;

  OrderModel(
      {this.tableNumber="",
        this.isDynamicTable=false,
        this.totalSeats=0,
        this.covers,
        this.waiterId,
        this.captainId,
        this.customerId,
        this.billId,
        this.tips=0.0,
        this.isBillCredit=false,
        this.isMergeTable=false,
        this.isHold=false,
        this.isTax=true,
        this.isOverAllDiscount=false,
        this.isOverAllTax=false,
        this.isDiscount=false,
        this.isPercentage=true,
        this.isTaxExemption=false,
        this.isRoundOffExemption=false,
        this.subTotal=0.0,
        this.taxAmount=0.0,
        this.taxValue=0.0,
        this.discountAmount=0.0,
        this.discountedSubTotal=0.0,
        this.discountValue=0.0,
        this.additionalDiscount=0.0,
        this.grandTotalAmount=0.0,
        this.roundOffAmount=0.0,
        this.productList,
        this.taxList,
        this.otherChargesList,
        this.consolidateOtherCharges,
        this.addonAmount=0.0,
        this.addOnCommentsList,
        this.seatMappingList,
        this.totalOrderKotWiseList,
        this.consolidateProducts,
        this.totalProductList,
        this.shiftItems,
        this.isBillSplit=false,
        this.isCoversSplit=false,
        this.billSplitDetailArr,
        this.orderId,
        this.orderNumber,
        this.tableId,
        this.floorId,
        this.floorName,
        this.orderTypeId,
        this.orderTypeName,
        this.isBillCompliment=false
      }
      );



  addProduct(productDetail, qty){
    ProductModel product = new ProductModel();
    product.productId = productDetail['ProductId'];
    product.productName = productDetail['ProductName'];
    product.productPrice = productDetail['Price']??0;
    product.productCategoryId = productDetail['ProductCategoryId'];
    product.isProductWeightEnable = productDetail['IsProductWeightEnable']??false;

    product.taxValue = 0.0;

   /* if(this.productList==null){
      this.productList!.add(product);
    }*/
      int index = this.productList!.indexWhere((element) => element.productId==product.productId);
      if (index != -1) {
        ProductModel existingProduct = this.productList![index];
        product.quantity = (existingProduct.quantity! + qty);
      }
      else {
        product.quantity = parseDouble(qty.toString());
      }
      product.subTotal = Calculation().mul(product.quantity, product.productPrice);
      if (this.isOverAllTax??false) {

      }
      else {
        var taxValue = Calculation().div(product.taxValue, 100);
        product.taxAmount = Calculation().mul(product.subTotal, taxValue);
      }
    var t1=[],t2=[];
      if(productDetail['ProductOtherChargesList']!=null){
        t1=productDetail['ProductOtherChargesList'] as List;
      }
      if(productDetail['ProductTaxList']!=null){
        t2=productDetail['ProductTaxList'] as List;
      }
      product.otherChargesList=t1.map((e)=>OtherChargesMapping.FromJsonGetBillingOutlet(e)).toList();
      product.taxList=t2.map((e)=>OtherChargesMapping.FromJsonGetBillingOutlet(e)).toList();
      /*product.otherChargesList = json.decode(json.encode(productDetail['ProductOtherChargesList']));
      product.taxList = json.decode(json.encode(productDetail['ProductTaxList']));*/
      if (index != -1) {
        this.productList![index] = product;

      }
      else{
        this.productList!.insert(0,product);

      }
    this.orderCalculation();
  }

  deleteProduct(int productId){
    this.productList!.removeWhere((element) => element.productId==productId);
    this.manipulateAddOnCommentsList(productId, 1, null, 0, 3);
    this.manipulateAddOnCommentsList(productId, 2, null, 0, 3);
    this.manipulateAddOnCommentsList(productId, 3, null, 0, 3);
    this.orderCalculation();
  }

  updateProductQty(productId, qty){
    int index = this.productList!.indexWhere((e) => e.productId == productId);
    if (index != -1) {
      this.productList![index].quantity = qty;
      this.orderCalculation();
    }
  }

  manipulateAddOnCommentsList(productId,type,id,price,action){
    if (type == 1) {
      //Kitchen Comments
      int index = this.addOnCommentsList!.indexWhere((e) => e.orderProductId == productId && e.commentId == id && e.kOTId==null);
      if (action == 1) {
        //Add
        if (index == -1) {
          var tempModel = new KOTCommentandAddOnMapping();
          tempModel.orderProductId = productId;
          tempModel.commentId = id;
          tempModel.kOTCommentandAddOnTypeId = type;
          this.addOnCommentsList!.add(tempModel);
        }
      }
      else if (action == 2) {
        //Delete By Id
        this.addOnCommentsList!.removeAt(index);
      }
      else {
        //Delete By ProductId
        this.addOnCommentsList!.removeWhere((e) => e.orderProductId ==productId && e.kOTId==null && e.commentId!=null);
        //this.addOnCommentsList = this.addOnCommentsList!.where((e) => e.orderProductId != productId && e.kOTId==null && e.commentId!=null).toList();
      }
    }
    else if (type == 2) {
      //Addons
      int index = this.addOnCommentsList!.indexWhere((e) => e.orderProductId == productId && e.addonId == id && e.kOTId==null);
      if (action == 1) {
        //Add
        if (index == -1) {
          var tempModel = new KOTCommentandAddOnMapping();
          tempModel.orderProductId = productId;
          tempModel.addonId = id;
          tempModel.price = price;
          tempModel.kOTCommentandAddOnTypeId = type;
          this.addOnCommentsList!.add(tempModel);
        }
      }
      else if (action == 2) {
        //Delete By Id
        this.addOnCommentsList!.removeAt(index);
        //this.addOnCommentsList.splice(index, 1);
      }
      else {
        //Delete By ProductId
        this.addOnCommentsList!.removeWhere((e) => e.orderProductId ==productId && e.kOTId==null && e.addonId!=null);
        //this.addOnCommentsList = this.addOnCommentsList!.where((e) => e.orderProductId != productId && e.kOTId==null && e.addonId!=null).toList();
      }
    }
    else if(type==3){
      //Notes
      if(action==1){
        int index = this.addOnCommentsList!.indexWhere((e) => e.orderProductId == productId && e.addonId == null && e.kOTId==null && e.commentId==null);
        if (index != -1) {
          if (id!="") {
            this.addOnCommentsList![index].comments = id;
          }
          else {
            this.addOnCommentsList!.removeAt(index);
          }
        }
        else if (id!="") {
          var tempModel = new KOTCommentandAddOnMapping();
          tempModel.orderProductId = productId;
          tempModel.addonId = null;
          tempModel.commentId = null;
          tempModel.price = 0;
          tempModel.kOTCommentandAddOnTypeId = type;
          tempModel.comments = id;
          this.addOnCommentsList!.add(tempModel);
        }
      }
      else if(action==2){
        this.addOnCommentsList!.removeWhere((e) => e.orderProductId==productId && e.addonId == null && e.kOTId==null && e.commentId==null);
      }
      else if(action==3){
        this.addOnCommentsList!.removeWhere((e) => e.orderProductId==productId && e.addonId == null && e.kOTId==null && e.commentId==null);
      }
    }
    this.orderCalculation();
  }

  orderCalculation(){
   // print("this.totalProductList! ${this.totalProductList!.length} ${Calculation().add("0.7758620689655171", "1.4741379310344824")} ${Calculation().add("0.7758620689655172", "1.4741379310344827")}");
    //print("this.totalProductList! ${this.totalProductList!.length} ${Calculation().sub("50", "34.48275862068966")} ${Calculation().sub("95", "65.51724137931035")}");
    this.discountAmount=0.0;
    double subTotal = 0.0;
    double taxAmount = 0.0;
    double discountedSubTotal = 0.0;
    double discountAmount = 0.0;
    double grandTotalAmount = 0.0;
    double roundOffAmount = 0.0;

    var tempTaxList = this.taxList;
    var tempOCList = this.otherChargesList;
    var tempTaxProductMapping  = this.productTaxMappingList;

    var orderId = this.orderId;
    this.consolidateOtherCharges!.forEach((v){ v.OtherChargesAmount = 0.0; v.isExemption = false; });
    tempTaxList!.forEach((v){ v.OtherChargesAmount = 0.0; });
    tempOCList!.forEach((v){ v.OtherChargesAmount = 0.0; });
    tempTaxProductMapping!.forEach((v){ v.OtherChargesAmount = 0.0; });

    this.productList!.forEach((e) {
      double tempST = Calculation().mul(e.quantity, e.productPrice);
      subTotal = Calculation().add(subTotal, tempST);
    });
    this.totalProductList!.forEach((e) {
      double tempST = Calculation().mul(e.quantity, e.productPrice);
      subTotal = Calculation().add(subTotal, tempST);
    });
    var orderUtils = {
      "orderId": this.orderId,
      "isDiscount": this.isDiscount,
      "isPercentage": this.isPercentage,
      "discountValue": this.discountValue,
      "isOverAllDiscount": this.isOverAllDiscount,
      "isOverAllTax": this.isOverAllTax,
      "subTotal": subTotal,
      "taxAmount": 0.0,
      "discountAmount": this.discountAmount,
      "discountedSubTotal": 0.0,
      "grandTotalAmount": 0.0,
      "roundOffAmount": 0.0,
      "tempTaxList": tempTaxList,
      "tempOCList": tempOCList,
      "tempTaxProductMapping": tempTaxProductMapping,
      "consolidateOtherChargesList": this.consolidateOtherCharges,
      "consolidateProducts": this.consolidateProducts
    };

    this.isOverAllDiscount=this.isOverAllDiscount??false;

    this.totalProductList!.forEach((e) {
      double c_product_subtotal = 0.0;
      if (this.productList!=null && this.productList!.isNotEmpty && (!this.isOverAllDiscount!)) {
        int index = this.productList!.indexWhere((f) => f.productId == e.productId);
        if (index != -1) {
          c_product_subtotal = this.productList![index].subTotal??0.0;
        }
      }
      productCalculation(e, orderUtils,c_product_subtotal_iwd: c_product_subtotal);
      taxAmount = Calculation().add(taxAmount, e.taxAmount);
      discountedSubTotal = Calculation().add(discountedSubTotal, e.discountedSubTotal);
      grandTotalAmount = Calculation().add(grandTotalAmount, e.grandTotal);
    });
    this.productList!.forEach((e) {
      double c_product_subtotal = 0.0;
      if (!this.isOverAllDiscount!) {
        c_product_subtotal = e.subTotal??0.0;
      }
      productCalculation(e, orderUtils,c_product_subtotal_iwd: c_product_subtotal);
      taxAmount = Calculation().add(taxAmount, e.taxAmount);
      discountedSubTotal = Calculation().add(discountedSubTotal, e.discountedSubTotal);
      grandTotalAmount = Calculation().add(grandTotalAmount, e.grandTotal);
    });

    this.addonAmount = 0.0;
    this.addOnCommentsList!.where((e) => parseDouble(e.price) > 0).forEach((e) => { this.addonAmount = Calculation().add( this.addonAmount, e.price) });

    this.subTotal = subTotal;
    this.taxAmount =  parseDouble(taxAmount.toStringAsFixed(maxPrecision));
    //this.discountAmount = orderUtils['discountAmount'];
    double z=parseDouble(orderUtils['discountAmount'])??0.0;
    this.discountAmount = parseDouble(z.toStringAsFixed(maxPrecision));
    this.discountedSubTotal = discountedSubTotal;
    grandTotalAmount=parseDouble(grandTotalAmount.toStringAsFixed(maxPrecision));
    this.grandTotalAmount = Calculation().add( this.addonAmount, grandTotalAmount);
    this.grandTotalAmount = parseDouble(this.grandTotalAmount!.toStringAsFixed(maxPrecision));
    //print("grandTotalAmount.round() ${grandTotalAmount} ${grandTotalAmount.round()} ${Calculation().roundOff(this.grandTotalAmount!.round(), this.grandTotalAmount)}");
    this.roundOffAmount = Calculation().roundOff(grandTotalAmount.round(), grandTotalAmount);
    this.roundOffAmount = parseDouble(this.roundOffAmount!.toStringAsFixed(maxPrecision));
    this.taxList = tempTaxList;
    this.otherChargesList = tempOCList;
    this.productTaxMappingList = tempTaxProductMapping;

    this.taxList!.forEach((element) {
      element.OtherChargesAmount=parseDouble(element.OtherChargesAmount!.toStringAsFixed(maxPrecision));
    });
    this.otherChargesList!.forEach((element) {
      element.OtherChargesAmount=parseDouble(element.OtherChargesAmount!.toStringAsFixed(maxPrecision));
    });

    /*this.otherChargesList!.forEach((element) {
      print("${element.OtherChargesName} ${element.OtherChargesAmount}");
    });
    this.consolidateOtherCharges!.forEach((element) {
      print("consolidateOtherCharges ${element.OtherChargesCategoryName} ${element.OtherChargesAmount}");
    });*/
    //$(".total-amount").text(Math.round(getParsedNumber(this.grandTotalAmount)));\
  }

  productCalculation(ProductModel productDetail, orderUtils,{c_product_subtotal_iwd=0.0}){

    var tempTaxList = orderUtils['tempTaxList'];
    var tempOCList = orderUtils['tempOCList'];
    var tempTaxProductMapping = orderUtils['tempTaxProductMapping'];
    var consolidateOtherChargesList = orderUtils['consolidateOtherChargesList'];

    var tempConsolidateProducts = [];
    if (orderUtils['consolidateProducts']!=null) {
      tempConsolidateProducts = orderUtils['consolidateProducts'];
    }


    productDetail.subTotal = Calculation().mul(productDetail.quantity, productDetail.productPrice);
    productDetail.taxAmount = 0;
    productDetail.discountAmount = 0;
    productDetail.discountedSubTotal = 0;

    if (orderUtils['isDiscount'] == true) {

      if (orderUtils['isOverAllDiscount'] == true) {
        productDetail.isDiscount = true;
        productDetail.isPercentage = orderUtils['isPercentage'];
        productDetail.discountValue = 0.0;
        productDetail.discountAmount = GetDiscountAmount( productDetail.subTotal, orderUtils['discountValue'],isPercentage: orderUtils['isPercentage'], orderSubTotal: orderUtils['subTotal'] );
        productDetail.discountedSubTotal = Calculation().sub(productDetail.subTotal, productDetail.discountAmount);
        //orderUtils['discountAmount'] = Calculation().add(orderUtils['discountAmount'], productDetail.discountAmount);
        var a=Rational.parse('${orderUtils['discountAmount']}') + Rational.parse('${productDetail.discountAmount}');
        orderUtils['discountAmount'] = Calculation().div6(a);
      }
      else {

        if (productDetail.isDiscount == true) {
          double consolidateSubTotal = productDetail.subTotal??0.0;

          int consolidateIndex = tempConsolidateProducts.indexWhere((e) => e.productId == productDetail.productId);
          if (consolidateIndex != -1) {
            consolidateSubTotal = tempConsolidateProducts[consolidateIndex].subTotal;
          }
          else{
            c_product_subtotal_iwd = 0.0;
          }
          consolidateSubTotal=Calculation().add(consolidateSubTotal, c_product_subtotal_iwd);
          productDetail.discountAmount = GetDiscountAmount( productDetail.subTotal, productDetail.discountValue,isPercentage: productDetail.isPercentage, orderSubTotal: consolidateSubTotal );
        }
        else {
          productDetail.discountAmount = 0;
        }
        productDetail.discountedSubTotal = Calculation().sub(productDetail.subTotal, productDetail.discountAmount);
        orderUtils['discountAmount'] = Calculation().add(orderUtils['discountAmount'], productDetail.discountAmount);
      }
    }
    else {
      productDetail.isDiscount = false;
      productDetail.isPercentage = false;
      productDetail.discountValue = 0.0;
      productDetail.discountedSubTotal = Calculation().sub(productDetail.subTotal, productDetail.discountAmount);
    }



    if (orderUtils['isOverAllTax'] == true) {

    }
    else {
      productDetail.taxList!.forEach((taxDetail) {

        taxDetail.OtherChargesAmount = 0.0;
        taxDetail.OtherChargesAmount = GetTaxAmount(productDetail.discountedSubTotal, taxDetail.OtherChargesValue);
        productDetail.taxAmount = Calculation().add(taxDetail.OtherChargesAmount, productDetail.taxAmount);

        int index = tempTaxList.indexWhere((e) => e.OtherChargesId== taxDetail.OtherChargesId);
        if (index == -1) {
          tempTaxList.add(OtherChargesMapping().CreateTaxMapping(orderUtils['orderId'], taxDetail,null));
        }
        else {
          tempTaxList[index].OtherChargesAmount = Calculation().add(tempTaxList[index].OtherChargesAmount, taxDetail.OtherChargesAmount);
        }

        int z = tempTaxProductMapping.indexWhere((y) => y.OrderProductId == productDetail.productId);
        if (z == -1) {
          tempTaxProductMapping.add(OtherChargesMapping().CreateTaxMapping( orderUtils['orderId'], taxDetail, productDetail.productId));
        }
        else {
          tempTaxProductMapping[z].OtherChargesAmount = Calculation().add(tempTaxProductMapping[z].OtherChargesAmount, taxDetail.OtherChargesAmount);
        }
      });
    }
    //productDetail.otherChargesList = JSON.parse(productDetail.find("#productOCList").val())



    productDetail.totalOtherChargesAmount = 0;
    consolidateOtherChargesList.forEach((COC) {
        if (COC.IsOverAllEnable) {
            var filterOtherChargesByCategory=productDetail.otherChargesList!.where((element) => element.OtherChargesCategoryId==COC.OtherChargesCategoryId).toList();
            if(filterOtherChargesByCategory.length>0){
                print("filterOtherChargesByCategory ${filterOtherChargesByCategory.length}");
                double OtherChargesAmount = 0.0;
                OtherChargesAmount = GetOtherChargesAmount(productDetail.subTotal, COC.OverAllValue,isPercentage: COC.IsOverAllPercentage, isAddDiscountedSubTotal: true, discountedSubTotal: productDetail.discountedSubTotal, quantity: productDetail.quantity );
                COC.OtherChargesAmount = Calculation().add(OtherChargesAmount, COC.OtherChargesAmount);
                print("OC $OtherChargesAmount ${COC.OtherChargesAmount}");
                productDetail.totalOtherChargesAmount = Calculation().add(productDetail.totalOtherChargesAmount, OtherChargesAmount);

                int index = tempOCList.indexWhere((f) => f.OtherChargesCategoryId == COC.OtherChargesCategoryId && f.OrderProductId == productDetail.productId);
                if (index == -1) {
                  tempOCList.add(OtherChargesMapping().CreateOCMapping(orderUtils['orderId'], productDetail.productId, COC, isOverAll: true));
                }
                else {
                  tempOCList[index].OtherChargesAmount = Calculation().add(tempOCList[index].OtherChargesAmount, OtherChargesAmount);
                }
            }
        }
        else {
          //var filterOtherChargesByCategory = $.grep(productDetail.otherChargesList, function (e) { return e.OtherChargesCategoryId == COC.OtherChargesCategoryId });
          var filterOtherChargesByCategory=productDetail.otherChargesList!.where((element) => element.OtherChargesCategoryId==COC.OtherChargesCategoryId).toList();
          filterOtherChargesByCategory.forEach((OCDetail) {
            OCDetail.OtherChargesAmount = 0.0;
            OCDetail.OtherChargesAmount = GetOtherChargesAmount(productDetail.subTotal, OCDetail.OtherChargesValue,isPercentage: OCDetail.IsPercentage, isAddDiscountedSubTotal: true, discountedSubTotal: productDetail.discountedSubTotal, quantity: productDetail.quantity );

            COC.OtherChargesAmount = Calculation().add(COC.OtherChargesAmount, OCDetail.OtherChargesAmount);

            //COC.OtherChargesAmount = nerdamerCalc('+', getParsedNumber(COC.OtherChargesAmount), OCDetail.otherChargeAmount);
            productDetail.totalOtherChargesAmount = Calculation().add(productDetail.totalOtherChargesAmount, OCDetail.OtherChargesAmount);

            int index = tempOCList.indexWhere((f) => f.OtherChargesId == OCDetail.OtherChargesId && f.OrderProductId == productDetail.productId);
            if (index == -1) {
              tempOCList.add(OtherChargesMapping().CreateOCMapping(orderUtils['orderId'], productDetail.productId, OCDetail,isOverAll: false));
            }
            else {
              tempOCList[index].OtherChargesAmount = Calculation().add(tempOCList[index].OtherChargesAmount, OCDetail.OtherChargesAmount);
            }
          });
        }
    });

    //productDetail.grandTotal =  p.parse("${productDetail.subTotal}+${productDetail.taxAmount}+${productDetail.totalOtherChargesAmount}-${productDetail.discountAmount}").evaluate(EvaluationType.REAL, cm);
    double x=p.parse("${productDetail.subTotal}+${productDetail.taxAmount}+${productDetail.totalOtherChargesAmount}").evaluate(EvaluationType.REAL, cm);
    productDetail.grandTotal=Calculation().sub(x, productDetail.discountAmount);
    //print("productDetail.grandTotal ${productDetail.grandTotal} ${orderUtils['discountAmount']}");
    //print(Calculation().sub(x, productDetail.discountAmount));
   // print(p.parse("${x}-${productDetail.discountAmount}").evaluate(EvaluationType.REAL, cm));

    //print("orderUtils['discountAmount']  ${orderUtils['discountAmount']} ${productDetail.subTotal} ${productDetail.taxAmount} ${productDetail.totalOtherChargesAmount} ${productDetail.discountAmount} discountedSubTotal_${productDetail.discountedSubTotal} ${productDetail.grandTotal}");
    //var a=(Rational.parse('$x') - Rational.parse('${productDetail.discountAmount}')).toString();

    //print(a);
   // print(Calculation().div5(a.split("/")[0], a.split("/")[1]));
  }

  List<ParameterModel> insertKotParameters(){
    List<ParameterModel> params=[];
    params.add(ParameterModel(Key: "OrderId", Type: "int", Value: this.orderId));
    params.add(ParameterModel(Key: "OrderTypeId", Type: "int", Value: this.orderTypeId));
    params.add(ParameterModel(Key: "FloorId", Type: "int", Value: this.floorId));
    params.add(ParameterModel(Key: "CustomerId", Type: "int", Value: this.customerId));
    params.add(ParameterModel(Key: "TableNumberId", Type: "int", Value: this.tableId));
    params.add(ParameterModel(Key: "DynamicTable", Type: "String", Value: this.isDynamicTable!?this.tableNumber:null));
    params.add(ParameterModel(Key: "Covers", Type: "int", Value: this.covers));
    params.add(ParameterModel(Key: "CaptainId", Type: "int", Value: this.captainId));
    params.add(ParameterModel(Key: "WaiterId", Type: "int", Value: this.waiterId));
    params.add(ParameterModel(Key: "SubTotal", Type: "String", Value: this.subTotal));
    params.add(ParameterModel(Key: "IsOverAllDiscount", Type: "String", Value: this.isOverAllDiscount));
    params.add(ParameterModel(Key: "IsDiscount", Type: "String", Value: this.isDiscount));
    params.add(ParameterModel(Key: "IsPercentage", Type: "String", Value: this.isPercentage));
    params.add(ParameterModel(Key: "DiscountValue", Type: "String", Value: this.discountValue));
    params.add(ParameterModel(Key: "DiscountAmount", Type: "String", Value: this.discountAmount));
    params.add(ParameterModel(Key: "DiscountedSubTotal", Type: "String", Value: this.discountedSubTotal));
    params.add(ParameterModel(Key: "TaxAmount", Type: "String", Value: this.taxAmount));
    params.add(ParameterModel(Key: "AdditionalDiscount", Type: "String", Value: this.additionalDiscount));
    params.add(ParameterModel(Key: "AddonAmount", Type: "String", Value: this.addonAmount));
    params.add(ParameterModel(Key: "RoundOffAmount", Type: "String", Value: this.roundOffAmount));
    params.add(ParameterModel(Key: "IsTableMerge", Type: "String", Value: this.isMergeTable));
    params.add(ParameterModel(Key: "IsHold", Type: "String", Value: this.isHold));
    params.add(ParameterModel(Key: "GrandTotalAmount", Type: "String", Value: this.grandTotalAmount));
    params.add(ParameterModel(Key: "OrderProductMappingList", Type: "datatable", Value: this.productList!.map((e) => e.ProductObj(this.orderId)).toList()));
    params.add(ParameterModel(Key: "KOTCommentandAddOnList", Type: "datatable", Value: this.addOnCommentsList!.where((element) => element.kOTId==null).map((e) => e.toJson()).toList()));
    params.add(ParameterModel(Key: "OrderTableSeatMappingList", Type: "datatable", Value: ""));
    params.add(ParameterModel(Key: "OrderTaxAmountClassificationList", Type: "datatable", Value: this.taxList!.map((e) => e.ToJsonTax()).toList()));
    params.add(ParameterModel(Key: "OrderProductTaxClassificationList", Type: "datatable", Value: this.productTaxMappingList!.map((e) => e.ToJsonTaxProduct()).toList()));
    params.add(ParameterModel(Key: "OrderProductAmountClassificationList", Type: "datatable", Value: this.otherChargesList!.map((e) => e.ToJsonOtherCharges()).toList()));
    return params;
  }

  List<ParameterModel> insertBillParameters(){
    List<ParameterModel> params=[];
    params.addAll(this.insertKotParameters());
    int index=params.indexWhere((element) => element.Key=="OrderProductMappingList");
    params[index].Value=this.totalProductList!.map((e) => e.ProductObj(this.orderId)).toList();

    index=params.indexWhere((element) => element.Key=="KOTCommentandAddOnList");
    params[index].Value=this.addOnCommentsList!.map((e) => e.toJson()).toList();

    params.add(ParameterModel(Key: "Tips", Type: "String", Value: this.tips));
    params.add(ParameterModel(Key: "IsTaxExemption", Type: "String", Value: this.isTaxExemption));
    params.add(ParameterModel(Key: "IsRoundoffEnable", Type: "String", Value: this.isRoundOffExemption));
    params.add(ParameterModel(Key: "IsBillCredit", Type: "String", Value: this.isBillCredit));
    return params;
  }

  List<ParameterModel> insertSettlementParameters(List<PaymentTypeMapping> paymentType){
    List<ParameterModel> params=[];
    params.addAll(this.insertBillParameters());
    params.add(ParameterModel(Key: "BillId", Type: "int", Value: this.billId));
    params.add(ParameterModel(Key: "BillPaymentMappingList", Type: "datatable", Value: paymentType.map((e) => e.toJsonSettlement(this.billId)).toList()));
    return params;
  }

  List<ParameterModel> insertBillComplimentParameters(){
    List<ParameterModel> params=[];
    params.add(ParameterModel(Key: "OrderId", Type: "int", Value: this.orderId));
    params.add(ParameterModel(Key: "OrderTypeId", Type: "int", Value: this.orderTypeId));
    params.add(ParameterModel(Key: "FloorId", Type: "int", Value: this.floorId));
    params.add(ParameterModel(Key: "CustomerId", Type: "int", Value: this.customerId));
    params.add(ParameterModel(Key: "TableNumberId", Type: "int", Value: this.tableId));
    params.add(ParameterModel(Key: "DynamicTable", Type: "String", Value: this.isDynamicTable!?this.tableNumber:null));
    params.add(ParameterModel(Key: "Covers", Type: "int", Value: this.covers));
    params.add(ParameterModel(Key: "CaptainId", Type: "int", Value: this.captainId));
    params.add(ParameterModel(Key: "WaiterId", Type: "int", Value: this.waiterId));
    params.add(ParameterModel(Key: "SubTotal", Type: "String", Value: this.subTotal));
    params.add(ParameterModel(Key: "IsOverAllDiscount", Type: "String", Value: this.isOverAllDiscount));
    params.add(ParameterModel(Key: "IsDiscount", Type: "String", Value: this.isDiscount));
    params.add(ParameterModel(Key: "IsPercentage", Type: "String", Value: this.isPercentage));
    params.add(ParameterModel(Key: "DiscountValue", Type: "String", Value: this.discountValue));
    params.add(ParameterModel(Key: "DiscountAmount", Type: "String", Value: this.discountAmount));
    params.add(ParameterModel(Key: "DiscountedSubTotal", Type: "String", Value: this.discountedSubTotal));
    params.add(ParameterModel(Key: "TaxAmount", Type: "String", Value: this.taxAmount));
    params.add(ParameterModel(Key: "AdditionalDiscount", Type: "String", Value: this.additionalDiscount));
    params.add(ParameterModel(Key: "AddonAmount", Type: "String", Value: this.addonAmount));
    params.add(ParameterModel(Key: "RoundOffAmount", Type: "String", Value: this.roundOffAmount));
    params.add(ParameterModel(Key: "IsTableMerge", Type: "String", Value: this.isMergeTable));
    params.add(ParameterModel(Key: "IsHold", Type: "String", Value: this.isHold));
    params.add(ParameterModel(Key: "GrandTotalAmount", Type: "String", Value: this.grandTotalAmount));
    return params;
  }

  updateConsolidateOtherCharges(otherChargesList,productTaxMapping){
    this.consolidateOtherCharges=[];
    this.productTaxMappingList=[];
    otherChargesList.forEach((e){this.consolidateOtherCharges!.add(ConsolidateOtherChargess.FromJson(e));});
    productTaxMapping.forEach((e){this.productTaxMappingList!.add(OtherChargesMapping.FromJsonTax(e));});
    //this.consolidateOtherCharges=otherChargesList.map((e)=>ConsolidateOtherChargess.FromJson(e)).toList();
  }

  updateTaxOCList(taxList, otherChargesList){
    this.taxList=[];
    this.otherChargesList=[];
    taxList.forEach((e) => this.taxList!.add(OtherChargesMapping.FromJsonTax(e)));
    otherChargesList.forEach((e) => this.otherChargesList!.add(OtherChargesMapping.FromJsonTax(e)));
  }

  updateAddons(addonsList){
    this.addOnCommentsList=[];
    addonsList.forEach((e) => this.addOnCommentsList!.add(KOTCommentandAddOnMapping.fromJson(e)));
  }


  createProductFromHold(products){
    this.productList = [];
    products.forEach((e) async {
      // ProductModel tempModel = await ProductModel().FromJson(e, this.orderTypeId);
      // this.productList!.add(tempModel);
    });
  }

  kotProductDeleteManipulation(kotIndex, kotProductIndex, backupProduct, backupAddons, isDelete){
    if (isDelete) {
      this.totalOrderKotWiseList![kotIndex].productList!.removeAt(kotProductIndex);
      this.addOnCommentsList!.removeWhere((element) => element.kOTId==this.totalOrderKotWiseList![kotIndex].KotId && element.orderProductId==backupProduct.productId);
      //this.addOnCommentsList = this.addOnCommentsList!.where((element) => element.kOTId!=this.totalOrderKotWiseList![kotIndex].KotId).toList();
      //|| e.OrderProductId != backupProduct.productId;
    }
    else {
      this.totalOrderKotWiseList![kotIndex].productList!.insert(kotProductIndex, backupProduct);
      this.addOnCommentsList!.addAll(backupAddons);
      this.orderCalculation();
    }
  }

  kotProductDeleteCalculation(productMappingId){
    this.discountAmount=0.0;
    double subTotal = 0.0;
    double taxAmount = 0.0;
    double discountedSubTotal = 0.0;
    double discountAmount = 0.0;
    double grandTotalAmount = 0.0;
    double roundOffAmount = 0.0;

    var tempTaxList = this.taxList;
    var tempOCList = this.otherChargesList;
    var tempTaxProductMapping  = this.productTaxMappingList;

    var orderId = this.orderId;
    this.consolidateOtherCharges!.forEach((v){ v.OtherChargesAmount = 0.0; v.isExemption = false; });
    
    tempTaxList!.forEach((v){ v.OtherChargesAmount = 0.0; });
    tempOCList!.forEach((v){ v.OtherChargesAmount = 0.0; });
    tempTaxProductMapping!.forEach((v){ v.OtherChargesAmount = 0.0; });

    this.totalOrderKotWiseList!.forEach((f) {
      f.productList!.forEach((e) {
        double tempST = Calculation().mul(e.quantity, e.productPrice);
        subTotal = Calculation().add(subTotal, tempST);
      });
    });

    var orderUtils = {
      "orderId": this.orderId,
      "isDiscount": this.isDiscount,
      "isPercentage": this.isPercentage,
      "discountValue": this.discountValue,
      "isOverAllDiscount": this.isOverAllDiscount,
      "isOverAllTax": this.isOverAllTax,
      "subTotal": subTotal,
      "taxAmount": 0.0,
      "discountAmount": this.discountAmount,
      "discountedSubTotal": 0.0,
      "grandTotalAmount": 0.0,
      "roundOffAmount": 0.0,
      "tempTaxList": tempTaxList,
      "tempOCList": tempOCList,
      "tempTaxProductMapping": tempTaxProductMapping,
      "consolidateOtherChargesList": this.consolidateOtherCharges,
      "consolidateProducts": this.consolidateProducts
    };


    this.totalOrderKotWiseList!.forEach((orderDetail) {
      orderDetail.productList!.forEach((e) {
        double c_product_subtotal = 0.0;
       // if (!this.isOverAllDiscount!) {
          c_product_subtotal = e.subTotal??0.0;
      //  }
        productCalculation(e, orderUtils,c_product_subtotal_iwd: c_product_subtotal);
        taxAmount = Calculation().add(taxAmount, e.taxAmount);
        discountedSubTotal = Calculation().add(discountedSubTotal, e.discountedSubTotal);
        grandTotalAmount = Calculation().add(grandTotalAmount, e.grandTotal);
      });
    });


/*    this.totalOrderKotWiseList.forEach(function (orderDetail, i) {
    orderDetail.productList.forEach(function (e, i) {
    OrderModel.prototype.ProductCalculation.call(this, e, orderUtils, 0, i);
    taxAmount = nerdamerCalc('+', taxAmount, e.taxAmount);
    discountedSubTotal = nerdamerCalc('+', discountedSubTotal, e.discountedSubTotal);
    grandTotalAmount = nerdamerCalc('+', grandTotalAmount, e.grandTotal);
    });
    });*/


   // var addonAmount = 0.0;
    //this.addOnCommentsList.filter(e => getParsedNumber(e.Price) > 0).forEach((e) => { addonAmount = nerdamerCalc('+', addonAmount, e.Price); });





    this.addonAmount = 0.0;
    this.addOnCommentsList!.where((e) => parseDouble(e.price) > 0).forEach((e) => { this.addonAmount = Calculation().add( this.addonAmount, e.price) });

    this.subTotal = subTotal;
    this.taxAmount = taxAmount;
    //this.discountAmount = orderUtils['discountAmount'];
    this.discountAmount = parseDouble(orderUtils['discountAmount']);
    this.discountedSubTotal = discountedSubTotal;
    this.grandTotalAmount = Calculation().add( this.addonAmount, grandTotalAmount) ;
    //this.grandTotalAmount = grandTotalAmount;
    this.roundOffAmount = Calculation().sub(grandTotalAmount.round(), grandTotalAmount);

    /*this.taxList = tempTaxList;
    this.otherChargesList = tempOCList;
    this.productTaxMappingList = tempTaxProductMapping;*/
    List<ParameterModel> params=[];
    params.add(ParameterModel(Key: "OrderId", Type: "int", Value: this.orderId));
    params.add(ParameterModel(Key: "OrderTypeId", Type: "int", Value: this.orderTypeId));
    params.add(ParameterModel(Key: "FloorId", Type: "int", Value: this.floorId));
    params.add(ParameterModel(Key: "CustomerId", Type: "int", Value: this.customerId));
    params.add(ParameterModel(Key: "TableNumberId", Type: "int", Value: this.tableId));
    params.add(ParameterModel(Key: "DynamicTable", Type: "String", Value: this.isDynamicTable!?this.tableNumber:null));
    params.add(ParameterModel(Key: "OrderProductMappingId", Type: "String", Value: productMappingId));
    params.add(ParameterModel(Key: "Covers", Type: "int", Value: this.covers));
    params.add(ParameterModel(Key: "CaptainId", Type: "int", Value: this.captainId));
    params.add(ParameterModel(Key: "WaiterId", Type: "int", Value: this.waiterId));
    params.add(ParameterModel(Key: "SubTotal", Type: "String", Value: this.subTotal));
    params.add(ParameterModel(Key: "IsOverAllDiscount", Type: "String", Value: this.isOverAllDiscount));
    params.add(ParameterModel(Key: "IsDiscount", Type: "String", Value: this.isDiscount));
    params.add(ParameterModel(Key: "IsPercentage", Type: "String", Value: this.isPercentage));
    params.add(ParameterModel(Key: "DiscountValue", Type: "String", Value: this.discountValue));
    params.add(ParameterModel(Key: "DiscountAmount", Type: "String", Value: this.discountAmount));
    params.add(ParameterModel(Key: "DiscountedSubTotal", Type: "String", Value: this.discountedSubTotal));
    params.add(ParameterModel(Key: "TaxAmount", Type: "String", Value: this.taxAmount));
    params.add(ParameterModel(Key: "AdditionalDiscount", Type: "String", Value: this.additionalDiscount));
    params.add(ParameterModel(Key: "AddonAmount", Type: "String", Value: this.addonAmount));
    params.add(ParameterModel(Key: "RoundOffAmount", Type: "String", Value: this.roundOffAmount));
    params.add(ParameterModel(Key: "IsTableMerge", Type: "String", Value: this.isMergeTable));
    params.add(ParameterModel(Key: "IsHold", Type: "String", Value: this.isHold));
    params.add(ParameterModel(Key: "GrandTotalAmount", Type: "String", Value: this.grandTotalAmount));
    params.add(ParameterModel(Key: "OrderProductMappingList", Type: "datatable", Value: this.productList!.map((e) => e.ProductObj(this.orderId)).toList()));
    params.add(ParameterModel(Key: "KOTCommentandAddOnList", Type: "datatable", Value: this.addOnCommentsList!.where((element) => element.kOTId==null).map((e) => e.toJson()).toList()));
    params.add(ParameterModel(Key: "OrderTableSeatMappingList", Type: "datatable", Value: ""));
    params.add(ParameterModel(Key: "OrderTaxAmountClassificationList", Type: "datatable", Value: tempTaxList.map((e) => e.ToJsonTax()).toList()));
    params.add(ParameterModel(Key: "OrderProductTaxClassificationList", Type: "datatable", Value: tempTaxProductMapping.map((e) => e.ToJsonTaxProduct()).toList()));
    params.add(ParameterModel(Key: "OrderProductAmountClassificationList", Type: "datatable", Value: tempOCList.map((e) => e.ToJsonOtherCharges()).toList()));
    return params;
  }

  OrderModel.fromJson(Map<String, dynamic> json) {
    tableNumber = json['tableNumber'];
    isDynamicTable = json['isDynamicTable'];
    totalSeats = json['totalSeats'];
    covers = json['covers'];
    waiterId = json['waiterId'];
    captainId = json['captainId'];
    customerId = json['customerId'];
    billId = json['billId'];
    tips = json['tips'];
    isBillCredit = json['isBillCredit'];
    isMergeTable = json['isMergeTable'];
    isHold = json['isHold'];
    isTax = json['isTax'];
    isOverAllDiscount = json['isOverAllDiscount']??false;
    isOverAllTax = json['isOverAllTax'];
    isDiscount = json['isDiscount'];
    isPercentage = json['isPercentage'];
    isTaxExemption = json['isTaxExemption'];
    isRoundOffExemption = json['isRoundOffExemption']??false;
    subTotal = json['subTotal'];
    taxAmount = json['taxAmount'];
    taxValue = json['taxValue'];
    discountAmount = json['discountAmount'];
    discountedSubTotal = json['discountedSubTotal'];
    discountValue = json['discountValue'];
    additionalDiscount = json['additionalDiscount'];
    grandTotalAmount = json['grandTotalAmount'];
    roundOffAmount = json['roundOffAmount'];

    addonAmount = json['addonAmount'];

    isBillSplit = json['isBillSplit'];
    isCoversSplit = json['isCoversSplit'];
    isBillCompliment = json['isBillCompliment'];

    orderId = json['orderId'];
    orderNumber = json['orderNumber'];
    tableId = json['tableId'];
    floorId = json['floorId'];
    floorName = json['floorName'];
    orderTypeId = json['orderTypeId'];
    orderTypeName = json['orderTypeName'];
  }
  OrderDetailFromJson(orderDetailObj, taxList, otherChargesList){

    print(orderDetailObj);
    this.orderId = orderDetailObj['OrderId'];
    this.orderNumber = orderDetailObj['OrderNumber'];
    this.orderTypeId = orderDetailObj['OrderTypeId'];
    this.orderTypeName = orderDetailObj['OrderTypeName'];
    this.floorId = orderDetailObj['FloorId'];
    this.floorName = orderDetailObj['FloorName'];
    this.tableId = orderDetailObj['TableNumberId'];
    this.tableNumber = orderDetailObj['TableNumber'];
    this.isDynamicTable = orderDetailObj['IsDynamicTable'];
    this.totalSeats = 0;
    this.covers = orderDetailObj['Covers'];
    this.waiterId = orderDetailObj['WaiterId'];
    //this.w = orderDetailObj['WaiterName'];
    this.captainId = orderDetailObj['CaptainId'];
    //this.captainName = orderDetailObj['CaptainName'];
    this.customerId = orderDetailObj['CustomerId'];
    this.billId = orderDetailObj['BillId'];
    this.tips = orderDetailObj['Tips'];
    this.isBillCredit = orderDetailObj['IsBillCredit'];
    this.isTax = orderDetailObj['IsTax'];
    this.isOverAllDiscount = orderDetailObj['IsOverAllDiscount']??false;
    this.isOverAllTax = orderDetailObj['IsOverAllTax'];
    this.isMergeTable = orderDetailObj['IsTableMerge'];
    this.isHold = orderDetailObj['IsHold']??false;

    this.isDiscount = orderDetailObj['IsDiscount'];
    this.isPercentage = orderDetailObj['IsPercentage'];

    this.isTaxExemption = orderDetailObj['IsTaxExemption']??false;
    this.isRoundOffExemption = orderDetailObj['IsRoundOffExemption']??false;

    this.subTotal = orderDetailObj['SubTotal'];
    this.taxAmount = orderDetailObj['TaxAmount'];
    this.taxValue = orderDetailObj['TaxValue'];
    this.discountAmount = orderDetailObj['DiscountAmount'];
    this.discountedSubTotal = orderDetailObj['DiscountedSubTotal'];
    this.discountValue = orderDetailObj['DiscountValue'];
    this.additionalDiscount = orderDetailObj['AdditionalDiscount'];

    this.grandTotalAmount = orderDetailObj['GrandTotalAmount'];
    this.roundOffAmount = orderDetailObj['RoundOffAmount'];

    this.productList = [];
    this.consolidateOtherCharges = [];
    this.productTaxMappingList = [];

    this.addonAmount = orderDetailObj['AddonAmount'];
    this.addOnCommentsList = [];
    this.seatMappingList = [];

    this.totalOrderKotWiseList = [];
    this.consolidateProducts = [];
    this.shiftItems = [];

    this.isBillSplit = false;
    this.isCoversSplit = false;
    this.billSplitDetailArr = [];

    this.isBillCompliment=orderDetailObj['IsCompliment'];
    updateTaxOCList(taxList, otherChargesList);

  }
}

Parser p = Parser();
ContextModel cm = ContextModel();

double GetDiscountAmount( subTotal, value,{ isPercentage = true, orderSubTotal=0 }) {
    double tempValue;
    double tempAmount;
    if (isPercentage == true) {
      tempValue = value;
    }
    else {

    // tempValue = nerdamer(`${value}*100/${orderSubTotal}`).evaluate().text();
     // tempValue = p.parse("${value}*100/${orderSubTotal}").evaluate(EvaluationType.REAL, cm);
      tempValue= Calculation().div( Calculation().mul(value, "100"), orderSubTotal);
      //print("GetDiscountAmount $tempValue $value $orderSubTotal");


      //17Oct
      var a=(Rational.parse('${Calculation().mul(value, "100")}') / Rational.parse('${orderSubTotal}')).toString();
      tempValue=Calculation().div6(a);
     // print("aa $a ${Calculation().div5(a.split("/")[0], a.split("/")[1])} $tempValue");
    }
    //tempValue = nerdamerCalc('/', getParsedNumber(tempValue), 100);
    tempValue = Calculation().div(tempValue, 100);
    //tempAmount = Calculation().mul(subTotal, tempValue);

    var a=(Rational.parse('${subTotal}') * Rational.parse('${tempValue}')).toString();
    //print("aa $a ${Calculation().div5(a.split("/")[0], a.split("/")[1])} $tempAmount");
    //tempAmount=Calculation().div5(a.split("/")[0], a.split("/")[1]);
    tempAmount=Calculation().div6(a);


  //  print("GetDiscountAmount $subTotal $tempValue $tempAmount ${Calculation().truncateToDecimalPlaces(tempAmount,13)}");
    //tempAmount = nerdamerCalc('*', getParsedNumber(subTotal), tempValue);
    return tempAmount;
    return Calculation().truncateToDecimalPlaces(tempAmount,13);
}

double GetTaxAmount(subTotal, value,{ isPercentage = true, isAddDiscountedSubTotal = false,discountedSubTotal = 0, }) {
    var tempValue;
    var tempAmount;
    if (isPercentage == true) {
      tempValue = value;
    }
    else {
      //tempValue = p.parse("${value}*100/${subTotal}").evaluate(EvaluationType.REAL, cm);
      tempValue= Calculation().div( Calculation().mul(value, "100"), subTotal);
      print("GetTaxAmount $tempValue");
    }
    tempValue = Calculation().div(tempValue, 100);
    if (isAddDiscountedSubTotal==true)
      tempAmount = Calculation().mul(discountedSubTotal, tempValue);
    else
      tempAmount = Calculation().mul(subTotal, tempValue);
    return tempAmount;
}


double GetOtherChargesAmount( subTotal, value,{ isPercentage = true, isAddDiscountedSubTotal = false, discountedSubTotal = 0, quantity = 0 }) {
    var tempValue;
    var tempAmount;
    if (isPercentage == true) {
      tempValue = Calculation().div(value, 100);
    }
    else {
      tempValue = value;
      return quantity * value;
    }
    if (isAddDiscountedSubTotal == true)
      tempAmount = Calculation().mul(discountedSubTotal, tempValue);
    else
      tempAmount = Calculation().mul(subTotal, tempValue);

    return tempAmount;
}