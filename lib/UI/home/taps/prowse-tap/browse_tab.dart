import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/UI/home/widgets/movie_type_tab_bar.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';

import '../search-tap/cubit/search-state.dart';
import '../search-tap/cubit/search-view-model.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  final _moviesCubit = SearchViewModel();
  String selectedCategory = "Action";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.blackBgColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MovieTypeTabBar(
              onCategorySelected: (category) {
                _moviesCubit.searchMovies(query: '', genre: category);
              },
            ),
            BlocProvider(
              create: (_) =>
                  _moviesCubit..searchMovies(query: '', genre: 'action'),
              child: Expanded(
                child: BlocBuilder<SearchViewModel, SearchState>(
                  builder: (_, state) {
                    if (state is SearchLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (state is SearchLoaded) {
                      if (state.movies.isEmpty) {
                        return Center(
                          child: Text(
                            'No movies available',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        );
                      }
                      return GridView.builder(
                        padding: EdgeInsets.symmetric(
                          horizontal: width * .02,
                          vertical: height * .01,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: width * .06,
                          mainAxisSpacing: height * 0.02,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: state.movies.length,
                        itemBuilder: (context, index) {
                          final movie = state.movies[index];
                          return Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  movie.image,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: width * .01,
                                  vertical: height * .01,
                                ),
                                child: Container(
                                  width: 70,
                                  height: height * .04,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * .01,
                                    vertical: height * .005,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightBlack,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        movie.rating.toString(),
                                        style: TextStyle(
                                          color: AppColors.whiteColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Image.asset(AppAssets.rateIcon),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    } else if (state is SearchError) {
                      return Center(
                        child: Text(
                          'Error',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
