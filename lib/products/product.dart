import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/cubit.dart';
import 'package:shop/cubit/states.dart';
import 'package:shop/models/home_model.dart';


import '../models/category_model.dart';
import '../shared/components.dart';


class Product_Screen extends StatelessWidget {
  const Product_Screen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
      BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {
            if(state is ChangeFavoritesIconColorSucssesState){
              if(!state.model.status){
                ShowToust(Text: state.model.message, state: ToustStates.ERROR);
              }
            }
          },
          builder: (context, state)
    {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel!=null && ShopCubit.get(context).CategoryModel!=null,
          builder: ( context) =>ProductsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).CategoryModel,context),
          fallback: ( context) =>const Center(child:  CircularProgressIndicator()),
        );
    },
    );
  }
  Widget  ProductsBuilder(HomeModel? model,CategoriesModel? CategoriesModel ,context)=>SingleChildScrollView(
     physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(items:model!.data.banners.map((e) => Image(
            image: NetworkImage('${e.image}'),
            width: double.infinity,
          fit: BoxFit.cover,
        ),
        ).toList() , options: CarouselOptions(
          height: 250,
          initialPage: 0,
          viewportFraction: 1,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval:const Duration(seconds: 3),
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
          scrollDirection: Axis.horizontal
        )),
        const SizedBox(
          height: 10,
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              const Text('Categories',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
              ),
            ),
              Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => BuildCategoryitem(CategoriesModel!.data.data1[index],),
                    separatorBuilder:(context, index) =>const SizedBox(width: 10,),
                    itemCount: CategoriesModel!.data.data1.length),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text('Products',
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: GridView.count(
            shrinkWrap: true,
            physics:const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
                   mainAxisSpacing: 1,
                   crossAxisSpacing: 1,
                   childAspectRatio: 1/1.7,
                   children:
                     List.generate(model.data.products.length,
                           (index) =>GridViewBuilder(model.data.products[index],context)

                     ) ,

          ),
        ),

      ],
    ),
  );



  Widget  GridViewBuilder(ProductsModel? model ,context)=> Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Stack(alignment: Alignment.bottomLeft,
          children:[
            Image(image: NetworkImage('${model!.image}'),
              height: 200,
              width: double.infinity,
            ),
            if(model.discount!=0)
              Container(
                padding:const EdgeInsets.symmetric(
                    horizontal: 5
                ),
                color: Colors.red,
                child: const Text('DISCOUNT',
                  style: TextStyle(
                      color: Colors.white
                  ),),
              ),
          ]
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${model.name}',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            Row(
              children: [
                Text('${model.price}',
                  style: TextStyle(
                    color: DefaultColor,

                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (model.discount!=0)
                  Text('${model.oldPrice}',
                    style:const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough
                    ),
                  ),
                const Spacer(),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: ShopCubit.get(context).favoriets[ model.id]==true?Colors.red:Colors.grey,
                  child: IconButton(onPressed: (){
                    ShopCubit.get(context).ChangeFavIcon(model.id);
                  }, icon:const Icon(
                    Icons.favorite_border,
                    size:15,
                    color: Colors.white ,
                  )),
                )
              ],
            ),
          ],
        ),
      ),
    ],
  );
  Widget BuildCategoryitem(DataModel? model)=>Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      Image(
          image: NetworkImage('${model!.image}'),
      width: 100,
      height: 100,
      ),
      Container(
        width: 100,
        color: Colors.black.withOpacity(.6),
        height: 20,
        child: Text('${model.name}',
          textAlign:TextAlign.center ,
         style:const  TextStyle(
           color: Colors.white,
           overflow: TextOverflow.ellipsis,


         ),
        ),
      ),
    ],
  );

}
