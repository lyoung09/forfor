import 'package:get/state_manager.dart';

import 'package:get/get.dart';

class gcategoryController extends GetxController {
  var count = 0.obs;

  void changeCatagory(int _selectd) {
    count = _selectd.obs;
  }

  @override
  void onInit() {
    super.onInit();
    once(count, (_) {
      print('$_이 처음으로 변경되었습니다.');
    });
    ever(count, (_) {
      print('$_이 변경되었습니다.');
    });
    debounce(
      count,
      (_) {
        print('$_가 마지막으로 변경된 이후, 1초간 변경이 없습니다.');
      },
      time: Duration(seconds: 1),
    );
    interval(
      count,
      (_) {
        print('$_가 변경되는 중입니다.(1초마다 호출)');
      },
      time: Duration(seconds: 1),
    );
  }
}
