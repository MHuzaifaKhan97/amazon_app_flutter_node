import 'package:flutter/material.dart';
import 'package:mobileapp/common/widgets/custom_button.dart';
import 'package:mobileapp/common/widgets/custom_textfield.dart';
import 'package:mobileapp/constants/global_variables.dart';
import 'package:mobileapp/constants/utils.dart';
import 'package:mobileapp/features/address/services/address_services.dart';
import 'package:mobileapp/providers/user_provider.dart';
import 'package:pay/pay.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = "/address";
  final String totalAmount;
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final flatBuildingController = TextEditingController();
  final areaController = TextEditingController();
  final pinCodeController = TextEditingController();
  final cityController = TextEditingController();
  final addressFormKey = GlobalKey<FormState>();
  List<PaymentItem> paymentItems = [];
  String addressToBeUsed = "";
  final AddressServices addressServices = AddressServices();

  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: "Total Amount",
        status: PaymentItemStatus.final_price));
  }

  @override
  void dispose() {
    super.dispose();
    flatBuildingController.dispose();
    areaController.dispose();
    cityController.dispose();
    pinCodeController.dispose();
  }

  void onApplePayResult(result) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void onGooglePayResult(result) {
    if (Provider.of<UserProvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
          context: context, address: addressToBeUsed);
    }
    addressServices.placeOrder(
        context: context,
        address: addressToBeUsed,
        totalSum: double.parse(widget.totalAmount));
  }

  void payPress(String addressFromProvider) {
    addressToBeUsed = "";
    bool isForm = flatBuildingController.text.isNotEmpty ||
        areaController.text.isNotEmpty ||
        cityController.text.isNotEmpty ||
        pinCodeController.text.isNotEmpty;
    if (isForm) {
      if (addressFormKey.currentState!.validate()) {
        addressToBeUsed =
            "${flatBuildingController.text}, ${areaController.text}, ${cityController.text} - ${pinCodeController.text}";
      } else {
        throw Exception('Please enter all the values');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnackBar(context, 'Error');
    }
    print(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    var address = context.watch<UserProvider>().user.address;
    // var address = "101 Fake Street";
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
              decoration: const BoxDecoration(
                  gradient: GlobalVariables.appBarGradient)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (address.isNotEmpty)
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.black12,
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Text(address, style: const TextStyle(fontSize: 18)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "OR",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              Form(
                key: addressFormKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: flatBuildingController,
                      hintText: "Flat, House no, Building",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: areaController,
                      hintText: "Area, Street",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: pinCodeController,
                      hintText: "Pin Code",
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      controller: cityController,
                      hintText: "Town/City",
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              ApplePayButton(
                  onPressed: () => payPress(address),
                  width: double.infinity,
                  style: ApplePayButtonStyle.whiteOutline,
                  type: ApplePayButtonType.buy,
                  paymentConfigurationAsset: 'applepay.json',
                  onPaymentResult: onApplePayResult,
                  height: 50,
                  margin: const EdgeInsets.only(top: 15),
                  paymentItems: paymentItems),
              const SizedBox(height: 10),
              GooglePayButton(
                onPressed: () => payPress(address),
                paymentConfigurationAsset: 'gpay.json',
                onPaymentResult: onGooglePayResult,
                paymentItems: paymentItems,
                style: GooglePayButtonStyle.black,
                height: 50,
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15),
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
