import 'package:flutter/material.dart';

class CheckoutContent extends StatefulWidget {
  const CheckoutContent({super.key});

  @override
  State<CheckoutContent> createState() => _CheckoutContentState();
}

class _CheckoutContentState extends State<CheckoutContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * .2,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [_buildCheckoutTop(context), _buildCheckoutBottom()],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutBottom() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text('Total', style: Theme.of(context).textTheme.headlineMedium),
          const Text('\$2'),
        ],
      ),
    );
  }

  Widget _buildCheckoutTop(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Theme.of(context).shadowColor,
          width: 2,
        ),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sub Total',
                  style: Theme.of(context).textTheme.headlineMedium),
              Text(
                'Deliver',
                style: Theme.of(context).textTheme.labelMedium,
              )
            ],
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('\$100'),
              Text('\$2'),
            ],
          ),
        ],
      ),
    );
  }
}
