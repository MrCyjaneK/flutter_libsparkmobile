import 'package:flutter/material.dart';
import 'package:flutter_libsparkmobile/flutter_libsparkmobile.dart';

class IdCoinView extends StatefulWidget {
  const IdCoinView({super.key});

  @override
  State<IdCoinView> createState() => _IdCoinViewState();
}

class _IdCoinViewState extends State<IdCoinView> {
  final privateKeyController = TextEditingController();
  final indexController = TextEditingController();
  final coinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ID Coin"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: privateKeyController,
                decoration: const InputDecoration(labelText: 'Private Key'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: indexController,
                decoration: const InputDecoration(labelText: 'Index'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: coinController,
                decoration: const InputDecoration(labelText: 'Coin'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton(
                child: const Text("GO"),
                onPressed: () {
                  final coin = LibSpark.identifyAndRecoverCoin(
                    coinController.text,
                    privateKeyHex: privateKeyController.text,
                    index: int.parse(indexController.text),
                  );

                  debugPrint(coin?.toString());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
