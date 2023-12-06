#include "flutter_libsparkmobile.h"
#include "utils.h"
#include "deps/sparkmobile/include/spark.h"
#include "deps/sparkmobile/bitcoin/uint256.h"
#include "structs.h"

#include <cstring>
#include <iostream> // Just for printing.

using namespace spark;

/*
 * FFI-friendly wrapper for spark::getAddress.
 *
 * getAddress: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/src/spark.cpp#L388
 */
FFI_PLUGIN_EXPORT
const char* getAddress(unsigned char* keyData, int index, int diversifier, int isTestNet) {
    try {
        // Use the hex string directly to create the SpendKey.
        spark::SpendKey spendKey = createSpendKeyFromData(keyData, index);

        spark::FullViewKey fullViewKey(spendKey);
        spark::IncomingViewKey incomingViewKey(fullViewKey);
        spark::Address address(incomingViewKey, static_cast<uint64_t>(diversifier));

        // Encode the Address object into a string using the appropriate network.
        std::string encodedAddress = address.encode(isTestNet ? spark::ADDRESS_NETWORK_TESTNET : spark::ADDRESS_NETWORK_MAINNET);

        // Allocate memory for the C-style string.
        char* cstr = new char[encodedAddress.length() + 1];
        std::strcpy(cstr, encodedAddress.c_str());

        return cstr;
    } catch (const std::exception& e) {
        std::cerr << "Exception: " << e.what() << std::endl;
        return nullptr;
    }
}

/*
 * FFI-friendly wrapper for spark:identifyCoin.
 *
 * identifyCoin: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/src/spark.cpp#L400
 */
FFI_PLUGIN_EXPORT
CIdentifiedCoinData identifyCoin(const unsigned char* serializedCoin, int serializedCoinLength, unsigned char* keyData, int index) {
    try {
        spark::Coin coin = deserializeCoin(serializedCoin, serializedCoinLength);

        // Derive the incoming view key from the key data and index.
        spark::SpendKey spendKey = createSpendKeyFromData(keyData, index);
        spark::FullViewKey fullViewKey(spendKey);
        spark::IncomingViewKey incomingViewKey(fullViewKey);

        spark::IdentifiedCoinData identifiedCoinData = coin.identify(incomingViewKey);
        return toFFI(identifiedCoinData);
    } catch (const std::exception& e) {
        std::cerr << "Exception: " << e.what() << std::endl;
        return CIdentifiedCoinData();
    }
}

FFI_PLUGIN_EXPORT
AggregateCoinData* idAndRecoverCoin(
        const unsigned char* serializedCoin,
        int serializedCoinLength,
        unsigned char* keyData,
        int index,
        int isTestNet) {
    try {
        spark::Coin coin = deserializeCoin(serializedCoin, serializedCoinLength);

        // Derive the incoming view key from the key data and index.
        spark::SpendKey spendKey = createSpendKeyFromData(keyData, index);
        spark::FullViewKey fullViewKey(spendKey);
        spark::IncomingViewKey incomingViewKey(fullViewKey);

        spark::IdentifiedCoinData identifiedCoinData = coin.identify(incomingViewKey);

        spark::RecoveredCoinData data = coin.recover(fullViewKey, identifiedCoinData);

        spark::Address address = getAddress(incomingViewKey, identifiedCoinData.i);
        std::string addressString = address.encode(isTestNet ? spark::ADDRESS_NETWORK_TESTNET : spark::ADDRESS_NETWORK_MAINNET);

        AggregateCoinData* result = (AggregateCoinData*)malloc(sizeof(AggregateCoinData));

        result->type = coin.type;
        result->diversifier = identifiedCoinData.i;
        result->value = identifiedCoinData.v;

        result->address = (char*)malloc((addressString.length() + 1) * sizeof(char));
        std::strcpy(result->address, addressString.c_str());

        result->memo = (char*)malloc((identifiedCoinData.memo.length() + 1) * sizeof(char));
        std::strcpy(result->memo, identifiedCoinData.memo.c_str());

        uint256 lTagHash = primitives::GetLTagHash(data.T);
        result->lTagHash = (char*)malloc((lTagHash.GetHex().length() + 1) * sizeof(char));
        std::strcpy(result->lTagHash, lTagHash.GetHex().c_str());

        result->encryptedDiversifier = (unsigned char*)malloc(identifiedCoinData.d.size() * sizeof(unsigned char));
        result->encryptedDiversifierLength = identifiedCoinData.d.size();
        memcpy(result->encryptedDiversifier,identifiedCoinData.d.data(),identifiedCoinData.d.size() * sizeof(unsigned char));

        result->nonce = (unsigned char*)malloc(32 * sizeof(unsigned char));
        result->nonceLength = 32;
        identifiedCoinData.k.serialize(result->nonce);

        result->serial = (unsigned char*)malloc(data.s.GetHex().length() * sizeof(unsigned char));
        result->serialLength = data.s.GetHex().length();
        memcpy(result->serial,data.s.GetHex().c_str(),data.s.GetHex().length() * sizeof(unsigned char));

        return result;
    } catch (const std::exception& e) {
//        std::cerr << "Exception: " << e.what() << std::endl;
        return nullptr;
    }
}

