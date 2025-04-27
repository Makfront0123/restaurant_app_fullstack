import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_bloc_frontend/core/theme/app_colors.dart';

import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/home_container.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/widgets/star_review.dart';

import 'package:restaurant_bloc_frontend/features/reviews/domain/entities/reviews_item.dart';
import 'package:restaurant_bloc_frontend/features/reviews/presentation/blocs/reviews_bloc.dart';
import 'package:restaurant_bloc_frontend/features/reviews/presentation/blocs/reviews_event.dart';
import 'package:restaurant_bloc_frontend/features/reviews/presentation/blocs/reviews_state.dart';

class ReviewCarousel extends StatefulWidget {
  const ReviewCarousel({super.key});

  @override
  State<ReviewCarousel> createState() => _ReviewCarouselState();
}

class _ReviewCarouselState extends State<ReviewCarousel> {
  @override
  void initState() {
    super.initState();
    context.read<ReviewsBloc>().add(LoadReviewsEvent());
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
      width: queryW * .8,
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          backgroundImage:
                              AssetImage(reviews[index].imageUser)),
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
                  Text(date),
                ],
              ),
            ),
            Text(
              reviews[index].review,
              style:
                  const TextStyle(fontSize: 13, color: AppColors.textTertiary),
            ),
          ],
        ),
      ),
    );
  }
}
