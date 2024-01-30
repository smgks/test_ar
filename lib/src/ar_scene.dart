import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';

import '../asset_keys.dart';

class ArScene extends StatefulWidget {
  const ArScene({super.key});

  @override
  State<ArScene> createState() => _ArSceneState();
}

class _ArSceneState extends State<ArScene> {
  ArCoreController? _arCoreController;
  ArCoreReferenceNode? _foxNode;
  String get assetName => AssetKeys.articFox;

  @override
  void dispose() {
    _arCoreController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Tap on plane to add 3D model')),
    floatingActionButton: FloatingActionButton(
      onPressed: _foxNode != null
        ? () {
            _arCoreController!.removeNode(nodeName: assetName);
            setState(() {
              _foxNode = null;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Fox removed'),
              ),
            );
          }
        : null,
      child: const Icon(Icons.delete),
    ),
    body: ArCoreView(
      enableTapRecognizer: true,
      enablePlaneRenderer: true,
      onArCoreViewCreated: _onARKitViewCreated,
    ),
  );

  void _onARKitViewCreated(ArCoreController arCoreController) {
    _arCoreController = arCoreController;
    arCoreController.onPlaneTap = _arPlaneTapHandler;
  }

  void _arPlaneTapHandler(List<ArCoreHitTestResult> hits) {
    if (hits.isEmpty) {
      return;
    }
    _addFox(hits.first);
  }

  void _addFox(ArCoreHitTestResult plane) {
    if (_foxNode != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fox already in scene'),
        ),
      );
      return;
    }
    setState(() {
      _foxNode = ArCoreReferenceNode(
        name: assetName,
        object3DFileName: assetName,
        position: plane.pose.translation,
        rotation: plane.pose.rotation,
      );
    });
    _arCoreController!.addArCoreNodeWithAnchor(_foxNode!);
  }
}
