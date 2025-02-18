import 'package:aba_payment/models/models.dart';
import 'package:aba_payment/services/strings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ABACheckoutWebView extends StatefulWidget {
  final ABAMerchant merchant;
  final Uri? uri;

  const ABACheckoutWebView({Key? key, this.uri, required this.merchant})
      : super(key: key);
  @override
  _ABACheckoutWebViewState createState() => _ABACheckoutWebViewState();
}

class _ABACheckoutWebViewState extends State<ABACheckoutWebView> {
  final GlobalKey webViewKey = GlobalKey();
  late InAppWebViewController webViewController;

  PullToRefreshController? pullToRefreshController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.checkoutLabel.toUpperCase()),
        centerTitle: true,
      ),
      body: InAppWebView(
        pullToRefreshController: pullToRefreshController,
        onWebViewCreated: (controller) {
          webViewController = controller;
          final Map<String, String> headers =
              kIsWeb ? {} : {"Referer": widget.merchant.refererDomain!};
          webViewController.loadUrl(
            urlRequest: URLRequest(url: widget.uri!, headers: headers),
          );
        },
      ),
    );
  }
}
