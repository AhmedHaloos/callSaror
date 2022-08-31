

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:sarorcall/pages/SplashScreen.dart';
import 'package:sarorcall/redux/store.dart';

import '../redux/actions.dart';
import '../redux/reducers.dart';

class _InheritedStateContainer extends InheritedWidget{
     Store<AppState>  store;

  _InheritedStateContainer({required this.store, required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

}
class StateContainerWidget extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => StateContainerState();

  static Store<AppState>  of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<_InheritedStateContainer>())!.store;

  }
}

class StateContainerState extends State<StateContainerWidget>{

  Store<AppState> appStore = MyAppStore().store;
  @override
  Widget build(BuildContext context) {
    return (
        _InheritedStateContainer(
            store: appStore,
            child: MaterialApp(title: "PaliState", home: SplashScreen()),
        )

    );
  }

}


