import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:widget_library/common_widget/image/image_widget.dart';

class _Constants {
  static const double textPadding = 39.0;
  static const double errorIconSize = 38.0;
  static const double downloadErrorSpaceHeight = 15.0;
  static const double uploadIconSize = 32.0;
  static const double editIconSize = 20.0;
  static const double viewHeight = 311;
  static const double imageSize = 271;
  static const double borderRadius = 10.0;
  static const double viewPadding = 20.0;
  static const double spaceHeight = 22.0;
  static const errorImage = 'ERROR_IMAGE';
}

class OrganizationLogoView extends StatelessWidget {
  OrganizationLogoView({
    this.iconPath,
    this.placeholderText,
    this.localFilePath,
    this.imageUrl,
    this.onTap,
    super.key,
  });

  final String? iconPath;
  final String? placeholderText;
  final String? localFilePath;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          border: Border.all(color: Theme.of(context).colorScheme.background),
          borderRadius: BorderRadius.all(
            Radius.circular(_Constants.borderRadius),
          ),
        ),
        height: _Constants.viewHeight,
        child: _buildLogoView(context),
      ),
    );
  }

  Widget _buildLogoView(BuildContext context) {
    if (localFilePath != null && localFilePath!.isNotEmpty) {
      return _buildLogoImageView(_getOrganizationImageLocally());
    } else if (imageUrl != null && imageUrl!.isNotEmpty) {
      if (imageUrl == _Constants.errorImage) {
        return _downloadLogoErrorView(context);
      }
      return _buildLogoImageView(_getOrganizationImageView());
    }
    return _buildDefaultLogoView(context);
  }

  Widget _buildLogoImageView(Widget child) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: <Widget>[
        child,
        Positioned(
          child: IconButton(
            onPressed: onTap,
            /* icon: getSvg(
              iconPath!,
              width: _Constants.editIconSize,
              height: _Constants.editIconSize,
            ), */
            icon: PSImage(
              PSImageModel(
                iconPath: iconPath!,
                width: _Constants.editIconSize,
                height: _Constants.editIconSize,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _getOrganizationImageLocally() {
    final _imageSize = _Constants.imageSize;
    return Padding(
      padding: const EdgeInsets.all(_Constants.viewPadding),
      child: Center(
        child: ClipOval(
          child: Image.file(
            File(localFilePath!),
            fit: BoxFit.cover,
            width: _imageSize,
            height: _imageSize,
          ),
        ),
      ),
    );
  }

  GestureDetector _buildDefaultLogoView(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: _Constants.textPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /* getSvg(
                iconPath!,
                width: _Constants.uploadIconSize,
                height: _Constants.uploadIconSize,
              ), */
              PSImage(
                PSImageModel(
                  iconPath: iconPath!,
                  width: _Constants.uploadIconSize,
                  height: _Constants.uploadIconSize,
                ),
              ),
              SizedBox(
                height: _Constants.spaceHeight,
              ),
              Text(
                placeholderText!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getOrganizationImageView() {
    return Padding(
      padding: const EdgeInsets.all(_Constants.viewPadding),
      child: Center(
        child: ClipOval(
          child: Image.memory(
            base64Decode(imageUrl!),
            fit: BoxFit.cover,
            width: _Constants.imageSize,
            height: _Constants.imageSize,
          ),
        ),
      ),
    );
  }

  Widget _downloadLogoErrorView(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      padding: EdgeInsets.symmetric(horizontal: _Constants.textPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /* getSvg(
            iconPath!,
            width: _Constants.errorIconSize,
            height: _Constants.errorIconSize,
          ), */
          PSImage(
            PSImageModel(
              iconPath: iconPath!,
              width: _Constants.errorIconSize,
              height: _Constants.errorIconSize,
            ),
          ),
          SizedBox(
            height: _Constants.downloadErrorSpaceHeight,
          ),
          Text(
            placeholderText!,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
