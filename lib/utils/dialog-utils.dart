
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

class DialogUtils{

  static void showLopading({required String textLoading,required BuildContext context}){
    showDialog(barrierDismissible: false,
      context: context, builder: (context) =>
          AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(color: AppColors.orangeColor,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(textLoading,style: AppStyles.bold20Black,),
                )
              ],
            ),
          )
      ,);
  }
  static void hideLoading({required BuildContext context}){
    Navigator.pop(context);

  }

  static void showMsg({required BuildContext context,
    required String msg,String? title,String? posActionName,
    Function? posAction,String? negActionName,Function? negAction,bool barrierDismissible= true }){
    List<Widget>? actions=[];
    if(posActionName != null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        posAction?.call();
      }, child: Text(posActionName,style:AppStyles.bold14Black,)));

    }
    if(negActionName !=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        negAction?.call();
      }, child: Text(negActionName,style:AppStyles.bold14Black ,)));
    }
    if (actions.isEmpty) {
      actions.add(
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("OK", style: AppStyles.bold14Black),
        ),
      );
    }

    showDialog(barrierDismissible: barrierDismissible,
        context: context, builder: (context) => AlertDialog(
          content: Text(msg,style: AppStyles.bold20Black,),
          title: Text(title??'',style: AppStyles.bold14Black,),
          actions: actions,
        ));
  }
}