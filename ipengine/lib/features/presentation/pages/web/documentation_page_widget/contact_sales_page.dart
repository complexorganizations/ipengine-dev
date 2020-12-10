import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';



class ContactSalesPage extends StatefulWidget {


  @override
  _ContactSalesPageState createState() => _ContactSalesPageState();
}

class _ContactSalesPageState extends State<ContactSalesPage> {
  static Country _selectedFilteredDialogCountry =
  CountryPickerUtils.getCountryByPhoneCode("61");

  String _countryCode = _selectedFilteredDialogCountry.phoneCode;
  String _phoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.blue),
            ),
            Container(
              margin: EdgeInsets.only(top: 80, left: 200, right: 200,bottom: 80),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.1),
                  spreadRadius: 4,
                  blurRadius: 2,
                )
              ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact Sales",
                    style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Fill out the from, including details about your next project (or business goals), and we'll be in touch shortly.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Your Info",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "First Name",
                              hintStyle: TextStyle(fontSize: 18)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Last Name",
                              hintStyle: TextStyle(fontSize: 18)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Business Email",
                              hintStyle: TextStyle(fontSize: 18)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Business Number",
                              hintStyle: TextStyle(fontSize: 18),
                            prefixIcon: Container(
                              width: 80,
                              child: Row(
                                children: [
                                  InkWell(
                                      onTap: _openFilteredCountryPickerDialog,
                                      child: _buildDialogItem(_selectedFilteredDialogCountry))
                                ],
                              ),
                            )
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Job title",
                              hintStyle: TextStyle(fontSize: 18)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Interested In",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Google Workspace",
                              hintStyle: TextStyle(fontSize: 18),
                            suffixIcon: Icon(Icons.arrow_drop_down)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Your Company",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Company Name",
                              hintStyle: TextStyle(fontSize: 18)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Number of employees",
                              hintStyle: TextStyle(fontSize: 18),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "Professional & Business Services",
                              hintStyle: TextStyle(fontSize: 18),
                            suffixIcon: Icon(Icons.arrow_drop_down),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: "United States",
                              hintStyle: TextStyle(fontSize: 18),
                            suffixIcon:Icon(Icons.arrow_drop_down)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 40,),
                  SizedBox(height: 40,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Text("How we can help you?",style: TextStyle(fontSize: 18),),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Your question",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: TextField(
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: "",
                              hintStyle: TextStyle(fontSize: 18),
                              suffixIcon: Icon(Icons.arrow_drop_down)
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          "Your question",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 45,
                              alignment: Alignment.center,
                              width: 150,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(Radius.circular(8),)
                              ),
                              child: Text("Submit",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,color: Colors.white),),
                            ),
                            Text("")
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _openFilteredCountryPickerDialog() {
    showDialog(
        context: context,
        builder: (_) => Theme(
          data: Theme.of(context).copyWith(
            primaryColor: Colors.green,
          ),
          child: CountryPickerDialog(
            titlePadding: EdgeInsets.all(8.0),
            searchCursorColor: Colors.black,
            searchInputDecoration: InputDecoration(
              hintText: "Search",
            ),
            isSearchable: true,
            title: Text("Select your phone code"),
            onValuePicked: (Country country) {
              setState(() {
                _selectedFilteredDialogCountry = country;
                _countryCode = country.phoneCode;
              });
            },
            itemBuilder: _buildDialogItem,
          ),
        ));
  }

  Widget _buildDialogItem(Country country) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          // bottom: BorderSide(color: greenColor, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              CountryPickerUtils.getDefaultFlagImage(country),
              SizedBox(width: 5,),
              Text(country.phoneCode)
            ],
          ),
          Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }
}
