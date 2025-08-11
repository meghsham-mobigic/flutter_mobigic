import 'package:flutter_mobigic/async_redux/model/app_state.dart';
import 'package:flutter_mobigic/async_redux/redux/actions.dart';

AppState reducer(AppState currentAppState, dynamic action) {
  AppState newAppState = AppState.fromPreviousAppState(currentAppState);
  // creating the copy of old app state

  if (action is FontSize) {
    newAppState.sliderFontSize = action.payload;
  } else if (action is Bold) {
    newAppState.bold = action.payload;
  } else if (action is Italic) {
    newAppState.italic = action.payload;
  }
  return newAppState;
}
