import 'package:flutter/material.dart';

OverlayEntry? _overlayEntry; // Lưu trữ overlay để dễ xoá

void showCustomDrawer(BuildContext context, GlobalKey key) {
  if (key.currentContext == null) {
    print("⚠️ Menu Key chưa sẵn sàng, thử lại sau!");
    return;
  }

  final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  _overlayEntry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        // Bắt sự kiện bấm ra ngoài
        GestureDetector(
          onTap: () => closeCustomDrawer(),
          behavior: HitTestBehavior.opaque,
          child: Container(color: Colors.transparent), // Nền trong suốt
        ),

        // Menu chính
        Positioned(
          left: offset.dx,
          top: offset.dy + kToolbarHeight,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(title: Text("Item 1"), onTap: closeCustomDrawer),
                  ListTile(title: Text("Item 2"), onTap: closeCustomDrawer),
                  ListTile(title: Text("Item 3"), onTap: closeCustomDrawer),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );

  Overlay.of(context).insert(_overlayEntry!);
}

void closeCustomDrawer() {
  _overlayEntry?.remove();
  _overlayEntry = null;
}
