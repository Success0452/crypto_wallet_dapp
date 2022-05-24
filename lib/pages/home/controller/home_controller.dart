
import 'dart:math';
import 'package:crypto_wallet_dapp/snackbar/snackbar_stop.dart';
import 'package:crypto_wallet_dapp/snackbar/snackbar.dart';
import 'package:crypto_wallet_dapp/snackbar/snackbarClear.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;
import '../../../util/constant.dart';

class HomeController with ChangeNotifier{

  late Web3Client ethClient;
  //address
  final String myAddress = Constant.myAddress;
  //url from alchemy
  final String blockchainUrl = Constant.alchemyLink;
  bool data = false;
  int myAmount = 0;
  int amt = 0;

  var addressController = TextEditingController();
  var amountController = TextEditingController();

  var addressTo = "";
  var dec = pow(10, 18);
  var mydata;
  var mybalance;
  late String transHash;
  var balance;
  var name;
  var symbol;

  init(){
    var httpClient = http.Client();
    ethClient = Web3Client(Constant.alchemyLink, httpClient);
  }

  Future<DeployedContract> getContract() async {
    String abiFile = await rootBundle.loadString(Constant.abiLocation);
    String contractAddress = Constant.contractAddress;
    final contract = DeployedContract(
        ContractAbi.fromJson(abiFile, Constant.tokenName),
        EthereumAddress.fromHex(contractAddress)
    );
    notifyListeners();
    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    //
    final contract = await getContract();
    final ethFunction = contract.function(functionName);
    // This line below doesn't work.
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);
    // print(result.toString());
    notifyListeners();
    return result;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    DeployedContract contract = await getContract();
    final ethFunction = contract.function(functionName);
    const snackbar(label:  "Recording tranction");
    EthPrivateKey key = EthPrivateKey.fromHex( Constant.privateKey);
    Transaction transaction = await Transaction.callContract(
        contract: contract,
        function: ethFunction,
        parameters: args,
        maxGas: 100000);
    print(transaction.nonce);
    final result = await ethClient.sendTransaction(key, transaction,
        fetchChainIdFromNetworkId: true, chainId: null);
    print(result);
    const snackbarStop();
    snackbar(label: "verifying transaction");
    //set a 20 seconds delay to allow the transaction to be verified before trying to retrieve the balance
    Future.delayed(const Duration(seconds: 20), () {
      const snackbarStop();
      const snackbar(label: "retriving balance");
      getBalance(myAddress);
      const snackbarClear();
    });

    notifyListeners();
    return result;
  }

  Future<void> getBalance(String targetAddress) async {
    EthereumAddress address = EthereumAddress.fromHex(targetAddress);
    // print('In getGreeting');
    List<dynamic> result = await query('balanceOf', [address]);
    print('In getGreeting');
    print(result[0]);
    mybalance = result[0];
    var div = BigInt.from(dec);
    balance = BigInt.from(mybalance / div);

    print("balance: $balance");
    data = true;
    // setState(() {});
    notifyListeners();
  }


  Future<void> getName() async {
    // print('In getGreeting');
    List<dynamic> result = await query('name', []);
    print(result[0]);
    name = result[0];
    data = true;
    print(name);
    // setState(() {});
    notifyListeners();
  }

  Future<void> getSymbol() async {
    List<dynamic> result = await query('symbol', []);
    print(result[0]);
    symbol = result[0];
    data = true;
    // setState(() {});
    notifyListeners();
  }

  Future<String> reciveCoin(int amountR) async {
    var response;
    print(amountController.text);
   try{
     EthereumAddress addressTo =
     EthereumAddress.fromHex(Constant.myAddress);
     var bigAmount = BigInt.from(amountR);
     response = await submit("mint", [addressTo, bigAmount]);
     print('Recieved');
     transHash = response;
     // setState(() {});
     notifyListeners();
     return response;
   }catch(e){
     print(e);
   }
    return response;
  }

  Future<String> transferCoin(String addressTo) async {
    var amount = BigInt.from(amt *dec);
    EthereumAddress to = EthereumAddress.fromHex(addressTo);
    print("amo: $amount");
    var response = await submit('transfer', [to, amount]);
    print('Transfered');
    transHash = response;
    // setState(() {});
    notifyListeners();
    return response;
  }


  }

