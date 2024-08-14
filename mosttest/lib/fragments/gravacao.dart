import 'package:flutter/material.dart';
import 'package:mosttest/widgets/cameraWidget.dart';
import 'package:mosttest/store/mainStore.dart';
import 'package:get_it/get_it.dart';

class GravacaoPage extends StatelessWidget {
  final store = GetIt.I<MainStore>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Quando estiver pronto(a), clique no botão para gravar.",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(
          height: 8,
        ),
        CameraWidget(
          width: 250,
          onVideoRecorded: (p0) {
            store.setXFile(p0);
          },
        ),
      ],
    );
  }
}
