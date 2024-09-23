import 'package:flutter/material.dart';
import 'package:movie_app/service/models/topside_details.dart';
import 'package:movie_app/modules/manager/api_manager.dart';

class TopsideDetailsWidget extends StatelessWidget {
  static const String routeName = "TopsideDetailsWidget";
  final ApiManager apiManager = ApiManager();
  TopsideDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TopSideDetailsModel>(
      future: apiManager.getTopSideDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return const Text("Error Fetching data");
        } else {
          var topsideDetails = snapshot.data;
          const String imageBaseUrl = "https://image.tmdb.org/t/p/w500";
          num? movie = topsideDetails!.id;

          return const Stack(
            children: [
              //  Image.network();
            ],
          );
        }
      },
    );
  }
}
