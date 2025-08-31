import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';
import '../../../model/movie_details_response.dart';
import '../../../utils/app_styles.dart';
import 'custom_widget/cast-widget.dart';

class CastSection extends StatelessWidget {
  final List<Cast>? castList;

  const CastSection({Key? key, this.castList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    if (castList == null || castList!.isEmpty) {
      return Text("No cast found", style: AppStyles.regular20White);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${AppLocalizations.of(context)!.cast}", style: AppStyles.bold24White),
        SizedBox(height:height*.02),
         ...castList!.map((c) => CastWidget(cast: c)).toList(),
      ],
    );
  }
}