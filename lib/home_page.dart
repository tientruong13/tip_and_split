import 'dart:ui';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:flutter/material.dart';
import 'package:tip_and_split_bill/Build_page.dart';
import 'package:tip_and_split_bill/sms/sms.dart';
import './greeting.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:intl/intl.dart';
import './sms/sms.dart';




class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   Future<Null> sending_SMS(String msg, List<String> list_receipents) async {
    print("SendSMS");
    try{
      String send_result = await sendSMS(message: msg, recipients: list_receipents);
      print(send_result);
    } catch (e) {
      print(e.toString());
    }
   }

DateTime now = DateTime.now();
String formattedDate = DateFormat('E, MMM d yyyy, HH:mm a').format(DateTime.now());

  double _bill = 0;
  int _tipPercentage = 0;
  int _numberOfPeople = 1;
  
  // This is the default Number Of People
  static const defaultNumberOfPeople = 1;
  final _billController = TextEditingController();
  final _tipPercentageController = TextEditingController();
  final _numberOfPeopleController =
      TextEditingController(text: defaultNumberOfPeople.toString());

  List<String> selectedCategory = [];
  String category1 = '5';
  String category2 = '10';
  String category3 = '15';
  String category4 = '25';
  String category5 = '30';

@override
  void initState() {
    /// This is the `event listeners` of the TextEditingControllers
    /// implemented using the [addListener] method
    ///
    _billController.addListener(_onBillAmountChanged);
    _tipPercentageController.addListener(_onTipAmountChanged);
    _numberOfPeopleController.addListener(_numberOfPeopleChanged);
    super.initState();
  }

  _onBillAmountChanged() {
    setState(() {

      _bill = double.tryParse(_billController.text) ?? 0;
      
    });
  }

  _onTipAmountChanged() {
    setState(() {

      _tipPercentage = int.tryParse(_tipPercentageController.text) ?? 0;
    });
  }

  _numberOfPeopleChanged() {
    setState(() {

      _numberOfPeople = int.tryParse(_numberOfPeopleController.text) ?? 1;
    });
  }

  
  _getTipAmount() => ((_bill * _tipPercentage) / 100);
  

  _getPersonAmount() => (((_bill * _tipPercentage) / 100) + _bill) / _numberOfPeople;

  _getTotalAmount() => (_bill + ((_bill * _tipPercentage) / 100));

  _resetButtonAction() {
    setState(() {
      selectedCategory = [];
      _bill = 0;
      _tipPercentage = 0;
      _numberOfPeople = 1;
      _billController.clear();
      _tipPercentageController.clear();
      _numberOfPeopleController.clear();
    });
  }

  @override
  void dispose() {
   
    _billController.dispose();
    _tipPercentageController.dispose();
    _numberOfPeopleController.dispose();
    _billController.removeListener(_onBillAmountChanged);
    _tipPercentageController.removeListener(_onTipAmountChanged);
    _numberOfPeopleController.removeListener(_numberOfPeopleChanged);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width * (.35);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(

        appBar: AppBar(title: Text(greeting()), centerTitle: true, backgroundColor: Color.fromARGB(255, 0, 46, 82) , ),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          var totalSMS;
          var tipSMS;
          var personSMS;
          var billSMS;
          billSMS= _billController.text;
          totalSMS= _getTotalAmount().toStringAsFixed(2);
          tipSMS= _getTipAmount().toStringAsFixed(2);
          personSMS = _getPersonAmount().toStringAsFixed(2);

        sending_SMS("Bill Amount: \$$billSMS, Tip $_tipPercentage%: \$$tipSMS, Total: \$$totalSMS, Split ($_numberOfPeople): \$$personSMS, $formattedDate", ["0"]); 
    
        },
          
          child: AvatarGlow(child: Icon(Icons.sms_sharp), endRadius:30, glowColor: Color.fromARGB(182, 250, 187, 203),),
          backgroundColor: Color.fromARGB(185, 228, 0, 43),elevation: 2,
          ),
        body: Stack(
          
           
          children: <Widget> [
             
            Container(
              decoration: BoxDecoration(
            gradient: LinearGradient(
               begin: Alignment.topRight,
                end: Alignment.bottomLeft,
              colors: [
                const Color.fromARGB(255, 0, 191, 255),
                const Color.fromARGB(255, 187, 2, 215),
              ],
            )
          ),
              
            ),
            
            
                Align(
              alignment: Alignment(0.0, -0.98),

              child: AvatarGlow(child: Icon(Icons.add, size:10, color:Colors.black.withOpacity(0.5)), 
              endRadius:80,
              // glowColor: Colors.white,
              )),
            Align(
              alignment: Alignment(0.0, -0.98),
              child: Container(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: MediaQuery.of(context).size.width * 0.43,
                height: MediaQuery.of(context).size.width * 0.43,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    color: Colors.black.withOpacity(0.5),
                    boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 20,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  ),
                  child: Column(
                    children: [
                      createColumnTextWidget(
                        textName1: "Total",
                        fontSize1: 20,
                        spaceBeweent: MediaQuery.of(context).size.height*0.03,
                        textName2:"${_getTotalAmount().toStringAsFixed(2)}",
                        fontSize2: 35
                      ),
                      
                    ],
                  )
                  

              ),
              
                ),

            Align(
                  alignment: Alignment(0.95, -0.75),
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                width: MediaQuery.of(context).size.width * 0.32,
                height: MediaQuery.of(context).size.width * 0.32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    color: Colors.black.withOpacity(0.5),
                   boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 20,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  ),
                  child: Column(
                    children: [
                      createColumnTextWidget(
                        textName1: "Split",
                        fontSize1: 20,
                        spaceBeweent: MediaQuery.of(context).size.height*0.02,
                        textName2: "${_getPersonAmount().toStringAsFixed(2)}",
                        fontSize2: 25
                      )
                    ],
                  )

                  )
                  
                ),
            Align(
                  alignment: Alignment(-0.95, -0.75),
                  child: Container(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                width: MediaQuery.of(context).size.width * 0.32,
                height: MediaQuery.of(context).size.width * 0.32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(300),
                    color: Colors.black.withOpacity(0.5),
                    boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 20,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                  ),
                  child: Column(
                    children: [
                      createColumnTextWidget(
                        textName1: "Tip",
                        fontSize1: 20,
                        spaceBeweent: MediaQuery.of(context).size.height*0.02,
                        textName2: "${_getTipAmount().toStringAsFixed(2)}",
                        fontSize2: 25
                      )
                    ],
                  )
                  )
                ),
                
                 
               
                Positioned(
                right: 20.0,
                left: 20.0,
                bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                
                height: MediaQuery.of(context).size.height*0.60,
                  width:double.infinity,
                  decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        createTextWidget(
                      name: "Bill Amount: "
                    ),
                    SizedBox(height:MediaQuery.of(context).size.height*0.013),
                    Container(
                      height: MediaQuery.of(context).size.height*0.055,
                      child: createTextFieldWidget(
                        controller: _billController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        hintText: "Your Bill",
                        preFixIcon: const Icon(Icons.attach_money_rounded)
                        ),
                    ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02),
                      Column(
                            children: [
                              Row(children: [
                                createTextWidget(
                                  name:"Select Tip %"
                                )
                              ]),
                              SizedBox(height: MediaQuery.of(context).size.height*0.013),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children: [
                                  toggleButton(category1, width),
                                  toggleButton(category2, width),
                                  toggleButton(category3, width),
                                  toggleButton(category4, width),
                                  toggleButton(category5, width),
                                  selectTipPercentageInfo(width),
                                ],
                              )
                            ],
                          ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02),
                      createTextWidget(
                        name: "Number of People"
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.013),
                      Container(
                        height: MediaQuery.of(context).size.height*0.055,
                        child: createTextFieldWidget(
                        controller: _numberOfPeopleController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        hintText: "Number of People",
                        preFixIcon: const Icon(Icons.people_alt_rounded)
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*0.02),
                      ],
                    ),
                    
                    Container(
                      width: width,
                      height: MediaQuery.of(context).size.height*0.055,
                      child: ElevatedButton(
                            onPressed: (){_resetButtonAction();}, 
                            child: Text("RESET"),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 0, 191, 255),
                              shadowColor: Colors.white54,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                 ),
                              textStyle: TextStyle(                            
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                              ),
                            ),),
                    ),
                  ],
                ),
              )
            ),

          ],
        ),
      )
    );
  }
  GestureDetector toggleButton(String category, double width) {
    return GestureDetector(
      onTap: () {
        _tipPercentageController.clear();
        selectedCategory = [];
        selectedCategory.add(category);
        debugPrint(selectedCategory.toString());

        int selectedTip = int.parse(selectedCategory[0]);
        debugPrint(selectedTip.toString());
        setState(() {
          _tipPercentage = selectedTip;
        });
      },
      child: Container(
        width: width,
        height: MediaQuery.of(context).size.height*0.055,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selectedCategory.contains(category)
              ? Color.fromARGB(255, 34, 209, 200)
              : Color.fromARGB(255, 0, 191, 255),
          borderRadius: BorderRadius.circular(200),
        ),
        child: Text(
          '$category%',
          style: TextStyle(
            fontSize: 20,
            color: selectedCategory.contains(category)
                ? Color.fromARGB(255, 0, 73, 77)
                : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
    Widget selectTipPercentageInfo(double width) {
    return Container(
      width: width,
      height:MediaQuery.of(context).size.height*0.055,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 191, 255),
        borderRadius: BorderRadius.circular(300),
      ),
      child: TextFormField(
        controller: _tipPercentageController,
        onTap: () => selectedCategory = [],
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: false),
        textAlign: TextAlign.end,
        decoration: const InputDecoration(
          suffixIcon: Icon(Icons.percent, color: Colors.white),
          contentPadding: EdgeInsets.symmetric(vertical: 11),
          hintText: 'Custom',
          hintStyle: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          // hintTextDirection: TextDirection.rtl,
          border: InputBorder.none,
          // fillColor: Colors.white,
        ),
      ),
    );
  }

}