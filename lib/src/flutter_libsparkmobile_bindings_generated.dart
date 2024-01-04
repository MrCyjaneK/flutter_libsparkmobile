// ignore_for_file: always_specify_types
// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names

// AUTO GENERATED FILE, DO NOT EDIT.
//
// Generated by `package:ffigen`.
import 'dart:ffi' as ffi;

/// Bindings for `src/flutter_libsparkmobile.h`.
///
/// Regenerate bindings with `flutter pub run ffigen --config ffigen.yaml`.
///
final class FlutterLibsparkmobileBindings {
  /// Holds the symbol lookup function.
  final ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
      _lookup;

  /// The symbols are looked up in [dynamicLibrary].
  FlutterLibsparkmobileBindings(ffi.DynamicLibrary dynamicLibrary)
      : _lookup = dynamicLibrary.lookup;

  /// The symbols are looked up with [lookup].
  FlutterLibsparkmobileBindings.fromLookup(
      ffi.Pointer<T> Function<T extends ffi.NativeType>(String symbolName)
          lookup)
      : _lookup = lookup;

  ffi.Pointer<ffi.Char> getAddress(
    ffi.Pointer<ffi.UnsignedChar> keyData,
    int index,
    int diversifier,
    int isTestNet,
  ) {
    return _getAddress(
      keyData,
      index,
      diversifier,
      isTestNet,
    );
  }

