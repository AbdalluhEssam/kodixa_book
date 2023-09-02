import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kodixa_book/shared/styles/colors.dart';
import 'package:kodixa_book/shared/styles/icon_broken.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color color = Colors.blue,
        bool isUpperCase = true,
        required String text,
        required void Function()? onPressed}) =>
    Container(
      width: width,
      height: 40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(5), color: color),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );


Widget defaultTextButton({
  required void Function()? onPressed,
  required String text,
}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style:const TextStyle(
          fontWeight: FontWeight.bold
        ),
      ),
    );
Widget defaultTextFormField(
        {
          required TextEditingController controller,
        required TextInputType keyboardType,
        required String labelText,
        required IconData icon,
        required String? Function(String?)? validator,
        bool isPassShow = false,
        bool readOnly = false,
        Function()? suffixPressed,
        IconData? suffixIcon,
        void Function(String)? onFieldSubmitted,
        void Function()? onTap,
        void Function(String)? onChanged}) =>
    TextFormField(
      validator: validator,
      controller: controller,
      obscureText: isPassShow,
      keyboardType: keyboardType,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      readOnly: readOnly,
      onTap: onTap,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.black),
        prefixIcon: Icon(
          icon,
          color: Colors.black87,
        ),
        suffixIcon: suffixIcon != null
            ? IconButton(
                icon: Icon(suffixIcon),
                onPressed: suffixPressed,
              )
            : null,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
                color: defaultColor, width: 1, style: BorderStyle.solid)),
        enabledBorder:const  OutlineInputBorder(
            borderSide: BorderSide(
                color: defaultColor, width: 1, style: BorderStyle.solid)),
      ),
    );

Widget myDivider() => Container(
      color: Colors.grey,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 1,
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context,widget) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );


void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}



 defaultAppbar({required BuildContext context, String? title,List<Widget>? actions
}) =>
    AppBar(
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon: const Icon(IconBroken.Arrow___Left_2)),
      title: Text("$title"),
      titleSpacing: 5,

      actions: actions,
    );
