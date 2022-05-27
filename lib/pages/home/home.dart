
import 'package:crypto_wallet_dapp/pages/home/controller/home_controller.dart';
import 'package:crypto_wallet_dapp/util/constant.dart';
import 'package:crypto_wallet_dapp/util/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    context.read<HomeController>().init();
    context.read<HomeController>().getBalance(Constant.myAddress);
    context.read<HomeController>().getName();
    context.read<HomeController>().getSymbol();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<HomeController>(
        builder: (context, ref, child) {
          return SafeArea(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20, left: 15, right: 10),
                        child: Text(Constant.setUpWallet,
                          style: TextStyle(color: Colors.white, fontSize: 25.0),),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: GestureDetector(
                            onTap: (){
                              print('settings');
                            },
                            child: const Icon(Icons.settings, size: 25.0, color: Colors.white,)
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 15, right: 10),
                        child: Text(Constant.longText, style: TextStyle(
                            color: Colors.white24, fontSize: 18.0
                        ),),
                      ),

                    ],
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Balance", style: TextStyle(color: Colors.white, fontSize: 12.0),),
                        SizedBox(height: 5,),
                        Text('${ref.balance} ${ref.symbol}',
                          style: TextStyle(color: Colors.white, fontSize: 25.0),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
                    child: CustomTextField(
                      keyboardType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      autoCorrect: false,
                      obscureText: false,
                      controller: context.read<HomeController>().addressController,
                      hintText: "Address",
                      icon: const Icon(
                        Icons.markunread_sharp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 20.0),
                    child: CustomTextField(
                      keyboardType: TextInputType.name,
                      inputAction: TextInputAction.next,
                      autoCorrect: false,
                      obscureText: false,
                      controller: context.read<HomeController>().amountController,
                      hintText: "Amount",
                      icon: const Icon(
                        Icons.attach_money_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    print(Constant.sendToken);
                                   if(ref.addressController.text.isNotEmpty || ref.amountController.text.isNotEmpty){
                                     context.read<HomeController>().transferCoin(ref.addressController.text, int.parse( ref.amountController.text));
                                   }else{
                                     Get.snackbar(
                                       "TextField is empty",
                                       "Enter address",
                                       backgroundColor: Colors.white,
                                       colorText: Colors.blue,
                                       icon: const Icon(Icons.login, color: Colors.white),
                                       snackPosition: SnackPosition.TOP,
                                       duration: const Duration(seconds: 5),
                                       borderRadius: 10,
                                     );
                                   }
                                  },
                                  child: Container(
                                    height: 250.0,
                                    width: 160.0,
                                    decoration: BoxDecoration(
                                      color: Colors.lightBlueAccent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5, top: 5),
                                          child: Icon(Icons.send_to_mobile),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            children: const [
                                              SizedBox(width: 10,),
                                              Text(Constant.sendToken, style: TextStyle(fontSize: 18))
                                            ],),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                GestureDetector(
                                  onTap: (){
                                    print(Constant.importWallet);
                                    context.read<HomeController>().getBalance(Constant.myAddress);
                                  },
                                  child: Container(
                                    height: 250.0,
                                    width: 160.0,
                                    decoration: BoxDecoration(
                                      color: Colors.greenAccent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5, top: 5),
                                          child: Icon(Icons.download_outlined),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            children: const [
                                              SizedBox(width: 10,),
                                              Text(Constant.importWallet, style: TextStyle(fontSize: 18),)
                                            ],),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    print(Constant.receiveToken);
                                    if(ref.amountController.text.isNotEmpty){
                                      context.read<HomeController>().reciveCoin(int.parse(ref.amountController.text).round());
                                    }else{
                                      Get.snackbar(
                                        "TextField is empty",
                                        "Enter amount",
                                        backgroundColor: Colors.white,
                                        colorText: Colors.blue,
                                        icon: const Icon(Icons.login, color: Colors.white),
                                        snackPosition: SnackPosition.TOP,
                                        duration: const Duration(seconds: 5),
                                        borderRadius: 10,
                                      );
                                    }
                                  },
                                  child: Container(
                                    height: 250.0,
                                    width: 160.0,
                                    decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5, top: 5),
                                          child: Icon(Icons.call_received),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            children: const [
                                              SizedBox(width: 10,),
                                              Text(Constant.receiveToken, style: TextStyle(fontSize: 18))
                                            ],),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                                GestureDetector(
                                  onTap: (){
                                    print(Constant.connectWallet);
                                  },
                                  child: Container(
                                    height: 250.0,
                                    width: 160.0,
                                    decoration: BoxDecoration(
                                      color: Colors.orangeAccent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 5, top: 5),
                                          child: Icon(Icons.connect_without_contact_outlined),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8),
                                          child: Row(
                                            children: const [
                                              SizedBox(width: 10,),
                                              Text(Constant.connectWallet, style: TextStyle(fontSize: 18))
                                            ],),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5.0,),
                              ],
                            ),
                          ],
                        )
                    ),
                  )
                ],
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white24,
        onPressed: (() => context.read<HomeController>().getBalance(Constant.myAddress)),
        child: const Center(
          child: Icon(Icons.refresh,),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
  

}
