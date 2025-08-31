import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/widgets/custom-text-form-field.dart';
import 'package:movies_app/utils/app_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_routes.dart';
import '../home-tap/api_model/movie.dart';
import '../home-tap/movie_service.dart';
import 'cubit/search-state.dart';
import 'cubit/search-view-model.dart';
import 'movie-grid-item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchTap extends StatefulWidget {
  const SearchTap({super.key});

  @override
  State<SearchTap> createState() => _SearchTapState();
}

class _SearchTapState extends State<SearchTap> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Column(
            children: [
              CustomTextFormField(
                hintText: AppLocalizations.of(context)!.search,
                prefixIcon: Image(image: AssetImage(AppAssets.searchIcon,))
                ,controller: searchController ,
                onChanged: (value) {
                  context.read<SearchViewModel>().searchMovies(value);
                },
              ),
              SizedBox(height: height * .02),
              Expanded(
                child: BlocBuilder<SearchViewModel, SearchState>(
                  builder: (context, state) {

                    if (state is SearchLoading) {
                      return const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.orangeColor));
                    }
                    else if (state is SearchEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(AppAssets.emptyIcon),
                            SizedBox(height: height * .02),
                            Text(AppLocalizations.of(context)!.no_movies,
                                style: AppStyles.regular16White),
                          ],
                        ),
                      );
                    }
                    else if (state is SearchLoaded) {
                      return GridView.builder(
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: width * 0.03,
                          mainAxisSpacing: height * 0.02,
                          childAspectRatio: .80,
                        ),
                        itemCount: state.movies.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, AppRoutes.movieDetailsScreenRouteName,
                                  arguments: state.movies[index].id);

                            }, child:MovieGridItem(movie: state.movies[index]));
                        },
                      );
                    }
                    else if (state is SearchError) {
                      return Center(
                          child: Text(state.message,
                              style: AppStyles.regular16White));
                    }
                    return Center(
                      child: Text(AppLocalizations.of(context)!.search_movies,
                          style: AppStyles.bold20White),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
