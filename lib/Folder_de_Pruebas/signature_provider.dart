import 'package:flutter/material.dart';
import 'package:signature/signature.dart';


class SignatureProvider with ChangeNotifier {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  SignatureController get controller => _controller;

  void clearSignature() {
    _controller.clear();
    notifyListeners();
  }
}