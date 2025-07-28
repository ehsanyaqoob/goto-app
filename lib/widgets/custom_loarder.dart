import 'package:goto/Constants/exports.dart';


class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black26,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF3A3B92)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Static method to show the loader
  static void show() {
    Get.dialog(
      const CustomLoader(),
      barrierDismissible: false, // Prevent dismissing the loader by tapping outside
    );
  }

  // Static method to hide the loader
  static void hide() {
    if (Get.isDialogOpen == true) {
      Get.back(); // Close the loader dialog
    }
  }
}
