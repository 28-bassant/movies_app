import 'package:flutter/material.dart';
import '../../home-tap/api_model/movie.dart';
import 'history_service.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../movies_details/movies_details_screen.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({super.key});

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  final HistoryService historyService = HistoryService();
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await historyService.getHistory();
    setState(() {
      movies = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (movies.isEmpty) {
      return const Center(
        child: Text("No history yet", style: TextStyle(color: Colors.white)),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.65,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        final movie = movies[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MoviesDetailsScreen(
                  movieId: movie.id!,
                ),
              ),
            );
          },
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    children: [
                      Image.network(
                        movie.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: Container(
                          padding:  EdgeInsets.symmetric(horizontal: width*0.02,
                              vertical: height*0.004),
                          decoration: BoxDecoration(
                            color: Color(0xb3121312),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Text(
                                movie.rating.toString(),
                                style: const TextStyle(
                                  color: AppColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                               SizedBox(width: width*0.02),
                              const Icon(Icons.star, color: AppColors.yellowColor, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //SizedBox(height: height * 0.02),

            ],
          ),
        );
      },
    );
  }
}
