import 'package:flutter/material.dart';

class PaymentData extends StatelessWidget {
  const PaymentData({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'بيانات الدفع',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 8),
              Text('الحساب البنكي السعودي:'),
              Text('SA5005000068203602282000 - مصرف الإنماء'),
              SizedBox(height: 10),
              Text('الحساب البنكي اليمني :'),
              Text('3025931016 / 3013280327 - الكريمي'),
            ],
          ),
        ),
      ),
    );
  }
}