import 'package:flutter/material.dart';
import 'package:movies_app/UI/home/widgets/movie_type_tab_bar.dart';
import 'package:movies_app/utils/app_assets.dart';
import 'package:movies_app/utils/app_colors.dart';

class BrowseTab extends StatefulWidget {
  const BrowseTab({super.key});

  @override
  State<BrowseTab> createState() => _BrowseTabState();
}

class _BrowseTabState extends State<BrowseTab> {
  final List<String> movies = [
    AppAssets.movieImage,
    AppAssets.movieImage,
    AppAssets.movieImage,
    AppAssets.movieImage,
    AppAssets.movieImage,
    AppAssets.movieImage,
    AppAssets.movieImage,
    AppAssets.movieImage,
    AppAssets.movieImage,
  ];

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
            MovieTypeTabBar(),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .02, vertical: height * .01),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: width * .06,
                  mainAxisSpacing: height * 0.02,
                  childAspectRatio: 0.65,
                ),
                itemCount: movies.length,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          movie,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * .01, vertical: height * .01),
                        child: Container(
                          width: 70,
                          height: height * .04,
                          padding: EdgeInsets.symmetric(
                              horizontal: width * .01, vertical: height * .005),
                          decoration: BoxDecoration(
                            color: AppColors.lightBlack,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                '7.7',
                                style: TextStyle(
                                    color: AppColors.whiteColor, fontSize: 20),
                              ),
                              SizedBox(width: 10),
                              Image.asset(AppAssets.rateIcon),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
