
import 'package:flutter/material.dart';

class CardDiscountCode extends StatelessWidget {
  const CardDiscountCode({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'هل لديك كود خصم؟',
              // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      hintText: ' ادخل الكودالخصم',
                      fillColor:
                          const Color.fromARGB(255, 233, 234, 237),
                      filled: true,
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
                // SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(0),
                              topRight: Radius.circular(0),
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)))),
                  child: Text('تطبيق'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

