import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String _name, _dob = "", _mobile, _email, _username;
  bool _secureText = true;
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordConfirm = TextEditingController();
  TextEditingController _controller = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String _passError;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.teal[100],
        body: Form(
          autovalidate: true,
          key: _formKey,
          child: ListView(
            children: <Widget>[
              BackButtonWidget(),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    //IconButton(icon: Icon(Icons.person), onPressed: null),

                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            child: TextFormField(
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return "Name Required!";
                                }
                              },
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                              /* onSaved: (String name) {
                                _name = name;
                              }, */
                              keyboardType: TextInputType.name,
                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    //IconButton(icon: Icon(Icons.person), onPressed: null),
                    Text(_dob),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            child: TextFormField(
                              validator: (value) {
                                if (value.isEmpty || value.length < 1)
                                  return "Choose DOB";
                                else
                                  return null;
                              },
                              readOnly: true,
                              onTap: () async {
                                DateTime now = DateTime.now();
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                now = await showDatePicker(
                                  context: context,
                                  initialDate: now,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2030),
                                );
                                _controller.text =
                                    DateFormat.yMMMd().format(now);
                              },
                              controller: _controller,
                              decoration: InputDecoration(
                                  labelText: 'Date of Birth',
                                  labelStyle: TextStyle(
                                      fontSize: 18.0, color: Colors.black),
                                  suffixIcon: IconButton(
                                      icon: Icon(Icons.calendar_today),
                                      onPressed: () {})),
                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    //IconButton(icon: Icon(Icons.person), onPressed: null),
                    Container(
                      /* decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(5.0)), */
                      child: CountryCodePicker(
                        initialSelection: 'IN',
                        showCountryOnly: true,
                        favorite: ['+91', 'IN'],
                        padding: EdgeInsets.all(4.0),
                      ),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(right: 20, left: 10),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Mobile No. Required!';
                          }
                          if (value.length < 10) {
                            return 'Enter valid mobile No.';
                          }
                        },
                        decoration: InputDecoration(
                          labelText: 'Mobile No.',
                          labelStyle:
                              TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        onSaved: (String mobile) {
                          _mobile = mobile;
                        },
                        keyboardType: TextInputType.phone,
                      ),
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    // IconButton(icon: Icon(Icons.mail), onPressed: null),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            child: TextFormField(
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Email Required!'),
                                EmailValidator(errorText: 'Not a valid Email!'),
                              ]),
                              decoration: InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                              onSaved: (String email) {
                                _email = email;
                              },
                              keyboardType: TextInputType.emailAddress,
                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    //IconButton(icon: Icon(Icons.person), onPressed: null),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            child: TextFormField(
                              validator: (String value) {
                                if (value.isEmpty)
                                  return "Username Required!";
                                else
                                  return null;
                              },
                              decoration: InputDecoration(
                                labelText: 'Username',
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                              ),
                              onSaved: (String username) {
                                _username = username;
                              },
                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    //IconButton(icon: Icon(Icons.lock), onPressed: null),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            child: TextFormField(
                              validator: (String value) {
                                if (value.length < 6)
                                  return "Password should be atleast 6 character!";
                                else
                                  return null;
                              },
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                                errorText: _passError,
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    setState(() {
                                      _secureText = !_secureText;
                                    });
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: _secureText,
                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: <Widget>[
                    //IconButton(icon: Icon(Icons.lock), onPressed: null),
                    Expanded(
                        child: Container(
                            margin: EdgeInsets.only(right: 20, left: 10),
                            child: TextFormField(
                              validator: (String value) {
                                if (value.isEmpty) {
                                  return 'Re-Enter Password';
                                } else if (_passwordController.text !=
                                    _passwordConfirm.text)
                                  return "Password do not match!";
                                else
                                  return null;
                              },
                              controller: _passwordConfirm,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                                errorText: _passError,
                              ),
                              obscureText: true,
                              keyboardType: TextInputType.text,
                            )))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Radio(
                        value: null,
                        groupValue: null,
                        onChanged:null 
                        ),
                    RichText(
                        text: TextSpan(
                            text: 'I have accepted the',
                            style: TextStyle(color: Colors.black),
                            children: [
                          TextSpan(
                              text: ' Terms & Condition',
                              style: TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold))
                        ]))
                    //Aggrenment()
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    height: 60,
                    child: RaisedButton(
                      
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            Navigator.pushNamed(context, 'SignIn');
                            print('Successfull');
                          } else {
                            print('Unsuccessfull');
                          }
                          _formKey.currentState.save();
                        });
                      },
                      color: Color(0xFF00a79B),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('asset/app.jpg'))),
      child: Positioned(
          child: Stack(
        children: <Widget>[
          Positioned(
              top: 20,
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                  Text(
                    'Back',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              )),
          Positioned(
            bottom: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'New StreamIt Account',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          )
        ],
      )),
    );
  }
}
