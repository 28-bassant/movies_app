import 'package:flutter/material.dart';
import 'package:movies_app/UI/movies_details/sections/custom_widget/genres_widget.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/model/movie_details_response.dart';
import 'package:movies_app/utils/app_styles.dart';

class GenresSection extends StatelessWidget {
  MovieDetails movieDetails;
  GenresSection({super.key, required this.movieDetails});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.genres,
          style: AppStyles.bold24White,
        ),
        SizedBox(height: height * .02),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 3,
          ),
          itemCount: movieDetails.genres?.length ?? 0,
          itemBuilder: (context, index) {
            List<String> genresList = movieDetails.genres ?? [];
            return GenresWidget(text: genresList[index]);
          },
        ),
      ],
    );
  }
}
