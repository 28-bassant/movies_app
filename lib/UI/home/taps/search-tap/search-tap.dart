import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/widgets/custom-text-form-field.dart';
import 'package:movies_app/utils/app_colors.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_assets.dart';
class SearchTap extends StatelessWidget {
  SearchTap({super.key});
  TextEditingController searchController =TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width =   MediaQuery.of(context).size.width;
    var height =   MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor:Colors.black,
        body:Padding(
          padding:  EdgeInsets.symmetric(
            horizontal: width*.02
          ),
          child: Column(
            children: [
              CustomTextFormField(hintText: AppLocalizations.of(context)!.search,
                prefixIcon: Image(image: AssetImage(AppAssets.searchIcon,))
                ,controller: searchController ,
                keyboardType: TextInputType.emailAddress,
               ),
              SizedBox(
                height: height*.3,
              ),
              Image(image: AssetImage(AppAssets.emptyIcon))
            ],
          ),
        ) ,

      ),
    );
  }
}
