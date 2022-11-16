import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mess/models/complaint_model.dart';

class ComplaintBox extends StatelessWidget {
  final List<ComplaintModel> complaints;
  const ComplaintBox(this.complaints);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 149.h,
        child: complaints.isEmpty
            ? Column(
                children: [
                  SizedBox(height: 30.h),
                  Text(
                    'Awesome!! \n There are no complaints.',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.h),
                ],
              )
            : Container(
                //height: 100,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20.r),
                //     color: Colors.white),
                child: ListView.builder(itemBuilder: (ctx, index) {
                return Card(
                  elevation: 7,
                  child: ListTile(
                    leading: Icon(Icons.food_bank_rounded),
                    title: Text(complaints[index].titleOfComplaint),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ),
                );
              })));
  }
}
