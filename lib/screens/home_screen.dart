import 'package:filmoteca_app/data/category_data.dart';
import 'package:filmoteca_app/data/movies_data.dart';
import 'package:filmoteca_app/models/category_model.dart';
import 'package:filmoteca_app/models/movie_model.dart';
import 'package:filmoteca_app/widgets/home/trend_movies_carousel.dart';
import 'package:filmoteca_app/widgets/shared/custom_appbar.dart';
import 'package:filmoteca_app/widgets/shared/filter_horizontal_list.dart';
import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryModel> _categories = [];
  List<MovieModel> _trendMovies = [];

  int _selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();

    setState(() {
      _categories = [CategoryModel(id: -1, name: 'Tudo'), ...getCategories()];
      _trendMovies = getTrendMovies();
    });
  }

  void handleSelectCategory(int idx) {
    setState(() {
      _selectedCategoryIndex = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkPrimaryColor,
        appBar: const CustomHomeAppBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              SizedBox(
                  height: 35,
                  child: ListView.builder(
                    itemCount: _categories.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: ((context, index) => Container(
                          height: 35,
                          margin: const EdgeInsets.only(right: 6),
                          child: ElevatedButton(
                            onPressed: () {
                              handleSelectCategory(index);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: index == _selectedCategoryIndex
                                  ? AppColors.primaryColor
                                  : AppColors.secondaryDarkColor,
                              minimumSize: const Size(70, 35.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Text(
                              capitalizeText(_categories[index].name),
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  )),
              Container(
                  height: 180,
                  margin: const EdgeInsets.symmetric(vertical: 28),
                  height: 180,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: 180,
                            decoration: BoxDecoration(
                              color: AppColors.secondaryDarkColor,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: const NetworkImage(
                                    "https://loremflickr.com/320/240/movie,horror"),
                                fit: BoxFit.fill,
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.5),
                                  BlendMode.srcATop,
                                ),
                              ),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.only(
                                        left: 20, bottom: 15, top: 15),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromRGBO(0, 0, 0, 0.1),
                                          Color.fromRGBO(0, 0, 0, 0.6),
                                          Color.fromRGBO(0, 0, 0, 0.8),
                                        ],
                                        stops: [
                                          0.0,
                                          0.4,
                                          0.8,
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'John Wick',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(height: 3),
                                          Text(
                                            'Crime, Ação',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w300),
                                          )
                                        ]),
                                  ),
                                ])),
                      );
                    },
                  )),
            ],
          ),
        ));
  }
}