  late final _getAddressPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.UnsignedChar>, ffi.Int,
              ffi.Int, ffi.Int)>>('getAddress');
  late final _getAddress = _getAddressPtr.asFunction<
      ffi.Pointer<ffi.Char> Function(
          ffi.Pointer<ffi.UnsignedChar>, int, int, int)>();

  /// FFI-friendly wrapper for spark::identifyCoin.
  ///
  /// identifyCoin: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/src/spark.cpp#L400
  /// /
  /// //FFI_PLUGIN_EXPORT
  /// //struct CIdentifiedCoinData identifyCoin(const unsigned char* serializedCoin, int serializedCoinLength, unsigned char* keyData, int index);
  ffi.Pointer<AggregateCoinData> idAndRecoverCoin(
    ffi.Pointer<ffi.UnsignedChar> serializedCoin,
    int serializedCoinLength,
    ffi.Pointer<ffi.UnsignedChar> keyData,
    int index,
    ffi.Pointer<ffi.UnsignedChar> context,
    int contextLength,
    int isTestNet,
  ) {
    return _idAndRecoverCoin(
      serializedCoin,
      serializedCoinLength,
      keyData,
      index,
      context,
      contextLength,
      isTestNet,
    );
  }

  late final _idAndRecoverCoinPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<AggregateCoinData> Function(
              ffi.Pointer<ffi.UnsignedChar>,
              ffi.Int,
              ffi.Pointer<ffi.UnsignedChar>,
              ffi.Int,
              ffi.Pointer<ffi.UnsignedChar>,
              ffi.Int,
              ffi.Int)>>('idAndRecoverCoin');
  late final _idAndRecoverCoin = _idAndRecoverCoinPtr.asFunction<
      ffi.Pointer<AggregateCoinData> Function(
          ffi.Pointer<ffi.UnsignedChar>,
          int,
          ffi.Pointer<ffi.UnsignedChar>,
          int,
          ffi.Pointer<ffi.UnsignedChar>,
          int,
          int)>();

  /// FFI-friendly wrapper for spark::createSparkMintRecipients.
  ///
  /// createSparkMintRecipients: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/src/spark.cpp#L43
  ffi.Pointer<CCRecipientList> cCreateSparkMintRecipients(
    ffi.Pointer<CMintedCoinData> outputs,
    int outputsLength,
    ffi.Pointer<ffi.UnsignedChar> serial_context,
    int serial_contextLength,
    int generate,
  ) {
    return _cCreateSparkMintRecipients(
      outputs,
      outputsLength,
      serial_context,
      serial_contextLength,
      generate,
    );
  }

  late final _cCreateSparkMintRecipientsPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<CCRecipientList> Function(
              ffi.Pointer<CMintedCoinData>,
              ffi.Int,
              ffi.Pointer<ffi.UnsignedChar>,
              ffi.Int,
              ffi.Int)>>('cCreateSparkMintRecipients');
  late final _cCreateSparkMintRecipients =
      _cCreateSparkMintRecipientsPtr.asFunction<
          ffi.Pointer<CCRecipientList> Function(ffi.Pointer<CMintedCoinData>,
              int, ffi.Pointer<ffi.UnsignedChar>, int, int)>();

  /// FFI-friendly wrapper for spark::createSparkSpendTransaction.
  ///
  /// createSparkSpendTransaction: https://github.com/firoorg/sparkmobile/blob/23099b0d9010a970ad75b9cfe05d568d634088f3/src/spark.cpp#L190
  ffi.Pointer<SparkSpendTransactionResult> cCreateSparkSpendTransaction(
    ffi.Pointer<ffi.UnsignedChar> keyData,
    int index,
    ffi.Pointer<CRecip> recipients,
    int recipientsLength,
    ffi.Pointer<COutputRecipient> privateRecipients,
    int privateRecipientsLength,
    ffi.Pointer<DartSpendCoinData> coins,
    int coinsLength,
    ffi.Pointer<CCoverSetData> cover_set_data_all,
    int cover_set_data_allLength,
    ffi.Pointer<BlockHashAndId> idAndBlockHashes,
    int idAndBlockHashesLength,
    ffi.Pointer<ffi.UnsignedChar> txHashSig,
  ) {
    return _cCreateSparkSpendTransaction(
      keyData,
      index,
      recipients,
      recipientsLength,
      privateRecipients,
      privateRecipientsLength,
      coins,
      coinsLength,
      cover_set_data_all,
      cover_set_data_allLength,
      idAndBlockHashes,
      idAndBlockHashesLength,
      txHashSig,
    );
  }

  late final _cCreateSparkSpendTransactionPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<SparkSpendTransactionResult> Function(
              ffi.Pointer<ffi.UnsignedChar>,
              ffi.Int,
              ffi.Pointer<CRecip>,
              ffi.Int,
              ffi.Pointer<COutputRecipient>,
              ffi.Int,
              ffi.Pointer<DartSpendCoinData>,
              ffi.Int,
              ffi.Pointer<CCoverSetData>,
              ffi.Int,
              ffi.Pointer<BlockHashAndId>,
              ffi.Int,
              ffi.Pointer<ffi.UnsignedChar>)>>('cCreateSparkSpendTransaction');
  late final _cCreateSparkSpendTransaction =
      _cCreateSparkSpendTransactionPtr.asFunction<
          ffi.Pointer<SparkSpendTransactionResult> Function(
              ffi.Pointer<ffi.UnsignedChar>,
              int,
              ffi.Pointer<CRecip>,
              int,
              ffi.Pointer<COutputRecipient>,
              int,
              ffi.Pointer<DartSpendCoinData>,
              int,
              ffi.Pointer<CCoverSetData>,
              int,
              ffi.Pointer<BlockHashAndId>,
              int,
              ffi.Pointer<ffi.UnsignedChar>)>();

  ffi.Pointer<SerializedMintContextResult> serializeMintContext(
    ffi.Pointer<DartInputData> inputs,
    int inputsLength,
  ) {
    return _serializeMintContext(
      inputs,
      inputsLength,
    );
  }

  late final _serializeMintContextPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<SerializedMintContextResult> Function(
              ffi.Pointer<DartInputData>, ffi.Int)>>('serializeMintContext');
  late final _serializeMintContext = _serializeMintContextPtr.asFunction<
      ffi.Pointer<SerializedMintContextResult> Function(
          ffi.Pointer<DartInputData>, int)>();

  ffi.Pointer<ValidateAddressResult> isValidSparkAddress(
    ffi.Pointer<ffi.Char> addressCStr,
    int isTestNet,
  ) {
    return _isValidSparkAddress(
      addressCStr,
      isTestNet,
    );
  }

  late final _isValidSparkAddressPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ValidateAddressResult> Function(
              ffi.Pointer<ffi.Char>, ffi.Int)>>('isValidSparkAddress');
  late final _isValidSparkAddress = _isValidSparkAddressPtr.asFunction<
      ffi.Pointer<ValidateAddressResult> Function(
          ffi.Pointer<ffi.Char>, int)>();

  ffi.Pointer<ffi.Char> hashTags(
    ffi.Pointer<ffi.UnsignedChar> tags,
    int tagCount,
  ) {
    return _hashTags(
      tags,
      tagCount,
    );
  }

  late final _hashTagsPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.UnsignedChar>, ffi.Int)>>('hashTags');
  late final _hashTags = _hashTagsPtr.asFunction<
      ffi.Pointer<ffi.Char> Function(ffi.Pointer<ffi.UnsignedChar>, int)>();

  ffi.Pointer<ffi.Char> hashTag(
    ffi.Pointer<ffi.Char> x,
    ffi.Pointer<ffi.Char> y,
  ) {
    return _hashTag(
      x,
      y,
    );
  }

  late final _hashTagPtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<ffi.Char> Function(
              ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Char>)>>('hashTag');
  late final _hashTag = _hashTagPtr.asFunction<
      ffi.Pointer<ffi.Char> Function(
          ffi.Pointer<ffi.Char>, ffi.Pointer<ffi.Char>)>();

  ffi.Pointer<SparkFeeResult> estimateSparkFee(
    ffi.Pointer<ffi.UnsignedChar> keyData,
    int index,
    int sendAmount,
    int subtractFeeFromAmount,
    ffi.Pointer<DartSpendCoinData> coins,
    int coinsLength,
    int privateRecipientsLength,
  ) {
    return _estimateSparkFee(
      keyData,
      index,
      sendAmount,
      subtractFeeFromAmount,
      coins,
      coinsLength,
      privateRecipientsLength,
    );
  }

  late final _estimateSparkFeePtr = _lookup<
      ffi.NativeFunction<
          ffi.Pointer<SparkFeeResult> Function(
              ffi.Pointer<ffi.UnsignedChar>,
              ffi.Int,
              ffi.Int64,
              ffi.Int,
              ffi.Pointer<DartSpendCoinData>,
              ffi.Int,
              ffi.Int)>>('estimateSparkFee');
  late final _estimateSparkFee = _estimateSparkFeePtr.asFunction<
      ffi.Pointer<SparkFeeResult> Function(ffi.Pointer<ffi.UnsignedChar>, int,
          int, int, ffi.Pointer<DartSpendCoinData>, int, int)>();
}

