import 'dart:async';

import 'package:flutter/widgets.dart';

import '../analytics/i_analytics.dart';
import 'base_bloc_event.dart';
import 'base_bloc_primary_state.dart';
import 'base_bloc_secondary_state.dart';

///The bloc holds the state of the widget
///listens [BaseWidget]SubClass's events
///emits states to the widget
abstract class BaseBloc {
  final IAnalytics? analytics;
  final _eventController = StreamController<BaseBlocEvent>();
  final _stateController = StreamController<BaseBlocPrimaryState>();

  BaseBloc(this.analytics) {
    _eventController.stream.listen((event) {
      onUiDataChange(event);
      if (event.analyticEventName.isNotEmpty) {
        analytics?.logEvent(event.analyticEventName.toLowerCase());
      }
    });
  }

  ///You can listen to [streams] from the [BaseWidget]subClass within a [StreamBuilder]
  final List<Stream> _secondaryStreams = <Stream>[];

  ///Events emitted by the widget bloc.event.add(BaseBlocEvent(data)) will be captured here
  void onUiDataChange(BaseBlocEvent event);

  ///used by the [BaseWidget] to listen to the bloc [BaseBlocPrimaryState] states
  Stream<BaseBlocPrimaryState> get baseState => _stateController.stream;

  ///used by the [BaseWidget] add [BaseBlocEvent]s
  /// [BaseBlocEvent] must be extended
  Sink<BaseBlocEvent> get event => _eventController.sink;

  Sink<BaseBlocPrimaryState> get sinkState {
    return _stateController.sink;
  }

  ///Use this to listen events emitted by the [BaseBloc]
  Stream getStreamOfType<T extends BaseBlocDataState>() =>
      _secondaryStreams.singleWhere((element) => element is Stream<T>, orElse: () => throw ArgumentError());

  ///Adds streams that extend [BaseBlocDataState] to _secondaryStreams
  ///You can listen to them from the widget side within a [StreamBuilder]
  ///get the reference stream using bloc.getStreamOfType<BaseBlocDataStateSubClass>() method
  void addSecondaryStreams(List<Stream> streams) => _secondaryStreams.addAll(streams);

  void logEvent(String name, {Map<String, dynamic>? properties}) => analytics?.logEvent(name, properties ?? {});

  @mustCallSuper
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}