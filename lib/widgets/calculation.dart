import 'package:decimal/decimal.dart';
import 'package:math_expressions/math_expressions.dart';

import '../utils/utils.dart';

int truncateDigit=5;
const maxPrecision=8;

class Calculation {
  Parser p = Parser();
  ContextModel cm = ContextModel();
  add(dynamic n1,dynamic n2){
    //double x= double.parse((Decimal.parse(n1==null?"0.0":n1.toString())+Decimal.parse(n2==null?"0.0":n2.toString())).toString());
    double x= p.parse("$n1+$n2").evaluate(EvaluationType.REAL, cm);
   // return parseDouble(x.toStringAsFixed(13));
    return x;
    return  truncateToDecimalPlaces(x, truncateDigit);
  }
  add2(dynamic n1,dynamic n2){
    //double x= double.parse((Decimal.parse(n1==null?"0.0":n1.toString())+Decimal.parse(n2==null?"0.0":n2.toString())).toString());
    double x= p.parse("${n1.toStringAsFixed(13)}+${n2.toStringAsFixed(13)}").evaluate(EvaluationType.REAL, cm);
    return parseDouble(x.toStringAsFixed(13));
    return  truncateToDecimalPlaces(x, truncateDigit);
  }
  add3(dynamic n1,dynamic n2,dynamic n3){
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())+
        Decimal.parse(n2==null?"0.0":n2.toString())+
        Decimal.parse(n3==null?"0.0":n3.toString())
    ).toString());
  }
  sub(dynamic n1,dynamic n2){
    double x=  double.parse((Decimal.parse(n1==null?"0.0":n1.toString())-Decimal.parse(n2==null?"0.0":n2.toString())).toString());
    //double x= p.parse("$n1-$n2").evaluate(EvaluationType.REAL, cm);
    //return parseDouble(x.toStringAsFixed(13));
    return x;
    return  truncateToDecimalPlaces(x, truncateDigit);
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())-Decimal.parse(n2==null?"0.0":n2.toString())).toString());
  }

  sub3(dynamic n1,dynamic n2,dynamic n3){
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())-
        Decimal.parse(n2==null?"0.0":n2.toString())-
        Decimal.parse(n3==null?"0.0":n3.toString())
    ).toString());
  }

  mul(dynamic n1,dynamic n2){
    //double x= double.parse((Decimal.parse(n1==null?"0.0":n1.toString())*Decimal.parse(n2==null?"0.0":n2.toString())).toString());
    double x= p.parse("$n1*$n2").evaluate(EvaluationType.REAL, cm);
    //return parseDouble(x.toStringAsFixed(13));
    return x;
    return truncateToDecimalPlaces(x, truncateDigit);
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())*Decimal.parse(n2==null?"0.0":n2.toString())).toString());
  }
  //double truncateToDecimalPlaces(num value, int fractionalDigits) => (value * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
  double truncateToDecimalPlaces(num value, int fractionalDigits) => double.parse(value.toStringAsFixed(5));
  div(dynamic n1,dynamic n2){
    //print(double.parse(p.parse("${n1}/${n2}").evaluate(EvaluationType.REAL, cm).toStringAsFixed(13)));
    /*double a=double.parse(p.parse("${n1}/${n2}").evaluate(EvaluationType.REAL, cm).toString());
    return truncateToDecimalPlaces(a, 12);*/
    double x=double.parse(p.parse("$n1/$n2").evaluate(EvaluationType.REAL, cm).toString());
    //return parseDouble(x.toStringAsFixed(13));
    return x;
    return truncateToDecimalPlaces(x, truncateDigit);
    return double.parse(p.parse("$n1/$n2").evaluate(EvaluationType.REAL, cm).toStringAsFixed(18));
   // return p.parse("${n1}/${n2}").evaluate(EvaluationType.REAL, cm);
    //return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())/Decimal.parse(n2==null?"0.0":n2.toString())).toString());
  }
  div2(dynamic n1,dynamic n2){
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())).toString())/100;
  }
  div3(dynamic n1,dynamic n2){
    return p.parse("$n1/$n2").evaluate(EvaluationType.REAL, cm);
  }
  div5(dynamic n1,dynamic n2){
    //print("n1 $n1 $n2");
    return double.parse(n1.toString())/double.parse(n2.toString());
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())/Decimal.parse(n2==null?"0.0":n2.toString())).toString());
  }
  div6(dynamic n1){
    var a=n1.toString().split("/");
    //var b=BigDecimal.parse(a[0].toString())/BigDecimal.parse(a[1].toString());
   // var c=double.parse(a[0].toString())/double.parse(a[1].toString());
    if(a.length==2)
      return double.parse(a[0].toString())/double.parse(a[1].toString());
    else
      return double.parse(a[0].toString());

  }

  taxAmount({dynamic taxValue, dynamic amount, dynamic discountAmount}){
    return double.parse(((Decimal.parse(taxValue==null?"0.0":taxValue.toString())*(Decimal.parse(amount==null?"0.0":amount.toString())-Decimal.parse(discountAmount==null?"0.0":discountAmount.toString())))/Decimal.parse("100")).toString());
  }

  discountAmount({dynamic discountValue, dynamic amount}){
   return double.parse(((Decimal.parse(discountValue==null?"0.0":discountValue.toString())*Decimal.parse(amount==null?"0.0":amount.toString()))/Decimal.parse("100")).toString());
  }

  totalAmount({dynamic amount, dynamic taxAmount, dynamic discountAmount}){
   return double.parse((Decimal.parse(amount==null?"0.0":amount.toString())+Decimal.parse(taxAmount==null?"0.0":taxAmount.toString())-Decimal.parse(discountAmount==null?"0.0":discountAmount.toString())).toString());
  }

  amountToDisPercentage({dynamic discountValue, dynamic subTotal}){
    return double.parse((((Decimal.parse(discountValue.toString())*Decimal.parse("100"))/Decimal.parse(subTotal.toString()))).toString())/100;
  }


  serviceAmount({dynamic serviceValue, dynamic subTotal}){
    return double.parse(((Decimal.parse(serviceValue==null?"0.0":serviceValue.toString())*Decimal.parse(subTotal==null?"0.0":subTotal.toString()))/Decimal.parse("100")).toString());
  }



  tax(dynamic taxValue,dynamic price,dynamic qty){

    return double.parse(((Decimal.parse(taxValue==null?"0.0":taxValue.toString()) *
        Decimal.parse(price==null?"0.0":price.toString()) * Decimal.parse(qty==null?"0.0":qty.toString()))/
        Decimal.parse("100")
    ).toString());
  }

  roundOff(dynamic n1,dynamic n2){
    return double.parse((Decimal.parse(n1==null?"0.0":n1.toString())-Decimal.parse(n2==null?"0.0":n2.toString())).toString());
    //return double.parse((Decimal.parse(n1==null?"0.0":double.parse(n1.toString()).round().toString())-Decimal.parse(n2==null?"0.0":n2.toString())).toString());
  }
}