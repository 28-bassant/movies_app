import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/widgets/custom-elevated-button.dart';
import 'package:movies_app/UI/movies_details/sections/custom_widget/watch_custom_widget.dart';
import 'package:movies_app/UI/movies_details/sections/trailer_player.dart';
import 'package:movies_app/api/api-manager.dart';
import 'package:movies_app/app-prefrences/favourite_shared_prefenece.dart';
import 'package:movies_app/l10n/app_localizations.dart';
import 'package:movies_app/model/movie_details_response.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/toast_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';

class WatchSection extends StatefulWidget {
  MovieDetails movieDetails;
  WatchSection({super.key, required this.movieDetails});

  @override
  State<WatchSection> createState() => _WatchSectionState();
}

class _WatchSectionState extends State<WatchSection> {
  bool? isSelected ;
  bool isClicked = false;
  Future<void> _launchURL(String urlString) async {
    if (urlString.isEmpty) return;

    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Could not launch $url")));
    }
  }

  @override
  void initState() {
    super.initState();
    _loadFavouriteState();
  }

  void _loadFavouriteState() async {
    bool fav = await FavouritesSharedPreference.isFavourite(widget.movieDetails.id ?? 0);
    setState(() {
      isSelected = fav;
    });

    bool apiFav = await ApiManager.isFavourite(widget.movieDetails.id ?? 0);
    if (apiFav != fav) {
      setState(() {
        isSelected = apiFav;
      });

      if (apiFav) {
        await FavouritesSharedPreference.addFavourite(widget.movieDetails.id ?? 0);
      } else {
        await FavouritesSharedPreference.removeFavourite(widget.movieDetails.id ?? 0);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        isClicked
            ? Stack(
                children: [
                  TrailerPlayer(
                    ytTrailerCode: widget.movieDetails.ytTrailerCode ?? '',
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * .04,
                      horizontal: width * .04,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context,true),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: AppColors.whiteColor,
                            size: 30,
                          ),
                        ),
                        InkWell(
                          //todo: add to wishList
                          onTap: () async {
                            toggleFavourite();}
                          ,
                          child: Icon(
                            isSelected == true
                                ? Icons.bookmark
                                : Icons.bookmark_border_outlined,
                            color: AppColors.whiteColor,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.movieDetails?.largeCoverImage ?? '',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: height * .8,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.blackBgColor.withOpacity(1),
                              AppColors.transparentColor,
                            ],
                            stops: [0.0, 15.20],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * .04,
                      horizontal: width * .04,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context,true),
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: AppColors.whiteColor,
                                size: 30,
                              ),
                            ),
                            InkWell(
                              onTap: ()  {
                                toggleFavourite();

                              } ,
                              child: Icon(
                                isSelected == true
                                    ? Icons.bookmark
                                    : Icons.bookmark_border_outlined,
                                color: AppColors.whiteColor,
                                size: 35,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * .2),
                        InkWell(
                            onTap: () {
                              //todo : Play demo
                              isClicked = !(isClicked);
                              setState(() {});
                            },
                            child: Image(
                              image: AssetImage(AppAssets.playVideoImage),
                            ),
                          ),
                        SizedBox(height: height * .2),

                        Text(
                          widget.movieDetails!.title ?? '',
                          style: AppStyles.bold24White,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: height * .02),
                        Text(
                          '${widget.movieDetails!.year ?? ''}',
                          style: AppStyles.bold20Grey,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
        SizedBox(height: height * .04),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,

            children: [
              CustomElevatedButton(
                backgroundColorButton: AppColors.redColor,
                text: AppLocalizations.of(context)!.watch,
                textStyle: AppStyles.bold20White,
                onPressed: () {
                  launch(widget.movieDetails.url ?? '');
                  print("Movie URL: ${widget.movieDetails.url}");
                },
                colorSide: AppColors.redColor,
              ),
              SizedBox(height: height * .02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  WatchCustomWidget(
                    image: AppAssets.favIconImage,
                    text: widget.movieDetails.likeCount ?? 0,
                  ),
                  WatchCustomWidget(
                    image: AppAssets.timeIconImage,
                    text: widget.movieDetails.runtime ?? 0,
                  ),
                  WatchCustomWidget(
                    image: AppAssets.rateIconImage,
                    text: widget.movieDetails.rating ?? 0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  void toggleFavourite() async {
    final movieId = widget.movieDetails.id ?? 0;

    setState(() {
      isSelected = !(isSelected ?? false);
    });

    if (isSelected == true) {
      await FavouritesSharedPreference.addFavourite(movieId);
      await ApiManager.addMovieToFavourite(widget.movieDetails);
    } else {
      await FavouritesSharedPreference.removeFavourite(movieId);
      await ApiManager.removeMovieFromFavourite(movieId);
    }
  }

}
