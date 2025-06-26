import 'package:flutter/material.dart';

import 'error_dialog.dart';
import 'succesful_dialog.dart';

void validateCoupon(String coupon, BuildContext context) {
  // Dummy coupon validation logic
  if (coupon is String) {
    // Close dialog
    Navigator.pop(context);

    // Show success message
    successfulDialog(context);
  } else {
    // Close dialog
    Navigator.pop(context);

    // Show error message
    errorDialog(context);
  }
}
