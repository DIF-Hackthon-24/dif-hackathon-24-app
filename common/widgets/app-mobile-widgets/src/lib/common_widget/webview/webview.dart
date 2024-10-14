import 'dart:convert';

import 'package:core/navigation/navigation_manager.dart';
import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:widget_library/common_widget/page_header/text_ui_data_model.dart';
import 'package:widget_library/common_widget/static_text/PSText.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

enum LaunchType {
  Static,
  Network,
}

enum HandlerType {
  onPageStart,
  onPageFinish,
  onProgress,
  onWebViewCreated,
}

class WebViewPage extends StatefulWidget {
  final TextUIDataModel title;
  final String? url;
  final String? body;
  final Function({HandlerType? handlerType, dynamic params})? handler;
  final LaunchType launchType;
  final Icon? leadingActionIcon;
  final Icon? trailingActionIcon;
  final Function? onLeadingActionClick;
  final Function? onTrailingActionClick;
  final Color? backgroundColor;
  final bool closeOnCompletion;
  // final List<JavascriptChannel>? javascriptChannels;

  const WebViewPage({
    Key? key,
    required this.title,
    this.url,
    this.body,
    this.handler,
    required this.launchType,
    this.leadingActionIcon,
    this.trailingActionIcon,
    this.onLeadingActionClick,
    this.onTrailingActionClick,
    this.backgroundColor,
    // this.javascriptChannels,
    this.closeOnCompletion = false,
  }) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            widget.handler?.call(handlerType: HandlerType.onProgress);
          },
          onPageStarted: (String url) {
            widget.handler?.call(handlerType: HandlerType.onPageStart);
          },
          onPageFinished: (String url) {
            widget.handler?.call(handlerType: HandlerType.onPageFinish);
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(
              '''
                Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
              ''',
            );
          },
          onNavigationRequest: (NavigationRequest request) {
            /* if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate; */
            return NavigationDecision.prevent;
          },
          onUrlChange: (UrlChange change) {
            debugPrint('url change to ${change.url}');
          },
          onHttpAuthRequest: (HttpAuthRequest request) {
            //openDialog(request);
          },
        ),
      )
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      );

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
    _loadOutput();
  }

  Future _loadOutputFromStaticFileUrl(
    String url,
  ) async {
    final dataInFile = await rootBundle.loadString(url);
    final contentBase64 = base64Encode(const Utf8Encoder().convert(dataInFile));
    await _controller
        .loadRequest(Uri.parse('data:text/html;base64,$contentBase64'));
  }

  void _loadOutput() {
    switch (widget.launchType) {
      case LaunchType.Static:
        if (widget.url.isBlank()) {
          final contentBase64 = base64Encode(const Utf8Encoder().convert(widget.body!));
          _controller.loadRequest(
            Uri.parse('data:text/html;base64,$contentBase64'),
          );
        } else {
          _loadOutputFromStaticFileUrl(widget.url!);
        }

        break;

      case LaunchType.Network:
        _controller.loadRequest(
          Uri.parse(widget.url!),
        );
        break;

      default:
        throw UnimplementedError('Missing Launch Type');
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    return Scaffold(
      key: Key('WebView_Scaffold'),
      appBar: WebViewAppBar(),
      body: WebViewWidget(
        key: Key('WebView'),
        controller: _controller,
        /* javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          controller = webViewController;
          _loadOutput(controller);
          widget.handler?.call(handlerType: HandlerType.onWebViewCreated, params: webViewController);
        },
        onProgress: (int progress) {
          widget.handler?.call(handlerType: HandlerType.onProgress);
        },
        javascriptChannels: widget.javascriptChannels?.toSet(),
        navigationDelegate: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
        onPageStarted: (String url) {
          widget.handler?.call(handlerType: HandlerType.onPageStart);
        },
        onPageFinished: (String url) {
          widget.handler?.call(handlerType: HandlerType.onPageFinish);
        },
        gestureNavigationEnabled: true, */
      ),
    );
  }

  PreferredSizeWidget WebViewAppBar() {
    return AppBar(
      key: Key('PreferredSizeWidget_AppBar'),
      actions: widget.trailingActionIcon != null
          ? [
              IconButton(
                key: Key('PreferredSizeWidget_IconButton'),
                icon: widget.trailingActionIcon!,
                onPressed: () {
                  handleOnTrailingIconPress();
                },
              ),
            ]
          : null,
      leading: widget.leadingActionIcon != null
          ? IconButton(
              key: Key('PreferredSizeWidgetLeading_IconButton'),
              icon: widget.leadingActionIcon!,
              onPressed: () {
                handleOnLeadingIconPress();
              },
            )
          : Container(key: Key('PreferredSizeWidget_NullContainer')),
      elevation: 0,
      backgroundColor: widget.backgroundColor ?? Color(0xFFF7F7F4),
      centerTitle: true,
      title: PSText(
        text: TextUIDataModel(
          widget.title.text,
          styleVariant: PSTextStyleVariant.subtitle2,
        ),
        key: Key('PreferredSizeWidget_titleText'),
      ),
    );
  }

  void handleOnLeadingIconPress() {
    if (widget.onLeadingActionClick != null) {
      widget.onLeadingActionClick!();
    } else {
      NavigationManager.goBack();
    }
  }

  void handleOnTrailingIconPress() {
    if (widget.onTrailingActionClick != null) {
      widget.onTrailingActionClick!();
    } else {
      NavigationManager.goBack();
    }
  }
}
