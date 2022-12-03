import 'dart:io';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:kitchenly/model/model.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/api.dart';

class WebviewPage extends StatefulWidget {
  final String source_url;
  const WebviewPage({super.key, required this.source_url});

  @override
  State<WebviewPage> createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  late Future<RecipesModel> recipesData;
  @override
  void initState() {
    recipesData = ApiService.getRecipeData(widget.source_url);
    print(widget.source_url);
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: WebView(
          initialUrl: widget.source_url,
        ));
  }
}
