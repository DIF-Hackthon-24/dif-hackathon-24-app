import 'package:core/base_classes/base_view.dart';
import 'package:core/environment/environment_service_params.dart';
import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
import 'package:widget_library/environment/environement_select_widget.dart';
import 'package:widget_library/environment/state/environment_select_state.dart';
import 'package:widget_library/environment/view_model/environment_select_view_model.dart';
import 'package:widget_library/ps_scaffold.dart';

class _Constants {
  String titleIskan = 'DGCL - App';
  String titleAppVersion = 'App Version';
  String ctaTitle = 'Continue';
}

class EnvironmentSelectView extends StatelessWidget {
  final OnEnvironmentSelected onEnvironmentSelected;

  const EnvironmentSelectView({
    Key? key,
    required this.onEnvironmentSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<EnvironmentSelectViewModel, EnvironmentSelectState>(
      setupCoordinator: (coordinator) {
        coordinator.initialize(onEnvironmentSelected);
      },
      builder: (
          context,
          state,
          viewModel,
          ) =>
          buildWithStateViewModel(
            context,
            state,
            viewModel,
          ),
    );
  }

  Widget buildWithStateViewModel(
      BuildContext context,
      EnvironmentSelectState state,
      EnvironmentSelectViewModel viewModel,
      ) {
    return PSScaffold(
      extendedBodyClip: true,
      themeName: 'account',
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // EnvironmentOptionCheckbox(
                //   key: const Key('Environment_Selection_Disable_Cert_Pinning'),
                //   checkBoxKey: const Key('Environment_Selection_Check_box_1'),
                //   value: state.disableCertificatePinning,
                //   onChanged: (val) => viewModel.disableCertificatePinningStatus(val ?? false),
                //   title: 'Disable Certificate Pinning',
                // ),
                Expanded(
                  child: EnvironmentOptionCheckbox(
                    key: const Key('Environment_Selection_Mock_Login'),
                    checkBoxKey: const Key('Environment_Selection_Check_box_2'),
                    value: state.mockLogin,
                    onChanged: (val) => viewModel.mockLogin(val ?? false),
                    title: 'Automation Login',
                  ),
                ),
              ],
            ),
            EnvironmentSelectionView(
              titleIskan: _Constants().titleIskan,
              titleAppVersion: _Constants().titleAppVersion,
              appVersion: state.appVersion,
              ctaTitle: _Constants().ctaTitle,
              onSelect: (environment) {
                viewModel.onSelectEnvironment(
                  environment,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EnvironmentOptionCheckbox extends StatelessWidget {
  const EnvironmentOptionCheckbox({
    Key? key,
    required this.onChanged,
    required this.value,
    required this.title,
    required this.checkBoxKey,
  }) : super(key: key);

  final String title;
  final Function(bool?) onChanged;
  final bool value;
  final Key checkBoxKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Row(
        children: [
          PSText(
            text: TextUIDataModel(
              title,
              styleVariant: PSTextStyleVariant.hints,
            ),
          ),
          Checkbox(
            key: checkBoxKey,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
