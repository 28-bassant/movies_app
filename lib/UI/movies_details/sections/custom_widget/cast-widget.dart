import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../model/movie_details_response.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
class CastWidget extends StatelessWidget {
  final Cast cast;
  const CastWidget({Key? key, required this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(bottom: height * 0.015),
      padding: EdgeInsets.all(width * 0.03),
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: (cast.urlSmallImage != null && cast.urlSmallImage!.isNotEmpty)
                ? Image.network(
              cast.urlSmallImage!,
              width: width * 0.15,
              height: width * 0.15,
              fit: BoxFit.cover,
            )
                : Container(
              width: width * 0.15,
              height: width * 0.15,
              color: Colors.grey.shade800,
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: width * 0.1,
              ),
            ),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${AppLocalizations.of(context)!.name}: ${cast.name ?? "Unknown"}",
                  style: AppStyles.regular20White,
                ),
                SizedBox(height: height * 0.005),

                Text(
                  "${AppLocalizations.of(context)!.character}: ${cast.characterName ?? ""}",
                  style: AppStyles.regular20White,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}