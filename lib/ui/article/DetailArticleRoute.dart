import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class DetailArticleRoute extends StatefulWidget{
   const DetailArticleRoute({Key? key,required this.url}) : super(key: key);
  final String url;
  @override
  _DetailArticleRoute createState() {
    return _DetailArticleRoute();
  }
}
class _DetailArticleRoute extends State<DetailArticleRoute>{
   late WebViewController _webViewController;
   late PlatformWebViewWidgetCreationParams params;
  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
    NavigationDelegate(
    onProgress: (int progress) {

    },
    onPageStarted: (String url) {},
    onPageFinished: (String url) {},
    onWebResourceError: (WebResourceError error) {},
    ),
    )
    ..loadRequest(Uri.parse(widget.url));
   params = PlatformWebViewWidgetCreationParams(
      controller: _webViewController.platform,
       layoutDirection: TextDirection.ltr,
      gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
     );

     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
       params = WebKitWebViewWidgetCreationParams
           .fromPlatformWebViewWidgetCreationParams(
         params,
       );
     } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
       params = AndroidWebViewWidgetCreationParams
           .fromPlatformWebViewWidgetCreationParams(
         params,
       );
     }

  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(

      ),
      body: WebViewWidget(controller: _webViewController,)
    );
  }

}