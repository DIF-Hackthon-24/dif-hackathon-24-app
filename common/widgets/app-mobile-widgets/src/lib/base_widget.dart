import 'package:core/base_bloc_components/base_bloc.dart';
import 'package:core/base_bloc_components/base_bloc_event.dart';
import 'package:core/base_bloc_components/base_bloc_primary_state.dart';
import 'package:flutter/material.dart';

///This base widget is used in combination with the [BaseBloc]
abstract class BaseWidget extends StatefulWidget {
  final BaseBloc Function() getBloc;

  BaseWidget(this.getBloc, {Key? key}) : super(key: key);
}

abstract class BaseState<Page extends BaseWidget, T extends BaseBloc> extends State<Page> {
  ///this variable can be used by the subclass to emit events to the bloc
  ///emitted events must be a [BaseBlocEvent]subClass
  ///these events will then be executed in the [onUiDataChange(event)] within the bloc
  late T bloc;

  NavigatorState get navigator => Navigator.of(context);

  @override
  void initState() {
    bloc = widget.getBloc() as T;
    bloc.baseState.listen(onBlocStateChanged);
    super.initState();
  }

  ///any sinkState event emitted by the [BaseBloc] will be executed here
  @mustCallSuper
  void onBlocStateChanged(BaseBlocPrimaryState smartState) => smartState(context);

  @protected
  @mustCallSuper
  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
