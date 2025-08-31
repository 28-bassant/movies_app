import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/UI/movies_details/sections/custom_widget/screenshot_custom_widget.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/model/movie_details_response.dart';
import 'package:movies_app/utils/app_styles.dart';

class ScreenshotsSection extends StatelessWidget {
  MovieDetails movieDetails;
  ScreenshotsSection({super.key, required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    print('URL: ${movieDetails.mediumScreenshotImage1}');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.screenShots,
          style: AppStyles.bold24White,
        ),
        SizedBox(height: height * .02),
        ScreenshotCustomWidget(
          image: movieDetails?.largeScreenshotImage1 ?? '',
        ),
        SizedBox(height: height * .02),
        ScreenshotCustomWidget(
          image: movieDetails?.largeScreenshotImage2 ?? '',
        ),
        SizedBox(height: height * .02),
        ScreenshotCustomWidget(
          image: movieDetails?.largeScreenshotImage3 ?? '',
        ),
        SizedBox(height: height * .02),
      ],
    );
  }
}
