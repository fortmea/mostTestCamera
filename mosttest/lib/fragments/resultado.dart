import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:mosttest/store/mainStore.dart';

class ResultadoPage extends StatelessWidget {
  const ResultadoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = GetIt.I<MainStore>();

    return Center(
      child: Observer(
        builder: (context) {
          //print(store.liveness);
          if (store.liveness != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.black),
                  child: ClipOval(
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(80),
                      child: Image.memory(
                        fit: BoxFit.cover,
                        base64Decode(store.liveness!.result!.frontalImage!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'GlobalScore: ${store.liveness!.result!.globalScore}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  'Liveness Score: ${store.liveness!.result!.livenessScore}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  'Movement Score: ${store.liveness!.result!.movementScore}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ],
            );
          } else {
            return store.errorMessage != null
                ? Text(store.errorMessage!)
                : const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
