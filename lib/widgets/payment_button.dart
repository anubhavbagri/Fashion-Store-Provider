import 'package:fashion_store/provider/services/size_config.dart';
import 'package:flutter/material.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ElevatedButton(
      onPressed: () {
        var snackBar = SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            content: Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
                SizedBox(
                  width: SizeConfig.safeHorizontal! * .02,
                ),
                const Text('Payment successful!'),
              ],
            ),
            duration: Duration(seconds: 2));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.black,
        elevation: 0,
        fixedSize: Size(
            SizeConfig.safeHorizontal! * .85, SizeConfig.safeVertical! * .07),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7.0),
        ),
      ),
      child: Text(
        "Payment",
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
