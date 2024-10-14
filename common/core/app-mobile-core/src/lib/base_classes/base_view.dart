import 'package:core/base_classes/base_coordinator.dart';
import 'package:core/base_classes/ps_widgets_binding_observer.dart';
import 'package:core/ioc/di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BaseView<T extends BaseCoordinator<S>, S> extends ConsumerStatefulWidget {
  BaseView({
    required this.setupCoordinator,
    required this.builder,
  });

  final Widget Function(BuildContext context, S state, T viewModel) builder;
  final Function(T) setupCoordinator;

  @override
  _BaseViewState<T, S> createState() => _BaseViewState<T, S>();
}

class _BaseViewState<T extends BaseCoordinator<S>, S> extends ConsumerState<BaseView<T, S>>
    with WidgetsBindingObserver {
  late T _coordinator;
  late AutoDisposeStateNotifierProvider<T, S> _myNotifierProvider;

  @override
  void initState() {
    _coordinator = DIContainer.container<T>();
    widget.setupCoordinator(_coordinator);
    _myNotifierProvider = StateNotifierProvider.autoDispose<T, S>((ref) {
      return _coordinator;
    });
    super.initState();
    if (_coordinator is PSWidgetsBindingObserver) {
      WidgetsBinding.instance.addObserver(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      key: Key('BaseView_Consumer'),
      builder: (context, watch, child) {
        final state = ref.watch<S>(_myNotifierProvider);
        // final viewmodel = ref.watch(_myNotifierProvider.notifier);
        return widget.builder(context, state, _coordinator);
      },
    );
  }

  @override
  void dispose() {
    if (_coordinator is PSWidgetsBindingObserver) {
      WidgetsBinding.instance.removeObserver(this);
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    final listener = _coordinator as PSWidgetsBindingObserver?;
    listener?.psDidChangeAppLifecycleState(state);
  }
}
