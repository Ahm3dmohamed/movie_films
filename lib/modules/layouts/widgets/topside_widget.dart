import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/modules/manager/api_manager.dart';
import 'package:movie_app/service/models/top_side_movei_section.dart';

class TopsideWidget extends StatelessWidget {
  static const String routeName = "TopsideWidget";
  final ApiManager apiManager = ApiManager();

  TopsideWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: FutureBuilder<TopSideMovei>(
        future: apiManager.getTopSideMovei(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error while fetching data"),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text("No data found"),
            );
          } else {
            // This a snapshot of the model( topSide Movei Section)
            //    أو بالبلدي كده ي برو دا المتغير اللي من خلاله أقدر نادي ع أي داتا أنا عايزها داخل المودل اللي انا عامله
            var topSideMovei = snapshot.data!.results!;
            const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";

            return Column(
              children: [
                Expanded(
                  child: CarouselSlider.builder(
                    itemCount: topSideMovei.length,
                    itemBuilder: (context, index, realIdx) {
                      //  Take every path of the Top SideMovei Api's one by one  that i will use in this Page yaa man

                      String? backdropPath = topSideMovei[index].backdropPath;
                      String? posterPath = topSideMovei[index].posterPath;
                      String? movieTitle = topSideMovei[index].title;
                      String? releaseDate = topSideMovei[index].releaseDate;
                      num? movie = topSideMovei[index].id;
                      // print(movie);
                      String fullBackdropUrl =
                          backdropPath != null && backdropPath.isNotEmpty
                              ? "$imageBaseUrl$backdropPath"
                              : '';
                      String fullPosterUrl =
                          posterPath != null && posterPath.isNotEmpty
                              ? "$imageBaseUrl$posterPath"
                              : '';

                      return Stack(
                        children: [
                          // Basic Backdrop Image that will be behind the videoPlay icon  yaa broo
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              fullBackdropUrl,
                              fit: BoxFit.cover,
                              width: MediaQuery.of(context).size.width,
                              height: size.height * .18,
                            ),
                          ),
                          // Inset Movie Poster Image with positioned  yaa broo
                          Padding(
                            padding: EdgeInsets.only(
                              top: size.height * .07,
                              left: size.height * .02,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(34),
                              child: fullPosterUrl.isNotEmpty
                                  ? Image.network(
                                      fullPosterUrl,
                                      width: size.height * .1,
                                      height: size.height * .3,
                                      fit: BoxFit.fitWidth,
                                    )
                                  : const Text("No poster"),
                            ),
                          ),
                          // Icon Video Play Button
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: size.height * .09,
                              left: size.height * .01,
                            ),
                            child: Center(
                              child: IconButton(
                                iconSize: 50,
                                icon: Icon(
                                  Icons.play_circle_fill,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                onPressed: () {
                                  // Define the Function for the video play button
                                },
                              ),
                            ),
                          ),
                          // Movie Title and some Info
                          Positioned(
                            bottom: 6,
                            left: 125,
                            right: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movieTitle ?? 'Unknown Title',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Row(
                                  children: [
                                    Text(
                                      releaseDate != null
                                          ? releaseDate.substring(0, 4)
                                          : 'Unknown Year',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 7),
                                    const Text('PG-13 • 2h 7m',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.white,
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    options: CarouselOptions(
                      height: 350,
                      enlargeCenterPage: true,
                      // autoPlay: true,
                      aspectRatio: 16 / 9,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enableInfiniteScroll: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 800),
                      viewportFraction: 0.9,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
