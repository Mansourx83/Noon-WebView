import 'package:flutter/material.dart';
import 'package:test/mywebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WebView(),
    );
  }
}

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  late final WebViewController controller;
  @override
  void initState() {
    controller = WebViewController()
      ..loadRequest(
        Uri.parse(
          'https://www.noon.com/egypt-ar/eg-home-appliances/?utm_source=c1000087l&utm_medium=cpc&utm_campaign=C1000151427N_eg_ar_web_performancemaxxhomeappliancesxalwaysonx18082022_noon_web_c1000087l_remarketing_plassc_&gad_source=1&gclid=Cj0KCQjwgJyyBhCGARIsAK8LVLMReyEgg-nW49LVBR1jBEQ9A196ir4ayoETzew-80WHPia0FAQVBnoaAoFWEALw_wcB',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.png',
          height: 80,
          width: 60,
        ),
        backgroundColor: Color(0xffF3E000),
        actions: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (await controller.canGoBack()) {
                    await controller.goBack();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          'No Back History Found',
                        ),
                      ),
                    );
                    return;
                  }
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
              IconButton(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  if (await controller.canGoForward()) {
                    await controller.goForward();
                  } else {
                    messenger.showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          'No Forward History Found',
                        ),
                      ),
                    );
                    return;
                  }
                },
                icon: const Icon(Icons.arrow_forward_ios),
              ),
              IconButton(
                  onPressed: () {
                    controller.reload();
                  },
                  icon: const Icon(Icons.replay_outlined))
            ],
          )
        ],
      ),
      body: MyWebView(controller: controller),
    );
  }
}
