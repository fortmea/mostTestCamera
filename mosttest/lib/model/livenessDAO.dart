import 'dart:ffi';

class LivenessDAO {
  Result? result;
  String? requestId;
  int? elapsedMilliseconds;
  Status? status;

  LivenessDAO(
      {this.result, this.requestId, this.elapsedMilliseconds, this.status});

  LivenessDAO.fromJson(Map<String, dynamic> json) {
    result = json['result'] != null ? Result.fromJson(json['result']) : null;
    requestId = json['requestId'];
    elapsedMilliseconds = json['elapsedMilliseconds'];
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (result != null) {
      data['result'] = result!.toJson();
    }
    data['requestId'] = requestId;
    data['elapsedMilliseconds'] = elapsedMilliseconds;
    if (status != null) {
      data['status'] = status!.toJson();
    }
    return data;
  }
}

class Result {
  double? globalScore;
  double? movementScore;
  double? livenessScore;
  double? imageScore;
  String? frontalImage;

  Result(
      {this.globalScore,
      this.movementScore,
      this.livenessScore,
      this.imageScore,
      this.frontalImage});

  Result.fromJson(Map<String, dynamic> json) {
    globalScore = json['globalScore'];
    movementScore = json['movementScore'];
    livenessScore = json['livenessScore'];
    imageScore = json['imageScore'];
    frontalImage = json['frontalImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['globalScore'] = globalScore;
    data['movementScore'] = movementScore;
    data['livenessScore'] = livenessScore;
    data['imageScore'] = imageScore;
    data['frontalImage'] = frontalImage;
    return data;
  }
}

class Status {
  String? message;
  String? code;
  Null? errors;

  Status({this.message, this.code, this.errors});

  Status.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
    errors = json['errors'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['code'] = code;
    data['errors'] = errors;
    return data;
  }
}
