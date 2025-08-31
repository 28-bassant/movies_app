import 'package:flutter/material.dart';
import 'package:movies_app/UI/auth/widgets/custom-text-form-field.dart';
import 'package:movies_app/utils/app_styles.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../utils/app_assets.dart';
import '../home-tap/api_model/movie.dart';
import '../home-tap/movie_service.dart';
import 'movie-grid-item.dart';

class SearchTap extends StatefulWidget {
  const SearchTap({super.key});

  @override
  State<SearchTap> createState() => _SearchTapState();
}

class _SearchTapState extends State<SearchTap> {
  TextEditingController searchController = TextEditingController();
  List<Movie> movies = [];
  bool isLoading = false;

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
                  searchMovies(value);
                },
              ),SizedBox(height: height*.02),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator(color: Colors.yellow))
                    : movies.isEmpty
                    ? Center(child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.emptyIcon),
                    SizedBox(height: height*.02),
                    Text(AppLocalizations.of(context)!.no_movies, style: AppStyles.regular16White
                    )],
                    ))
                    : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                    crossAxisSpacing: width * 0.03,
                    mainAxisSpacing: height * 0.02,
                    childAspectRatio: .80,
                      ),
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                    return MovieGridItem(movie: movies[index]);
                                      },
                                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void searchMovies(String query) async {
    setState(() {
      isLoading = true;
    });
    try {
      final results = await MovieService.fetchMovies(query: query);
      setState(() {
        movies = results;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
