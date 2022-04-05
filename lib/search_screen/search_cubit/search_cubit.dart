

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/end_points/end_point.dart';
import 'package:shop/network/remote/dio_helper.dart';
import 'package:shop/search_screen/search_cubit/search_states.dart';

import '../../models/search_model.dart';
import '../../shared/components.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());
  static SearchCubit  get(context)=>BlocProvider.of(context);

  SearchModel? model;
  void Search( String? Text){
    emit(SearchLodingState());
    DioHelper.Postdata(
        url: SEARCH,
        data: {
      'text':Text,
    },
      token: token,
    ).then((value) {
      model=SearchModel.Fromjson(value.data);
      emit(SearchSucssesState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}