/// FFI-friendly wrapper for a spark::Coin.
///
/// Coin: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/src/coin.h#L66
final class CCoin extends ffi.Struct {
  @ffi.Char()
  external int type;

  external ffi.Pointer<ffi.Char> kHex;

  @ffi.Int()
  external int kLength;

  external ffi.Pointer<ffi.Char> address;

  @ffi.Uint64()
  external int v;

  external ffi.Pointer<ffi.Char> memo;

  @ffi.Int()
  external int memoLength;

  external ffi.Pointer<ffi.UnsignedChar> serial_context;

  @ffi.Int()
  external int serial_contextLength;
}

/// FFI-friendly wrapper for a spark::IdentifiedCoinData.
///
/// IdentifiedCoinData: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/src/coin.h#L19
final class CIdentifiedCoinData extends ffi.Struct {
  @ffi.Uint64()
  external int i;

  external ffi.Pointer<ffi.UnsignedChar> d;

  @ffi.Int()
  external int dLength;

  @ffi.Uint64()
  external int v;

  external ffi.Pointer<ffi.Char> kHex;

  @ffi.Int()
  external int kLength;

  external ffi.Pointer<ffi.Char> memo;

  @ffi.Int()
  external int memoLength;
}

/// FFI-friendly wrapper for a spark::CRecipient.
///
/// CRecipient: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/include/spark.h#L27
final class CCRecipient extends ffi.Struct {
  external ffi.Pointer<ffi.UnsignedChar> pubKey;

  @ffi.Int()
  external int pubKeyLength;

  @ffi.Uint64()
  external int cAmount;

  @ffi.Int()
  external int subtractFee;
}

final class CCRecipientList extends ffi.Struct {
  external ffi.Pointer<CCRecipient> list;

  @ffi.Int()
  external int length;
}

/// FFI-friendly wrapper for a spark::MintedCoinData.
///
/// MintedCoinData: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/src/mint_transaction.h#L12
final class CMintedCoinData extends ffi.Struct {
  external ffi.Pointer<ffi.Char> address;

  @ffi.Uint64()
  external int value;

  external ffi.Pointer<ffi.Char> memo;
}

final class PubKeyScript extends ffi.Struct {
  external ffi.Pointer<ffi.UnsignedChar> bytes;

  @ffi.Int()
  external int length;
}

/// FFI-friendly wrapper for a std::pair<CAmount, bool>.
///
/// Note this is an ambiguation of a spark::CRecipient.  This CRecip(ient) is just a wrapper for a
/// CAmount and bool pair, and is not the same as the spark::CRecipient struct above, which gets
/// wrapped for us as a CCRecipient and is unrelated to this struct.
///
/// See https://github.com/firoorg/sparkmobile/blob/23099b0d9010a970ad75b9cfe05d568d634088f3/src/spark.cpp#L190
final class CRecip extends ffi.Struct {
  @ffi.Uint64()
  external int amount;

  @ffi.Int()
  external int subtractFee;
}

/// FFI-friendly wrapper for a spark::OutputCoinData.
///
/// OutputCoinData: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/src/spend_transaction.h#L33
final class COutputCoinData extends ffi.Struct {
  external ffi.Pointer<ffi.Char> address;

  @ffi.Int()
  external int addressLength;

  @ffi.Uint64()
  external int value;

  external ffi.Pointer<ffi.Char> memo;

  @ffi.Int()
  external int memoLength;
}

/// FFI-friendly wrapper for a <spark::OutputCoinData, bool>.
///
/// See https://github.com/firoorg/sparkmobile/blob/23099b0d9010a970ad75b9cfe05d568d634088f3/src/spark.cpp#L195
final class COutputRecipient extends ffi.Struct {
  external ffi.Pointer<COutputCoinData> output;