/*
 * FFI-friendly wrapper for spark::createSparkMintRecipients.
 *
 * createSparkMintRecipients: https://github.com/firoorg/sparkmobile/blob/8bf17cd3deba6c3b0d10e89282e02936d7e71cdd/src/spark.cpp#L43
 */
FFI_PLUGIN_EXPORT
CCRecipientList* cCreateSparkMintRecipients(
    struct CMintedCoinData* cOutputs,
    int outputsLength,
    unsigned char* serial_context,
    int serial_contextLength,
    int generate
) {
    // Construct vector of spark::MintedCoinData.
    std::vector<spark::MintedCoinData> outputs;

    // Copy the data from the array to the vector.
    for (int i = 0; i < outputsLength; i++) {
        spark::MintedCoinData data = fromFFI(cOutputs[i]);
        outputs.push_back(data);
    }

    // Construct vector of unsigned chars.
    std::vector<unsigned char> serialVec(serial_context, serial_context + serial_contextLength);

    // Call spark::createSparkMintRecipients.
    std::vector<CRecipient> recipients = createSparkMintRecipients(outputs, serialVec, generate);

    // Create a CRecipient* array.
    CCRecipientList *data = (CCRecipientList*)malloc(sizeof(CCRecipientList));
    data->length = recipients.size();
    data->list = (CCRecipient*)malloc(sizeof(CCRecipient) * recipients.size());

    // Copy the data from the vector to the array.
    for (int i = 0; i < recipients.size(); i++) {
        data->list[i].cAmount = recipients[i].amount;
        data->list[i].subtractFee = recipients[i].subtractFeeFromAmount;
        data->list[i].pubKeyLength = recipients[i].pubKey.size();
        data->list[i].pubKey = (unsigned char*)malloc(sizeof(unsigned char) * recipients[i].pubKey.size());
        std::vector<unsigned char> vec(recipients[i].pubKey.begin(), recipients[i].pubKey.end());
        unsigned char* ptr = vec.data();
        for (int j = 0; j < data->list[i].pubKeyLength; j++) {
            data->list[i].pubKey[j] = ptr[j];
        }
    }

    // Return the array.
    return data;
}

/*
 * FFI-friendly wrapper for spark::createSparkSpendTransaction.
 *
 * createSparkSpendTransaction: https://github.com/firoorg/sparkmobile/blob/23099b0d9010a970ad75b9cfe05d568d634088f3/src/spark.cpp#L190
 */
