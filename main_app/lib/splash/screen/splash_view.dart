import 'package:core/base_classes/base_view.dart';
import 'package:flutter/material.dart';
import 'package:main_app/splash/coordinator/splash_coordinator.dart';
import 'package:main_app/splash/state/splash_view_state.dart';
import 'package:widget_library/common_widget/app_bars/ps_appbar.dart';
import 'package:widget_library/ps_scaffold.dart';
import 'package:main_app/route/global_route_manager.dart';


final _formKey = GlobalKey<FormState>();


class SplashView extends StatelessWidget {
  final bool mockLogin;

  const SplashView({
    this.mockLogin = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashCoordinator, SplashViewState>(
      setupCoordinator: (coordinator) {
        coordinator.initialize(mockLogin);
      },
      builder: (
        context,
        state,
        viewModel,
      ) =>
          buildWithState(
        context,
        state,
        viewModel,
      ),
    );
  }

  Widget buildWithState(
    BuildContext context,
    SplashViewState state,
    SplashCoordinator coordinator,
  ) {
    return PSScaffold(
      appBarAttributes: PSAppBarAttributes(title: "Hackathon",
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Center(
          child:   Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  coordinator.navigateToWalletCredentialExchange();
                },
                child: const Text('Wallet QR Code Scanner'),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: (){
                  coordinator.navigateToWalletList();
                },
                child: const Text('Wallet Credentials'),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  coordinator.navigateToPermissionRequest();
                },
                child: const Text('Go to Permission Request'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
