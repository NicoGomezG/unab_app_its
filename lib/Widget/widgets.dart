import 'package:flutter/material.dart';

Widget appBar(BuildContext context){
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: const <TextSpan>[
        TextSpan(text: 'Nuevo', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent)),
        TextSpan(text: ' Cuestionario', style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blueAccent)),
      ],
    ),
  );
}

Widget blueButton(BuildContext context, String label){
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
      color: Colors.blue.shade900,
      borderRadius: BorderRadius.circular(30)
    ),
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width - 48,
    child: Text(label,style: TextStyle(color: Colors.white,fontSize: 18)
      ,)

  );

}
