import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_styles.dart';
import '../home-tap/api_model/movie.dart';

class MovieGridItem extends StatelessWidget {
  final Movie movie;
  const MovieGridItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkGreyColor,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: SizedBox(
                  height: 190,
                  width: double.infinity,
                  child: Image.network(
                    movie.image??"",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: AppColors.darkGreyColor, child:Icon(Icons.broken_image, color: Colors.white)),
                  ),
                ),
              ),
              // Rating overlay
              Positioned(
                top: height*.005,
                left: width*.015,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: width*.015, vertical: height*.005),
                  decoration: BoxDecoration(
                    color: AppColors.lightBlack,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Text(
                        movie.rating.toString(),
                        style: AppStyles.bold14White
                      ),
                      SizedBox(width: width*.01),
                      const Icon(Icons.star, color: Colors.yellow, size: 14),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: width*.015, vertical: height*.009),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        movie.title,
                        style: AppStyles.regular20White,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}