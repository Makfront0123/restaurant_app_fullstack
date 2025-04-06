import 'package:flutter/material.dart';
import 'package:restaurant_bloc_frontend/features/auth/presentation/widgets/auth_button.dart';

class ScreenEmpty extends StatefulWidget {
  const ScreenEmpty({super.key, required this.emptyImage, required this.title});
  final String emptyImage;
  final String title;

  @override
  State<ScreenEmpty> createState() => _ScreenEmptyState();
}

class _ScreenEmptyState extends State<ScreenEmpty> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                height: MediaQuery.of(context).size.height * .65,
                width: MediaQuery.of(context).size.width * .9,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(widget.emptyImage),
                      const SizedBox(height: 30),
                      Text(widget.title,
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 1,
                          textAlign: TextAlign.center),
                      const SizedBox(height: 20),
                      Text(
                        'Absolute love your food, the flavvors were so vibrant and the food was so delicious',
                        style: Theme.of(context).textTheme.labelLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )),
            AuthButton(
              onTap: () {},
              text: 'Explore our Menu',
            )
          ],
        ),
      ),
    );
  }
}
