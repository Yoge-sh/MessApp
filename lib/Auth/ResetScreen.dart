import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  var _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text('Reset Password'),backgroundColor: Colors.blue[900],elevation: 5),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF003366),
              Color(0xFF000A12),
            ],
          ),
        ),
        child: Center(
          child: Column(
          children: [
            SizedBox(height: 50,),
            Image.network('https://cdn-icons-png.flaticon.com/512/1000/1000984.png',height: 200,width: 300,),
            SizedBox(height: 20,),
            Text('No worries we\'ve got you covereed',style: TextStyle(color: Colors.white,fontSize: 15),),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your registered email',
                      hintStyle: TextStyle(fontSize: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.all(16),
                      fillColor: Colors.blueGrey,
                    ),
                    // decoration: InputDecoration(
                    //     hintText: 'Email',
                    //   filled: true, //<-- SEE HERE
                    //   fillColor: Colors.blueGrey,
                    // ),
                    onChanged: (value) {
                      setState(() {
                        _email = value.trim();
                      });
                    },
                  ),
                ),
              ),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(//onPressed: null,
                  child: Text('Send Request',style: TextStyle(color: Colors.white,fontSize: 15),),
                  onPressed: () {
                    auth.sendPasswordResetEmail(email: _email);
                    Navigator.of(context).pop();
                  },
                  //color: Theme.of(context).accentColor,
                ),

              ],
            ),

          ],
          ),
        ),
      ),
    );
    // return Scaffold(
    //   //appBar: AppBar(title: Text('Reset Password'),),
    //   body: Column(
    //     children: [
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: TextField(
    //           keyboardType: TextInputType.emailAddress,
    //           decoration: InputDecoration(
    //               hintText: 'Email'
    //           ),
    //           onChanged: (value) {
    //             setState(() {
    //               _email = value.trim();
    //             });
    //           },
    //         ),
    //       ),
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //
    //
    //         ],
    //       ),
    //
    //     ],),
    // );
  }
}
