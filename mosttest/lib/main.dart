import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mosttest/api/liveness.dart';
import 'package:mosttest/fragments/gravacao.dart';
import 'package:mosttest/fragments/resultado.dart';
import 'package:mosttest/store/mainStore.dart';
import 'package:mosttest/widgets/cameraWidget.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "lib/env/secrets.env");
  GetIt.I.registerLazySingleton(() => MainStore());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Complemento - Câmera'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final store = GetIt.I<MainStore>();
  final PageController _pageController = PageController();
  bool showButton = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: Card(
                      surfaceTintColor: Colors.transparent,
                      elevation: 5,
                      child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: PageView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _pageController,
                            children: [GravacaoPage(), const ResultadoPage()],
                          ))),
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (showButton == true)
                          ? Observer(
                              builder: (_) => TextButton.icon(
                                icon: const Icon(Icons.arrow_forward),
                                style: TextButton.styleFrom(
                                  disabledForegroundColor: Colors.grey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: store.xFile == null
                                    ? null
                                    : () {
                                        _pageController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeIn);
                                        store.validarLivelinessAction();
                                        setState(() {
                                          showButton = false;
                                        });
                                      },
                                label: const Text('Avançar'),
                              ),
                            )
                          : Container()
                    ]),
              ],
            ),
          ),
        ));
  }
}
