import 'package:flutter/material.dart';

 errorDialog(BuildContext context){
  showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title:const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Icon(Icons.error, color: Colors.red, size: 30),
                SizedBox(width: 10),
                Text('خطأ'),
              ],
            ),
            content:const Text(
              'الكوبون غير صالح. يرجى المحاولة مرة أخرى.',
              textAlign: TextAlign.center,
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('إغلاق'),
                ),
              )
            ],
          );
        },
      );
}