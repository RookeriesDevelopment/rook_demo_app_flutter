import 'package:flutter/material.dart';
import 'package:rook_demo_flutter/features/connections_page/data/repository/default_data_source_repository.dart';
import 'package:rook_demo_flutter/features/connections_page/domain/model/data_source.dart';
import 'package:rook_demo_flutter/features/connections_page/widget/list_tile_data_source.dart';
import 'package:rook_demo_flutter/secrets.dart';
import 'package:webview_flutter/webview_flutter.dart';

const String connectionsPageRoute = '/connections-page';

class ConnectionsPageScreen extends StatefulWidget {
  final DefaultDataSourceRepository dataSourceRepository;

  const ConnectionsPageScreen({
    Key? key,
    required this.dataSourceRepository,
  }) : super(key: key);

  @override
  State<ConnectionsPageScreen> createState() => _ConnectionsPageScreenState();
}

class _ConnectionsPageScreenState extends State<ConnectionsPageScreen> {
  bool loading = false;
  List<DataSource> dataSources = [];
  WebViewController? webViewController;

  @override
  void initState() {
    getDataSources();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (webViewController != null) {
          if (await webViewController!.canGoBack()) {
            webViewController!.goBack();
          } else {
            closeConnectionUrl();
          }

          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Connections page'),
          leading: IconButton(
            onPressed: Navigator.of(context).pop,
            icon: const Icon(Icons.arrow_back_rounded),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: loading
                  ? const Center(child: CircularProgressIndicator())
                  : webViewController == null
                      ? ListView.builder(
                          itemCount: dataSources.length,
                          itemBuilder: (context, index) => ListTileDataSource(
                            dataSource: dataSources[index],
                            onClick: (url) => openConnectionUrl(url),
                          ),
                        )
                      : WebViewWidget(controller: webViewController!),
            ),
          ],
        ),
      ),
    );
  }

  void getDataSources() {
    setState(() {
      loading = true;
      dataSources = [];
    });

    widget.dataSourceRepository
        .getDataSources(Secrets.clientUUID, 'userID2')
        .then((value) {
      setState(() {
        loading = false;
        dataSources = value;
      });
    }).catchError((error) {
      setState(() {
        loading = false;
        dataSources = [];
      });
    });
  }

  void openConnectionUrl(String url) {
    setState(() {
      webViewController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(
          NavigationDelegate(
            onNavigationRequest: (NavigationRequest request) {
              if (isHomePageUrl(request.url)) {
                closeConnectionUrl();
                getDataSources();
              }

              return NavigationDecision.navigate;
            },
          ),
        )
        ..loadRequest(Uri.parse(url));
    });
  }

  void closeConnectionUrl() {
    setState(() {
      webViewController = null;
    });
  }

  bool isHomePageUrl(String url) {
    return url.startsWith('https://${Secrets.connectionsPageUrl}/');
  }
}
