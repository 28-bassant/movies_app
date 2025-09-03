import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/UI/home/taps/profile-tap/widgets/movie_widget.dart';
import 'package:movies_app/api/api-manager.dart';

import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_routes.dart';

import '../../../../model/favourite_movies.dart';
import '../../../../model/movie_details_response.dart';

class WhishlistTab extends StatefulWidget {
  const WhishlistTab({super.key});

  @override
  State<WhishlistTab> createState() => _WhishlistTabState();
}
class _WhishlistTabState extends State<WhishlistTab> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchFavouriteMovies();
  }

  List<FavouriteMovies> favouriteMovies = [];

  void fetchFavouriteMovies() async {
    setState(() {
      isLoading = true;
    });

    try {
      List<FavouriteMovies> favs = await ApiManager.getAllFavouriteMovies();

      for (var fav in favs) {
        MovieDetailsResponse? response = await ApiManager.getMovieDetailsByMovieId(fav.id);

        fav.imageURL = response?.data?.movie?.mediumCoverImage ?? '';
      }

      setState(() {
        favouriteMovies = favs;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching favorite movies: $e");
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    if (isLoading) {
      return const Center(child: CircularProgressIndicator(color: AppColors.orangeColor,));
    }

    if (favouriteMovies.isEmpty) {
      return Center(child: Image.asset(AppAssets.empty_image));
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * .02
      ),
      child:GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: .6,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6
        ),
        itemCount: favouriteMovies.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutes.movieDetailsScreenRouteName,
                arguments: favouriteMovies[index].id,
              ).then((updated) {
                if (updated == true) {
                  fetchFavouriteMovies(); // refresh the wishlist
                }
              });
            },
            child: MovieWidget(
                image: favouriteMovies[index].imageURL,
                rating: favouriteMovies[index].rating),
          );
        },)
      ,
    );


  }
}
