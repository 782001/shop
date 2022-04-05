import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/all_login_cubit/login.dart';
import 'package:shop/network/local/cashhelper.dart';
import 'package:shop/shared/components.dart';

import '../all_login_cubit/login_cubit/login_cubit.dart';
import '../all_register_screen/register_cubit/register_cubit.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../search_screen/search_cubit/search_cubit.dart';
import '../search_screen/search_screen.dart';

class HomeLayOut extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ShopCubit()..GetHomeDAta()..GetHomeCategories()..GetHomeFavorite()..GetUserData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit=ShopCubit.get(context);
          return Scaffold(
          appBar: AppBar(
          title: Text('Salla',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            actions: [
              IconButton(
              onPressed: () { NavTo(context, SearchScreen()); },
                icon: const Icon(Icons.search),
              ),
            ],
            ),
          body:cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
             cubit.changeBottomNAv(index);
            },
            currentIndex: cubit.currentIndex,
            items: const[
              BottomNavigationBarItem(icon: Icon(Icons.home),
              label: 'products'),
            BottomNavigationBarItem(icon: Icon(Icons.apps),
              label: 'category'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),
              label: 'favorite'),
            BottomNavigationBarItem(icon: Icon(Icons.settings),
              label: 'settings'),
            ],
          ),

    );
    }
        ),
      );

  }
}
