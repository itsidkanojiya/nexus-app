import 'package:flutter_easyloading/flutter_easyloading.dart';

class Loader {
  onLoading() async {
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );
  }

  onDone() async {
    await EasyLoading.dismiss();
  }

  onSuccess({msg}) async {
    await EasyLoading.showSuccess('$msg');
  }

  onError({msg}) async {
    await EasyLoading.showInfo('$msg');
  }
}
