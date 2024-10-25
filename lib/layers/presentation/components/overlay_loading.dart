import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

mixin LoadingOverlay<W extends StatefulWidget> on State<W> {
  OverlayEntry? _overlayEntry;

  void showLoading(bool isShow) {
    if (isShow) {
      _show();
      return;
    }
    _hide();
  }

  void _show() {
    if (_overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: (context) => Container(
        color: Colors.black54,
        child: const Center(
          child: CupertinoActivityIndicator(
            color: Colors.white,
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _hide() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void deactivate() {
    _hide();
    super.deactivate();
  }
}