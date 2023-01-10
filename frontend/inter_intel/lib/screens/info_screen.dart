import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:inter_intel/models/models.dart';
import 'package:inter_intel/services/services.dart';
import 'package:get/get.dart';
import 'package:inter_intel/screens/screens.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  late String digits;
  PhoneNumber number = PhoneNumber(isoCode: 'KE');
  bool loading = false;

  void _registerUser() async{
    ApiResponse response = await register(
        nameController.text.toString(),
        emailController.text,
        digits);
    if(response.error == null){
      //_saveThenRedirectToHome(response.data as User);
    }
    else{
      setState(() {
        loading = false;
      });
      Get.snackbar(
        'Sorry, try again',
        response.error!,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
  }

  getPhoneNumber(String phoneNumber) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'KE');
    setState(() {
      this.number = number;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:  () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: AnimateGradient(
          primaryBegin: Alignment.topLeft,
          primaryEnd: Alignment.bottomLeft,
          secondaryBegin: Alignment.bottomLeft,
          secondaryEnd: Alignment.topRight,
          primaryColors: const [
            Colors.pink,
            Colors.pinkAccent,
            Colors.white,
          ],
          secondaryColors: const [
            Colors.white,
            Colors.amber,
            Colors.yellow,
          ],
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                title: const Text('Info', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),),
                  leading: IconButton(
                    icon: const Icon(FontAwesomeIcons.arrowLeftLong, color: Colors.blue,),
                    onPressed: () {},
                  ),
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(15, 30, 15, 5),
                sliver: SliverToBoxAdapter(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(color: Colors.blue),
                    controller: nameController ,
                    decoration: InputDecoration(
                      label: const Text('Full name', style: TextStyle(fontSize: 15, color: Colors.blue),),
                      prefixIcon: const Icon(FontAwesomeIcons.user, size: 20, color: Colors.blue,),
                      hintText: "  Full name",
                      hintStyle: const TextStyle(color: Colors.blue),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                sliver: SliverToBoxAdapter(
                  child: TextFormField(
                    textCapitalization: TextCapitalization.sentences,
                    style: const TextStyle(color: Colors.blue),
                    controller: emailController ,
                    decoration: InputDecoration(
                      label: const Text('Email', style: TextStyle(fontSize: 15, color: Colors.blue),),
                      prefixIcon: const Icon(FontAwesomeIcons.envelope, size: 20, color: Colors.blue,),
                      hintText: "  Email",
                      hintStyle: const TextStyle(color: Colors.blue),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 10, 15, 30),
                sliver: SliverToBoxAdapter(
                  child: InternationalPhoneNumberInput(
                    //inputBorder: InputBorder.none,
                    onInputChanged: (PhoneNumber number) {
                      digits = number.phoneNumber!;
                      //print(number.phoneNumber);
                    },
                    onInputValidated: (bool value) {
                      //print(value);
                    },
                    selectorConfig: const SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    ),
                    ignoreBlank: false,
                    autoValidateMode: AutovalidateMode.disabled,
                    selectorTextStyle: const TextStyle(color: Colors.black),
                    initialValue: number,
                    textFieldController: phoneController,
                    formatInput: false,
                    keyboardType:
                    const TextInputType.numberWithOptions(signed: true, decimal: true),
                    inputBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 1.5,
                      ),
                    ),
                    inputDecoration: InputDecoration(
                      label: const Text('Phone number', style: TextStyle(fontSize: 15, color: Colors.blue),),
                      prefixIcon: const Icon(FontAwesomeIcons.phone, size: 20, color: Colors.blue,),
                      hintText: "  Phone number",
                      hintStyle: const TextStyle(color: Colors.blue),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                          width: 2,
                        ),
                      ),
                    ),
                    onSaved: (PhoneNumber number) {
                      setState(() {
                        digits = number.toString();
                      });
                    },
                  ),
                ),),

              SliverPadding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                sliver: SliverToBoxAdapter(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          fixedSize: const Size(100, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50))),
                      onPressed:() {
                        if(nameController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Missing fields'),));
                          return;
                          }
                          else{
                          Navigator.push(context, MaterialPageRoute(builder: (_) => NavScreen(selectedIndex: 1,),),);
                            _registerUser();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Account created'),));


                        }
                        },
                      child: const Text('Submit'))
                ),),

            ],
          ),
        ),
      ),
    );
  }
}
