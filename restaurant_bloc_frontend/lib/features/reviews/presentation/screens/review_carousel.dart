import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_bloc_frontend/core/constants/images.dart';
import 'package:restaurant_bloc_frontend/core/theme/app_colors.dart';

import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_container.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/star_review.dart';

import 'package:restaurant_bloc_frontend/features/reviews/domain/entities/reviews_item.dart';
import 'package:restaurant_bloc_frontend/features/reviews/presentation/blocs/reviews_bloc.dart';
import 'package:restaurant_bloc_frontend/features/reviews/presentation/blocs/reviews_event.dart';
import 'package:restaurant_bloc_frontend/features/reviews/presentation/blocs/reviews_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewCarousel extends StatefulWidget {
  const ReviewCarousel({super.key});

  @override
  State<ReviewCarousel> createState() => _ReviewCarouselState();
}

class _ReviewCarouselState extends State<ReviewCarousel> {
  @override
  void initState() {
    super.initState();
    loadReviews();
  }

  void loadReviews() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token') ?? '';
    context.read<ReviewsBloc>().add(LoadReviewsEvent(token: token));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewsBloc, ReviewState>(
      builder: (context, state) {
        if (state is ReviewLoadingState) {
          return const CircularProgressIndicator();
        } else if (state is ReviewLoadedState) {
          if (state.reviews.isEmpty) {
            return const SizedBox(
                height: 100,
                width: double.infinity,
                child: Center(child: Text("No reviews available")));
          } else {
            return _buildReviewList(context, state.reviews);
          }
        } else if (state is ReviewErrorState) {
          print('Reviews error: ${state.error}');
          return const Center(
            child: Text('Failed to load reviews.'),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildReviewList(BuildContext context, List<Review> reviews) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        scrollDirection: Axis.horizontal,
        itemCount: reviews.length,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        itemBuilder: (context, index) => _buildReviewCard(reviews, index),
      ),
    );
  }

  Widget _buildReviewCard(List<Review> reviews, int index) {
    final queryW = MediaQuery.of(context).size.width;
    final queryH = MediaQuery.of(context).size.height;

    final date = DateFormat('yyyy-MM-dd').format(reviews[index].date);

    return HomeContainer(
      height: queryH * .1,
      width: queryW * .9,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppColors.secondaryVariant)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                          reviews[index].imageUser.isNotEmpty
                              ? reviews[index].imageUser
                              : Images.user,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(reviews[index].author),
                          const StarReview(),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    date,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              reviews[index].comment,
              style:
                  const TextStyle(fontSize: 13, color: AppColors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}
