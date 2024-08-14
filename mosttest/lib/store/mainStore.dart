import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobx/mobx.dart';
import 'package:cross_file/cross_file.dart';

import 'package:camera/camera.dart';
import 'package:mosttest/api/liveness.dart';
import 'package:mosttest/model/livenessDAO.dart';
part 'mainStore.g.dart';

class MainStore = _MainStore with _$MainStore;

abstract class _MainStore with Store {
  @observable
  XFile? xFile;

  @action
  void setXFile(XFile? file) {
    xFile = file;
  }

  @observable
  String? errorMessage;

  @observable
  LivenessDAO? liveness;

  @action
  Future<void> validarLivelinessAction() async {
    await authAction(dotenv.env['TOKEN'] ?? "");
    if (xFile != null && bearer != null) {
      liveness = await validarLiveliness(xFile!, bearer);
      print(liveness);
      if (liveness == null) {
        errorMessage =
            "Erro ao comunicar-se com o servidor. Tente novamente mais tarde";
      }
    } else {
      print("???????????");
      liveness = null;
      errorMessage =
          "Erro ao comunicar-se com o servidor. Tente novamente mais tarde";
    }
  }

  @observable
  String? bearer;

  @action
  Future<void> authAction(String token) async {
    bearer = await auth(token);
  }
}
