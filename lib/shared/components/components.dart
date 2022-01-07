import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socail/layout/socialAppHome/socialCubit/cubit.dart';
import 'package:socail/shared/network/local/cashedHelper.dart';
import 'package:socail/shared/styles/colors.dart';
import 'package:socail/shared/styles/icon_broken.dart';
import 'package:toast/toast.dart';

Widget sharedTextButton({
  @required Function onPress,
  @required String text,
}) {
  return TextButton(onPressed: onPress, child: Text(text.toUpperCase()));
}

Widget sharedMaterialButton({
  double width = double.infinity,
  double height = 50.0,
  Color background = Colors.blue,
  double radius = 0.0,
  bool isUppercase = true,
  @required Function pressed,
  @required String txt,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(radius),
    ),
    child: MaterialButton(
      onPressed: pressed,
      child: Text(
        txt.toUpperCase(),
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    ),
  );
}

Widget sharedTextFormField({
  bool isPassword = false,
  @required TextEditingController controller,
  @required IconData prefixIcon,
  @required String text,
  @required Function validate,
  @required TextInputType type,
  Function onTap,
  Function suffixPressed,
  Color iconColor = Colors.blue,
  double radius = 0.0,
  IconData suffixIcon,
}) =>
    TextFormField(
      validator: validate,
      obscureText: isPassword,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefixIcon,
          color: colorApp,
        ),
        suffixIcon: suffixIcon != null ? IconButton(
          icon: Icon(suffixIcon , color: colorApp,), onPressed: suffixPressed,): null,
        hintText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      keyboardType: type,
      onTap: onTap,
    );

Widget defaultAppBar({
  @required context ,
  String title,
  List<Widget> actions,
})
{
  return AppBar(
    title: Text("$title" , style: Theme.of(context).textTheme.bodyText1,),
    leading: IconButton(
      onPressed: (){
        Navigator.pop(context);
      },
      icon: Icon(IconBroken.Arrow___Left_2),
    ),
    actions: actions,
    //titleSpacing: 5,
  );
}
navigateTo({
  @required context,
  @required screen,

}) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

navigateAndReplace({
  @required context,
  @required screen,
}) {
  return Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute(builder: (context) => screen), (
      route) => false);
}

 showToast(String msg, Color bg, context) {
   Toast.show(msg, context, backgroundColor: bg, duration: Toast.LENGTH_LONG,);
}

void signOut(context , screen) {
  CashedHelper.removeData(key: 'token').then((value) {
    if (value) navigateAndReplace(context: context, screen: screen);
  });
}


