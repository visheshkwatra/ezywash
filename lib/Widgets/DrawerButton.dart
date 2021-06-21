import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    Key key,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background.withOpacity(0.9),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(24),
                topRight: Radius.circular(24))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          child: GestureDetector(
            onHorizontalDragStart: (drag) {
              _scaffoldKey.currentState.openDrawer();
            },
            onTap: () {
              _scaffoldKey.currentState.openDrawer();
            },
            child: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (Rect bounds) {
                  return ui.Gradient.linear(
                    Offset(4.0, 24.0),
                    Offset(24.0, 4.0),
                    [
                      Colors.blue,
                      Colors.greenAccent,
                    ],
                  );
                },
                child: Icon(
                  Icons.clear_all_outlined,
                  size: 32,
                )),
          ),
        ),
      ),
    );
  }
}
