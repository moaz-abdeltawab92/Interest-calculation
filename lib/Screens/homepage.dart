import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
// rupees هي عملة في الهند

class _HomeScreenState extends State<HomeScreen> {
  var _currencies = ["Dollar", "Rupees", "Pound"];
  var _currentSelectedItem = "Rupees";
  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();
  var displayresult = "";
  var _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 67, 159, 234),
          centerTitle: true,
          title: Text(
            "Calculator",
            style: TextStyle(
                color: Colors.black, fontSize: 23, fontWeight: FontWeight.bold),
          ),
        ),
        body: Form(
          key: _formkey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Image.asset(
                "images/mm.webp",
                height: 200,
                //  width: 200,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: principalController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter principal amount";
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Principal Amount",
                    hintText: "Enter Principal Amount e.g 15000",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
              SizedBox(height: 15),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter rate of interest";
                  }
                },
                controller: rateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Rate of Interest",
                    hintText: "Enter in percentage e.g 15",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter term";
                        }
                      },
                      controller: termController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Term",
                          hintText: "Terms in Years e.g 10",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                          )),
                    ),
                  ),
                  // Spacer(
                  //   flex: 1,
                  // ),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButton(
                      items: _currencies.map((value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (newSelectedValue) {
                        setState(() {
                          this._currentSelectedItem = newSelectedValue!;
                        });
                      },
                      value: _currentSelectedItem,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          if (_formkey.currentState!.validate())
                            this.displayresult = calculateInterst();
                        });
                      },
                      child: Text("Calculate")),
                  SizedBox(width: 15),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          resetFields();
                        });
                      },
                      child: Text("Reset"))
                ],
              ),
              SizedBox(height: 15),
              Center(child: Text("Result: $displayresult")),
            ],
          ),
        ));
  }

  String calculateInterst() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(rateController.text);
    double term = double.parse(termController.text);
    double totalpayable = principal + (principal * roi * term) / 100;
    String result =
        "After $term years, your investment will be worth $totalpayable $_currentSelectedItem";
    return result;
  }

  void resetFields() {
    principalController.text = "";
    rateController.text = "";
    termController.text = "";
    displayresult = "";
    _currentSelectedItem = _currencies[0];
  }
}
