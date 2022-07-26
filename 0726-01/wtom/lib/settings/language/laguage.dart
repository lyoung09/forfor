import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ko_KR': {
          'hello': '안녕하세요',
          'settings': '설정',
          'news': '뉴스',
          'posting': '글',
          'You can ask anything.\n But do not sexual and political and religious asking!':
              '무엇이든지 물어보세요\n 그러나 성과 종교이야기는 하지말아주세요!',
        },
        'ja_JP': {'hello': 'こんにちは', 'settings': '서루정루'},
        'en_US': {
          'hello': 'Hello',
          'settings': 'settings',
          'news': 'news',
          'You can ask anything.\n But do not sexual and political and religious asking!':
              'You can ask anything.\n But do not sexual and political and religious asking!'
        },
      };
}
