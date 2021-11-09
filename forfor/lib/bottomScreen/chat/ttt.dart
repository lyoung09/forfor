import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class Content extends StatelessWidget {
  final FocusNode _nodeText7 = FocusNode();
  final FocusNode _nodeText8 = FocusNode();
  //This is only for custom keyboards
  final custom1Notifier = ValueNotifier<String>("0");
  final custom2Notifier = ValueNotifier<Color>(Colors.blue);

  /// Creates the [KeyboardActionsConfig] to hook up the fields
  /// and their focus nodes to our [FormKeyboardActions].
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText7,
          footerBuilder: (_) => CounterKeyboard(
            notifier: custom1Notifier,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: _buildConfig(context),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              KeyboardCustomInput<String>(
                focusNode: _nodeText7,
                height: 65,
                notifier: custom1Notifier,
                builder: (context, val, hasFocus) {
                  return Container(
                    alignment: Alignment.center,
                    color: hasFocus! ? Colors.grey[300] : Colors.white,
                    child: Text(
                      'message.text',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A quick example "keyboard" widget for counter value.
class CounterKeyboard extends StatelessWidget
    with KeyboardCustomPanelMixin<String>
    implements PreferredSizeWidget {
  final ValueNotifier<String> notifier;

  CounterKeyboard({Key? key, required this.notifier}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(200);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredSize.height,
      child: EmojiPicker(
          onEmojiSelected: (Category category, Emoji emoji) {
            // _onEmojiSelected(emoji);
          },
          onBackspacePressed: () {},
          config: Config(
              columns: 7,
              // Issue: https://github.com/flutter/flutter/issues/28894
              //emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
              verticalSpacing: 0,
              horizontalSpacing: 0,
              initCategory: Category.RECENT,
              bgColor: const Color(0xFFF2F2F2),
              indicatorColor: Colors.blue,
              iconColor: Colors.grey,
              iconColorSelected: Colors.blue,
              progressIndicatorColor: Colors.blue,
              backspaceColor: Colors.blue,
              showRecentsTab: true,
              recentsLimit: 28,
              noRecentsText: 'No Recents',
              noRecentsStyle:
                  const TextStyle(fontSize: 20, color: Colors.black26),
              tabIndicatorAnimDuration: kTabScrollDuration,
              categoryIcons: const CategoryIcons(),
              buttonMode: ButtonMode.MATERIAL)),
    );
  }
}
