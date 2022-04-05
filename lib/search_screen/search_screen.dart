import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/search_screen/search_cubit/search_cubit.dart';
import 'package:shop/search_screen/search_cubit/search_states.dart';

import '../shared/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textSearchController=TextEditingController();
    return BlocProvider(
      create: (BuildContext context) =>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultFormField(
                    validate:  (String? value){
                      if(value!.isEmpty){
                        return 'please enter any words';
                      }
                    },

                    onSubmit:(String? text){
                      SearchCubit.get(context).Search(text);
                    } ,
                    type: TextInputType.text,
                    controller: textSearchController,
                    label: 'Search',
                    prefix: Icons.search,
                  ),
                 const SizedBox(height: 10,),
                  if(state is SearchLodingState)
                    const LinearProgressIndicator(),
                  if(state is SearchSucssesState)
                  Expanded(
                    child: ListView.separated(
                        physics:const BouncingScrollPhysics(),
                        itemBuilder: (context, index) =>
                            BuildListProductItem(SearchCubit.get(context).model!.data!.data2[index],isOldPrice: false),
                        separatorBuilder:  (context, index) => Container(height: 1,width: double.infinity,),
                        itemCount: SearchCubit.get(context).model!.data!.data2.length),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
