import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/new_app/cubit/states.dart';
import 'package:news_app/network/local/cach_helper.dart';
 
 

class ModeCubit extends Cubit<NewsStates>
{
  ModeCubit() : super(NewsInitialState());

  static ModeCubit get(context) => BlocProvider.of(context);
   bool isDark = false;
    void changeAppMode({bool fromShared})
    {
      if(fromShared !=null)
      {
            isDark=fromShared;
                            emit(NewsChangeModeState());

      
      }
       else{
      isDark=!isDark;
      CacheHelper.putBoolean(key: 'isDark',value: isDark).then((value)
      { 
                emit(NewsChangeModeState());
      });
       
    }
}
}