FFI_PLUGIN_EXPORT
unsigned char* cCreateSparkSpendTransaction(
    unsigned char* keyData,
    int index,
    struct CRecip* recipients, // This CRecip(ient) is not the same as a CRecipient.
    int recipientsLength,
    struct COutputRecipient* privateRecipients,
    int privateRecipientsLength,
    struct CCSparkMintMeta* coins,
    int coinsLength,
    struct CCoverSets* cover_set_data_all,
    int cover_set_data_allLength,
    // idAndBlockHashes_all is unused in spark::createSparkSpendTransaction so we ignore it here.
    const char* txHashSig, // A hex string.
    int txHashSigLength,
    uint64_t fee,
    // spark's createSparkSpendTransaction returns void, writing to the serializedSpend parameter.
    // We return it instead.
    const OutputScript* outputScripts,
    int outputScriptsLength
) {
    try {
        // Derive the keys from the key data and index.
        spark::SpendKey spendKey = createSpendKeyFromData(keyData, index);
        spark::FullViewKey fullViewKey(spendKey);
        spark::IncomingViewKey incomingViewKey(fullViewKey);

        // Convert CRecipient* recipients to std::vector<std::pair<CAmount, bool>> cppRecipients.
        std::vector<std::pair<CAmount, bool>> cppRecipients;
        for (int i = 0; i < recipientsLength; i++) {
            cppRecipients.push_back(std::make_pair(recipients[i].amount, recipients[i].subtractFee));
        }

        // Convert COutputRecipient* privateRecipients to std::vector<std::pair<spark::OutputCoinData, bool>> cppPrivateRecipients.
        std::vector<std::pair<spark::OutputCoinData, bool>> cppPrivateRecipients;
        for (int i = 0; i < privateRecipientsLength; i++) {
            cppPrivateRecipients.push_back(std::make_pair(fromFFI(privateRecipients[i].output), privateRecipients[i].subtractFee));
        }

        // Convert CCSparkMintMeta* coins to std::list<CSparkMintMeta> cppCoins.
        std::list<CSparkMintMeta> cppCoins;
        for (int i = 0; i < coinsLength; i++) {
            cppCoins.push_back(fromFFI(coins[i]));
        }

        // Convert CCoverSets* cover_set_data_all to a std::unordered_map<uint64_t, spark::CoverSetData> cppCoverSetDataAll
        // TODO verify correctness.
        std::unordered_map<uint64_t, spark::CoverSetData> cppCoverSetDataAll;
        for (int i = 0; i < cover_set_data_allLength; i++) {
            for (int j = 0; j < cover_set_data_all[i].cover_setsLength; j++) {
                // Convert CCoverSetData to vector of Coins.
                std::vector<spark::Coin> cppCoverSetCoins;
                spark::Coin coin = fromFFI(*cover_set_data_all[i].cover_sets[j].cover_set[0]);
                cppCoverSetCoins.push_back(coin);

                // Convert CCoverSetData to vector of vector of unsigned chars.
                std::vector<CCoverSetData> coverSets(cover_set_data_all[i].cover_sets, cover_set_data_all[i].cover_sets + cover_set_data_all[i].cover_setsLength);

                // Combine all the cover set representations into one vector.
                std::vector<unsigned char> coverSetReps;
                for (int k = 0; k < cover_set_data_all[i].cover_setsLength; k++) {
                    for (int l = 0; l < cover_set_data_all[i].cover_sets[k].cover_set_representationLength; l++) {
                        coverSetReps.push_back(cover_set_data_all[i].cover_sets[k].cover_set_representation[l]);
                    }
                }

                // Construct spark::CoverSetData.
                spark::CoverSetData cppCoverSetData;
                cppCoverSetData.cover_set = cppCoverSetCoins;
                cppCoverSetData.cover_set_representation = coverSetReps;

                cppCoverSetDataAll[cover_set_data_all[i].cover_sets[j].cover_setLength] = cppCoverSetData;
            }
        }

        // Convert const char * txHashSig to a uint256 cppTxHashSig.
        // uint256 cppTxHashSig(txHashSig); // This throws `error: no matching function for call to ‘uint256::uint256(const char*&)’`, we need to:
        uint256 cppTxHashSig;
        cppTxHashSig.SetHex(txHashSig);

        // Make a CAmount cppFee from fee.
        CAmount cppFee = fee;

        // Make a dummy for idAndBlockHashes_all.
        std::map<uint64_t, uint256> cppIdAndBlockHashesAll;

        // Make a placeholder for serializedSpend.
        std::vector<uint8_t> cppSerializedSpend;

        // Convert outputScripts to std::vector<std::vector<unsigned char>> cppOutputScripts.
        std::vector<std::vector<unsigned char>> cppOutputScripts;
        for (int i = 0; i < outputScriptsLength; i++) {
            for (int j = 0; j < outputScripts[i].length; j++) {
                cppOutputScripts[i].push_back(outputScripts[i].bytes[j]);
            }
        }

        // Call spark::createSparkSpendTransaction.
        createSparkSpendTransaction(
            spendKey,
            fullViewKey,
            incomingViewKey,
            cppRecipients,
            cppPrivateRecipients,
            cppCoins,
            cppCoverSetDataAll,
            cppIdAndBlockHashesAll,
            cppTxHashSig,
            cppFee,
            cppSerializedSpend,
            cppOutputScripts
        );

        // Allocate memory for the C-style string.
        unsigned char* cstr = new unsigned char[cppSerializedSpend.size()];

        // Copy the data from the vector to the array.
        for (int i = 0; i < cppSerializedSpend.size(); i++) {
            cstr[i] = cppSerializedSpend[i];
        }

        // Return the array.
        return cstr;
    } catch (const std::exception& e) {
        std::cerr << "Exception: " << e.what() << std::endl;
        return nullptr;
    }
}
