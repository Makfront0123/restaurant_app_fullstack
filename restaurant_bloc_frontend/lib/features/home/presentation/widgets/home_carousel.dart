import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/domain/entities/carousel_item.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_bloc.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_event.dart';
import 'package:restaurant_bloc_frontend/features/home/presentation/blocs/home_state.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    context.read<HomeBloc>().add(LoadHomeData());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final queryW = MediaQuery.of(context).size.width;
    final queryH = MediaQuery.of(context).size.height;
    final pageController = PageController();
    final homeBloc = context.read<HomeBloc>();
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        } else if (state is HomeLoaded) {
          return Column(
            children: [
              Stack(children: [
                _carouselSlider(
                    state.images, pageController, homeBloc, queryH, queryW),
                Positioned(
                  bottom: 10,
                  left: 150,
                  child: _dotsIndicator(state.images.length, state.currentPage),
                )
              ]),
            ],
          );
        }

        return const Center(child: Text('Estado no reconocido'));
      },
    );
  }

  Widget _carouselSlider(List<CarouselItem> images,
      PageController pageController, HomeBloc homeBloc, queryH, queryW) {
    return Center(
      child: SizedBox(
        height: queryH * .2,
        width: queryW,
        child: PageView.builder(
          controller: pageController,
          itemCount: images.length,
          onPageChanged: (index) {
            homeBloc.add(CarouselPageChanged(index));
          },
          itemBuilder: (context, index) {
            return Image.asset(
              images[index].image,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }

  Widget _dotsIndicator(int itemCount, int currentPage) {
    return Row(
        children: List.generate(itemCount, (index) {
      return Container(
        width: 10,
        height: 10,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: currentPage == index ? const Color(0xFFffffff) : Colors.grey,
        ),
      );
    }));
  }
}