  @ffi.Int()
  external int subtractFee;
}

final class CCDataStream extends ffi.Struct {
  external ffi.Pointer<ffi.UnsignedChar> data;

  @ffi.Int()
  external int length;
}

/// FFI-friendly wrapper for a spark::CSparkMintMeta.
///
/// CSparkMintMeta: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/src/primitives.h#L9
final class CCSparkMintMeta extends ffi.Struct {
  @ffi.Int()
  external int height;

  @ffi.Int()
  external int id;

  @ffi.Int()
  external int isUsed;

  external ffi.Pointer<ffi.UnsignedChar> txid;

  /// Diversifier.
  @ffi.Uint64()
  external int i;

  /// Encrypted diversifier.
  external ffi.Pointer<ffi.UnsignedChar> d;

  @ffi.Int()
  external int dLength;

  /// Value.
  @ffi.Uint64()
  external int v;

  external ffi.Pointer<ffi.Char> nonceHex;

  @ffi.Int()
  external int nonceHexLength;

  external ffi.Pointer<ffi.Char> memo;

  @ffi.Int()
  external int memoLength;

  external ffi.Pointer<ffi.UnsignedChar> serial_context;

  @ffi.Int()
  external int serial_contextLength;

  @ffi.Char()
  external int type;

  external ffi.Pointer<ffi.UnsignedChar> serializedCoin;

  @ffi.Int()
  external int serializedCoinLength;
}

/// FFI-friendly wrapper for a spark::CoverSetData.
///
/// CoverSetData: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/src/spend_transaction.h#L28
final class CCoverSetData extends ffi.Struct {
  /// vs. struct CCoin* cover_set;
  external ffi.Pointer<CCDataStream> cover_set;

  @ffi.Int()
  external int cover_setLength;

  external ffi.Pointer<ffi.UnsignedChar> cover_set_representation;

  @ffi.Int()
  external int cover_set_representationLength;

  @ffi.Int()
  external int setId;
}

final class OutputScript extends ffi.Struct {
  external ffi.Pointer<ffi.UnsignedChar> bytes;

  @ffi.Int()
  external int length;
}

/// Aggregate data structure to handle passing spark mint/spend data across FFI
final class AggregateCoinData extends ffi.Struct {
  @ffi.Char()
  external int type;

  @ffi.Uint64()
  external int diversifier;

  @ffi.Uint64()
  external int value;

  external ffi.Pointer<ffi.Char> address;

  external ffi.Pointer<ffi.Char> memo;

  external ffi.Pointer<ffi.Char> lTagHash;

  external ffi.Pointer<ffi.UnsignedChar> encryptedDiversifier;

  @ffi.Int()
  external int encryptedDiversifierLength;

  external ffi.Pointer<ffi.UnsignedChar> serial;

  @ffi.Int()
  external int serialLength;

  external ffi.Pointer<ffi.Char> nonceHex;

  @ffi.Int()
  external int nonceHexLength;
}

/// Aggregate data structure to handle passing spark spend data across FFI.
///
/// Contains the serialized transaction or the error message if isError is true.
final class SparkSpendTransactionResult extends ffi.Struct {
  external ffi.Pointer<ffi.UnsignedChar> data;

  @ffi.Int()
  external int dataLength;

  external ffi.Pointer<OutputScript> outputScripts;

  @ffi.Int()
  external int outputScriptsLength;

  @ffi.Int64()
  external int fee;

  @ffi.Int()
  external int isError;
}

final class DartInputData extends ffi.Struct {
  external ffi.Pointer<ffi.UnsignedChar> txHash;

  @ffi.Int()
  external int txHashLength;

  @ffi.Int()
  external int vout;
}

final class SerializedMintContextResult extends ffi.Struct {
  external ffi.Pointer<ffi.UnsignedChar> context;

  @ffi.Int()
  external int contextLength;
}

final class ValidateAddressResult extends ffi.Struct {
  @ffi.Int()
  external int isValid;

  external ffi.Pointer<ffi.Char> errorMessage;
}

final class BlockHashAndId extends ffi.Struct {
  external ffi.Pointer<ffi.UnsignedChar> hash;

  @ffi.Int()
  external int id;
}

final class DartSpendCoinData extends ffi.Struct {
  external ffi.Pointer<CCDataStream> serializedCoin;

  external ffi.Pointer<CCDataStream> serializedCoinContext;

  @ffi.Int()
  external int groupId;

  @ffi.Int()
  external int height;
}

final class SparkFeeResult extends ffi.Struct {
  external ffi.Pointer<ffi.Char> error;

  @ffi.Int64()
  external int fee;
}