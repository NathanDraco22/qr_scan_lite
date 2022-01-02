import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:qr_lite/database/shared_preferences/preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super( ThemeInitial() );


  void setDarkMode(bool isDark ){

    Preferenes.isDarkMode = isDark;

    emit(SetThemeState(isDark));

  }

}
