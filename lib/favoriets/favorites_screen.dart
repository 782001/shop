import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/all_login_cubit/login.dart';
import 'package:shop/models/favorites_model.dart';
import 'package:shop/network/local/cashhelper.dart';
import 'package:shop/shared/components.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';

class favoriets_screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:ShopCubit.get(context).favoritesModel != null,
          builder: (BuildContext context)=>ListView.separated(
              physics:const BouncingScrollPhysics(),
              itemBuilder: (context, index) => BuildFavItem(ShopCubit.get(context).favoritesModel!.data!.data2[index].product,context),
              separatorBuilder:  (context, index) => Container(height: 1,width: double.infinity,),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data2.length),
          fallback: (BuildContext context) =>const Center(child: const CircularProgressIndicator()),

        );
      },);


  }

}
