import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/cubit.dart';
import 'package:shop/cubit/states.dart';

import '../models/category_model.dart';

class category_screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<ShopCubit,ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ListView.separated(
            physics:const BouncingScrollPhysics(),
              itemBuilder: (context, index) => BuildCatItem(ShopCubit.get(context).CategoryModel!.data.data1[index]),
              separatorBuilder:  (context, index) => Container(height: 1,width: double.infinity,),
              itemCount: ShopCubit.get(context).CategoryModel!.data.data1.length);
    },);



  }
  Widget BuildCatItem(DataModel model)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          height: 100,
          width: 100,
        ),
      const  SizedBox(width: 20,),
        Text('${model.name}',
          style:const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
          ),),
       const Spacer(),
       const Icon(Icons.arrow_forward_ios),
      ],
    ),
  );
}
