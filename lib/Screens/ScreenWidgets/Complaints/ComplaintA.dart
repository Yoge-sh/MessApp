import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mess/Screens/ScreenWidgets/Complaints/Widgets/complaintChart.dart';

class ComplaintA extends StatefulWidget {
  static const routeName = '/complaintA';

  @override
  State<ComplaintA> createState() => _ComplaintState();
}

class _ComplaintState extends State<ComplaintA> {
  bool isLoading = false;
  Widget showList(snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.data!.docs.length,
      itemBuilder: (context, index) {
        DocumentSnapshot doc = snapshot.data!.docs[index];

        return Dismissible(
          key: Key(doc.id),
          onDismissed: (direction) async {
            if (direction == DismissDirection.endToStart) {
              await FirebaseFirestore.instance
                  .runTransaction((transaction) async {
                await FirebaseFirestore.instance
                    .collection("complaints")
                    .doc(doc.id)
                    .delete();
                String type = doc.get('type');
                var complaintCountDocumentRef = await FirebaseFirestore.instance
                    .collection('complaintsCount')
                    .doc('7av1p8pWqBb7iPWZk0Hd');
                var complaintCountDocument =
                    await transaction.get(complaintCountDocumentRef);
                await transaction.update(complaintCountDocumentRef,
                    {type: complaintCountDocument[type] - 1});
              });
            } else if (direction == DismissDirection.startToEnd) {
              FirebaseFirestore.instance
                  .collection("complaintsCount")
                  .doc("doc.id")
                  .update({'verified': true});
            }
          },
          background: deleteBgItem(),
          child: Card(
            elevation: 7,
            child: ListTile(
              leading: Icon(Icons.food_bank_rounded,
                  color: doc['status'] ? Colors.green[600] : Colors.red[600]),
              title: TextButton(
                child: Text(
                  doc['complaint'],
                  overflow: TextOverflow.ellipsis,
                ),
                onPressed: () {
                  String fullComplaint = doc['complaint'];
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Center(
                        child: AlertDialog(
                          icon: Icon(
                            Icons.report_problem,
                          ),
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(32.0),
                            ),
                          ),
                          title: Text("Complaint"),
                          content: Container(
                            height: 100.h,
                            width: 500.w,
                            child: Center(
                              child: SingleChildScrollView(
                                child: Text(
                                  fullComplaint,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 1, 56, 112),
                                      fontFamily: 'Nunito'),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ),
                          actions: [
                            Center(
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF3F5C94),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Close",
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.verified,
                  color:
                      doc['verified'] == true ? Colors.green : Colors.blueGrey,
                ),
                onPressed: () {
                  String id = doc.id;
                  FirebaseFirestore.instance
                      .collection("complaints")
                      .doc(id)
                      .update(
                    {
                      'verified': !doc['verified'],
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget deleteBgItem() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      color: Colors.red[600],
      child: Icon(Icons.delete),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('complaints').snapshots(),
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(left: 30.w, right: 30.w),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      ComplaintChart(),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Complaint History",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ((snapshot.hasData) && ((snapshot.data!.docs.length > 0)))
                          ? Expanded(
                              child: showList(snapshot),
                            )
                          : Column(
                              children: [
                                SizedBox(
                                  height: 30.h,
                                ),
                                Text(
                                  'Awesome!!! \n There are no complaints.',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
