import 'package:fashion_store/provider/services/size_config.dart';
import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(7),
        ),
        child: const Center(
          child: Text(
            "Payment",
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
