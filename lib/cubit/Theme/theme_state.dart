part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {
  final bool darkMode;
  const ThemeState(this.darkMode);
}

class ThemeInitial extends ThemeState {
   ThemeInitial() : super(Preferenes.isDarkMode);
}

class SetThemeState extends ThemeState{
  const SetThemeState(bool darkMode) : super(darkMode);

}
