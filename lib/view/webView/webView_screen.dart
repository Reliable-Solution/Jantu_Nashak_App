
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../controller/webView/webViewController.dart';
import '../../utils/string_res.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen({super.key, required this.url});

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late final WebViewControllerX controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(WebViewControllerX(widget.url));

  }

  Future<void> _onRefresh() async {
    controller.reload();
    // Wait for the page to start loading to ensure the refresh indicator hides
    await Future.delayed(const Duration(milliseconds: 500));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(StringRes.webView),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.reload,
            tooltip: StringRes.reload,
          ),
        ],
      ),
      body: RefreshIndicator(
    onRefresh: controller.reload,
        child: Stack(
          children: [
            WebViewWidget(controller: controller.webViewController),
            Obx(() => controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}