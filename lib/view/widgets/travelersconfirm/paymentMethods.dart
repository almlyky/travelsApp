import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:travelapp2/controller/reservationcontroller.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({
    super.key,
    required this.reservationcontroller,
  });

  final Reservationcontroller reservationcontroller;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(
                  'طريقة الدفع',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              GetBuilder<Reservationcontroller>(
                builder: (controller) => Column(
                  children: [
                    RadioListTile<String>(
                      title: Text('الدفع نقداً'),
                      value: 'cash',
                      groupValue: reservationcontroller.paymentMethod,
                      onChanged: reservationcontroller.onChangeRadio,
                    ),
                    RadioListTile<String>(
                        title: Text('التحويل البنكي'),
                        value: 'transfer',
                        groupValue:
                            reservationcontroller.paymentMethod,
                        onChanged:
                            reservationcontroller.onChangeRadio),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
