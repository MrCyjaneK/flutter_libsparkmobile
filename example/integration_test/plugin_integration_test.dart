import 'package:coinlib_flutter/coinlib_flutter.dart' as coinlib;
import 'package:flutter_libsparkmobile/flutter_libsparkmobile.dart';
import 'package:flutter_libsparkmobile_example/util/address_generator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  // Load coinlib for crypto operations.
  coinlib.loadCoinlib();

  testWidgets('mnemonic to address test', (WidgetTester tester) async {
    // Define the mnemonic.
    const mnemonic =
        'jazz settle broccoli dove hurt deny leisure coffee ivory calm pact chicken flag spot nature gym afford cotton dinosaur young private flash core approve';

    const index = 1;

    // Construct derivePath string.
    const derivePath = "m/44'/136'/0'/$kSparkChain/$index";

    // Generate key data from the mnemonic.
    final keyDataHex =
        await SparkAddressGenerator.generateKeyData(mnemonic, derivePath);

    // Derive the address from the key data.
    final address =
        await SparkAddressGenerator.getAddress(keyDataHex, index, 0, false);

    // Define the expected address.
    const expectedAddress =
        'sm1shqukway59rq5nefgywyrrmmt8eswgjqdgnsdn4ysrsfl2rna60l2drelf6nfe0pamyxh3w8ypa7y35znhf4c6w44d7lw8xu3kjra4sg2v0zn508hawuul5596fm2h4e2csa9egk4ks3a';

    // Compare the derived address with the expected address.
    expect(address, expectedAddress);
  });
}
