import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/core/constants/vectors.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';
import 'package:restaurant_bloc_frontend/features/splash/presentation/blocs/splash_bloc.dart';
import 'package:restaurant_bloc_frontend/features/splash/presentation/blocs/splash_event.dart';
import 'package:restaurant_bloc_frontend/features/splash/presentation/blocs/splash_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().stream.listen((state) {
      _pageController.animateToPage(
        state.currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<SplashBloc, SplashState>(
              builder: (context, state) {
                return PageView.builder(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return _buildPageContent(index, context, state.currentPage);
                  },
                );
              },
            ),
          ),
          BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) => _buildDots(state.currentPage),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildPageContent(int index, BuildContext context, int currentPage) {
    final titles = [
      'Taste the Delivery Service',
      'Fast & Reliable Orders',
      'Enjoy Every Meal',
    ];

    final subtitles = [
      'Order now and enjoy the best delivery service',
      'Your food delivered hot & on time',
      'Delicious dishes at your fingertips',
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Vectors.orderSuccess,
          height: 300,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                titles[index],
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                subtitles[index],
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              AuthButton(
                text: 'Get Started',
                onTap: () {
                  if (currentPage < 2) {
                    context
                        .read<SplashBloc>()
                        .add(ChangePageEvent(currentPage + 1));
                  } else {
                    Navigator.pushReplacementNamed(context, '/wrapper');
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDots(int currentPage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        final isActive = currentPage == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: isActive ? 16 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? Colors.deepOrange : Colors.grey.shade400,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
