import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_bloc_frontend/features/application/blocs/application_bloc.dart';
import 'package:restaurant_bloc_frontend/features/application/blocs/application_event.dart';
import 'package:restaurant_bloc_frontend/features/application/blocs/application_state.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, state) {
        return Container(
          color: Colors.white,
          child: SafeArea(
              child: Scaffold(
            body: state.pages[state.currentIndex],
            bottomNavigationBar: buildBottomNav(state, context),
          )),
        );
      },
    );
  }

  Widget buildBottomNav(ApplicationState state, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 58,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.2),
              spreadRadius: 1,
              blurRadius: 2)
        ],
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedLabelStyle: const TextStyle(fontSize: 12),
          selectedItemColor: Colors.black26,
          unselectedItemColor: Colors.black45,
          elevation: 0,
          currentIndex: state.currentIndex,
          onTap: (value) {
            context.read<ApplicationBloc>().add(TabChangedEvent(value));
          },
          items: buttonNavigateItem),
    );
  }

  var buttonNavigateItem = [
    const BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
    const BottomNavigationBarItem(label: 'Menu', icon: Icon(Icons.search)),
    const BottomNavigationBarItem(label: 'Orders', icon: Icon(Icons.sell)),
    const BottomNavigationBarItem(
        label: 'Favorite', icon: Icon(Icons.favorite)),
    const BottomNavigationBarItem(
        label: 'Profile', icon: Icon(Icons.person_outline)),
  ];
}
