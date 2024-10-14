import 'package:core/utils/extensions/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('equals Ignore Case', () {
    test('check for Publicis', () {
      final String? arg = 'Publicis';
      final String exceptedArg = 'publicis';
      final actual = arg.equalsIgnoreCase(exceptedArg);
      final expected = true;
      expect(actual, expected);
    });

    test('check for PUBLICIS', () {
      final String? arg = 'PUBLICIS';
      final String exceptedArg = 'publicis';
      final actual = arg.equalsIgnoreCase(exceptedArg);
      final expected = true;
      expect(actual, expected);
    });
  });

  group('Capitalize a word', () {
    test('capitalize one char lowercase letter', () {
      final String? arg = 'a';
      final actual = arg.capitalize();
      final expected = 'A';
      expect(actual, expected);
    });
    test('capitalize one char uppercase letter', () {
      final String? arg = 'A';
      final actual = arg.capitalize();
      final expected = 'A';
      expect(actual, expected);
    });
    test('capitalize a word staring a capital letter', () {
      final String? arg = 'Abcd';
      final actual = arg.capitalize();
      final expected = 'Abcd';
      expect(actual, expected);
    });
    test('capitalize a word staring a lowercase letter', () {
      final String? arg = 'abcd';
      final actual = arg.capitalize();
      final expected = 'Abcd';
      expect(actual, expected);
    });

    test('capitalize a word mixing uppercase and lowercase', () {
      final String? arg = 'AbCd';
      final actual = arg.capitalize();
      final expected = 'Abcd';
      expect(actual, expected);
    });

    test('capitalize a word mixing lowercase and uppercase', () {
      final String? arg = 'abCd';
      final actual = arg.capitalize();
      final expected = 'Abcd';
      expect(actual, expected);
    });

    test('capitalize a word mixing numbers and special chars', () {
      final String? arg = 'abCd@123';
      final actual = arg.capitalize();
      final expected = 'Abcd@123';
      expect(actual, expected);
    });
  });

  group('Capitalize a name', () {
    test('capitalize a name only first name', () {
      final String? arg = 'adrian';
      final actual = arg.capitalizeName();
      final expected = 'Adrian';
      expect(actual, expected);
    });

    test('capitalize a name only first name with mix', () {
      final String? arg = 'aDRian';
      final actual = arg.capitalizeName();
      final expected = 'Adrian';
      expect(actual, expected);
    });

    test('capitalize a name only first name last name', () {
      final String? arg = 'adrian rusin';
      final actual = arg.capitalizeName();
      final expected = 'Adrian Rusin';
      expect(actual, expected);
    });

    test('capitalize a name only first name last name with mix', () {
      final String? arg = 'aDRian RUSIn';
      final actual = arg.capitalizeName();
      final expected = 'Adrian Rusin';
      expect(actual, expected);
    });

    test('capitalize a name only first name last name with more spaces', () {
      final String? arg = '  aDRian   RUSIn  ';
      final actual = arg.capitalizeName();
      final expected = 'Adrian Rusin';
      expect(actual, expected);
    });

    test('capitalize a name only first name last name and middle name', () {
      final String? arg = '  aDRian  middle  RUSIn  ';
      final actual = arg.capitalizeName();
      final expected = 'Adrian Middle Rusin';
      expect(actual, expected);
    });
  });

  group('test hasEmoji', () {
    test('alphabet do not have emoji', () {
      final String? arg = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz';
      final actual = arg.hasEmoji();
      final expected = false;
      expect(actual, expected);
    });

    test('numeric do not have emoji', () {
      final String? arg = '0123456789';
      final actual = arg.hasEmoji();
      final expected = false;
      expect(actual, expected);
    });

    test('special chars do not have emoji', () {
      final String? arg = '`~!@#%^&*()-_=+/|/<>,.;';
      final actual = arg.hasEmoji();
      final expected = false;
      expect(actual, expected);
    });

    test('emojis has emoji', () {
      final String? arg =
          '😀 😃 😄 😁 😆 😅 😂 🤣 🥲 ☺️ 😊 😇 🙂 🙃 😉 😌 😍 🥰 😘 😗 😙 😚 😋 😛 😝 😜 🤪 🤨 🧐 🤓 😎 🥸 🤩 🥳 😏 😒 😞 😔 😟 😕 🙁 ☹️ 😣 😖 😫 😩 🥺 😢 😭 😤 😠 😡 🤬 🤯 😳 🥵 🥶 😱 😨 😰 😥 😓 🤗 🤔 🤭 🤫 🤥 😶 😐 😑 😬 🙄 😯 😦 😧 😮 😲 🥱 😴 🤤 😪 😵 🤐 🥴 🤢 🤮 🤧 😷 🤒 🤕 🤑 🤠 😈 👿 👹 👺 🤡 💩 👻 💀 ☠️ 👽 👾 🤖 🎃 😺 😸 😹 😻 😼 😽 🙀 😿 😾' '👋 🤚 🖐 ✋ 🖖 👌 🤌 🤏 ✌️ 🤞 🤟 🤘 🤙 👈 👉 👆 🖕 👇 ☝️ 👍 👎 ✊ 👊 🤛 🤜 👏 🙌 👐 🤲 🤝 🙏 ✍️ 💅 🤳 💪 🦾 🦵 🦿 🦶 👣 👂 🦻 👃 🫀 🫁 🧠 🦷 🦴 👀 👁 👅 👄 💋 🩸' '👶 👧 🧒 👦 👩 🧑 👨 👩‍🦱 🧑‍🦱 👨‍🦱 👩‍🦰 🧑‍🦰 👨‍🦰 👱‍♀️ 👱 👱‍♂️ 👩‍🦳 🧑‍🦳 👨‍🦳 👩‍🦲 🧑‍🦲 👨‍🦲 🧔 👵 🧓 👴 👲 👳‍♀️ 👳 👳‍♂️ 🧕 👮‍♀️ 👮 👮‍♂️ 👷‍♀️ 👷 👷‍♂️ 💂‍♀️ 💂 💂‍♂️ 🕵️‍♀️ 🕵️ 🕵️‍♂️ 👩‍⚕️ 🧑‍⚕️ 👨‍⚕️ 👩‍🌾 🧑‍🌾 👨‍🌾 👩‍🍳 🧑‍🍳 👨‍🍳 👩‍🎓 🧑‍🎓 👨‍🎓 👩‍🎤 🧑‍🎤 👨‍🎤 👩‍🏫 🧑‍🏫 👨‍🏫 👩‍🏭 🧑‍🏭 👨‍🏭 👩‍💻 🧑‍💻 👨‍💻 👩‍💼 🧑‍💼 👨‍💼 👩‍🔧 🧑‍🔧 👨‍🔧 👩‍🔬 🧑‍🔬 👨‍🔬 👩‍🎨 🧑‍🎨 👨‍🎨 👩‍🚒 🧑‍🚒 👨‍🚒 👩‍✈️ 🧑‍✈️ 👨‍✈️ 👩‍🚀 🧑‍🚀 👨‍🚀 👩‍⚖️ 🧑‍⚖️ 👨‍⚖️ 👰‍♀️ 👰 👰‍♂️ 🤵‍♀️ 🤵 🤵‍♂️ 👸 🤴 🥷 🦸‍♀️ 🦸 🦸‍♂️ 🦹‍♀️ 🦹 🦹‍♂️ 🤶 🧑‍🎄 🎅 🧙‍♀️ 🧙 🧙‍♂️ 🧝‍♀️ 🧝 🧝‍♂️ 🧛‍♀️ 🧛 🧛‍♂️ 🧟‍♀️ 🧟 🧟‍♂️ 🧞‍♀️ 🧞 🧞‍♂️ 🧜‍♀️ 🧜 🧜‍♂️ 🧚‍♀️ 🧚 🧚‍♂️ 👼 🤰 🤱 👩‍🍼 🧑‍🍼 👨‍🍼 🙇‍♀️ 🙇 🙇‍♂️ 💁‍♀️ 💁 💁‍♂️ 🙅‍♀️ 🙅 🙅‍♂️ 🙆‍♀️ 🙆 🙆‍♂️ 🙋‍♀️ 🙋 🙋‍♂️ 🧏‍♀️ 🧏 🧏‍♂️ 🤦‍♀️ 🤦 🤦‍♂️ 🤷‍♀️ 🤷 🤷‍♂️ 🙎‍♀️ 🙎 🙎‍♂️ 🙍‍♀️ 🙍 🙍‍♂️ 💇‍♀️ 💇 💇‍♂️ 💆‍♀️ 💆 💆‍♂️ 🧖‍♀️ 🧖 🧖‍♂️ 💅 🤳 💃 🕺 👯‍♀️ 👯 👯‍♂️ 🕴 👩‍🦽 🧑‍🦽 👨‍🦽 👩‍🦼 🧑‍🦼 👨‍🦼 🚶‍♀️ 🚶 🚶‍♂️ 👩‍🦯 🧑‍🦯 👨‍🦯 🧎‍♀️ 🧎 🧎‍♂️ 🏃‍♀️ 🏃 🏃‍♂️ 🧍‍♀️ 🧍 🧍‍♂️ 👭 🧑‍🤝‍🧑 👬 👫 👩‍❤️‍👩 💑 👨‍❤️‍👨 👩‍❤️‍👨 👩‍❤️‍💋‍👩 💏 👨‍❤️‍💋‍👨 👩‍❤️‍💋‍👨 👪 👨‍👩‍👦 👨‍👩‍👧 👨‍👩‍👧‍👦 👨‍👩‍👦‍👦 👨‍👩‍👧‍👧 👨‍👨‍👦 👨‍👨‍👧 👨‍👨‍👧‍👦 👨‍👨‍👦‍👦 👨‍👨‍👧‍👧 👩‍👩‍👦 👩‍👩‍👧 👩‍👩‍👧‍👦 👩‍👩‍👦‍👦 👩‍👩‍👧‍👧 👨‍👦 👨‍👦‍👦 👨‍👧 👨‍👧‍👦 👨‍👧‍👧 👩‍👦 👩‍👦‍👦 👩‍👧 👩‍👧‍👦 👩‍👧‍👧 🗣 👤 👥 🫂';
      final actual = arg.hasEmoji();
      final expected = true;
      expect(actual, expected);
    });
  });

  group('Validate Name', () {
    test('validate name ' ', return true', () {
      final String? arg = '';
      final actual = arg.isNameInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate name 1234567890 , return true', () {
      final String? arg = '1234567890';
      final actual = arg.isNameInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate name 234567844 , return true', () {
      final String? arg = '234567844';
      final actual = arg.isNameInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate name @#^#@ ,return true', () {
      final String? arg = '@#^#@';
      final actual = arg.isNameInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate name Nikhil , return false', () {
      final String? arg = 'Nikhil';
      final actual = arg.isNameInvalid();
      final expected = false;
      expect(actual, expected);
    });
  });

  group('validate bank name ', () {
    test('validate bank name `` return true', () {
      final String? arg = '';
      final actual = arg.isBankNameInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate bank name  `1234567890` return true', () {
      final String? arg = '1234567890';
      final actual = arg.isBankNameInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate bank name `234567844` return true', () {
      final String? arg = '234567844';
      final actual = arg.isBankNameInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate bank name `@#^#@`return false', () {
      final String? arg = '@#^#@';
      final actual = arg.isBankNameInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate bank name ADQ, return false', () {
      final String? arg = 'ADQ';
      final actual = arg.isBankNameInvalid();
      final expected = false;
      expect(actual, expected);
    });
  });

  group('Validate city name', () {
    test('validate city name "", return true', () {
      final String? arg = '';
      final actual = arg.isCityInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate city name "1234567890", return true', () {
      final String? arg = '1234567890';
      final actual = arg.isCityInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate city name "234567844", return true', () {
      final String? arg = '234567844';
      final actual = arg.isCityInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate city name "@#^#@", return true', () {
      final String? arg = '@#^#@';
      final actual = arg.isCityInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate city name "Bengaluru", return false', () {
      final String? arg = 'Bengaluru';
      final actual = arg.isCityInvalid();
      final expected = false;
      expect(actual, expected);
    });
  });

  group('check is NULL or Empty,return true', () {
    test('passing null value', () {
      final String? arg = null;
      final actual = arg.isBlank();
      final expected = true;
      expect(actual, expected);
    });

    test('passing empty value,return true', () {
      final String? arg = '';
      final actual = arg.isBlank();
      final expected = true;
      expect(actual, expected);
    });

    test('pass sapient value,return false', () {
      final String? arg = 'sapient';
      final actual = arg.isBlank();
      final expected = false;
      expect(actual, expected);
    });
  });

  group('String Amount To Double testing', () {
    test('GBP 100.10 to double', () {
      final value = 'GBP 100.10';
      final actual = value.toDoubleAmount();
      final expected = 100.1;
      expect(actual, expected);
    });

    test('GBP 100,000,000.10 TO double', () {
      final value = 'GBP 1000,000,000.10';
      final actual = value.toDoubleAmount();
      final expected = 1000000000.1;
      expect(actual, expected);
    });

    test('GBP 1000,000,000.1 to double', () {
      final value = 'GBP 1000,000,000.1';
      final actual = value.toDoubleAmount();
      final expected = 1000000000.1;
      expect(actual, expected);
    });

    test('99.99 AUD to double', () {
      final value = '99.99 AUD';
      final actual = value.toDoubleAmount();
      final expected = 99.99;
      expect(actual, expected);
    });

    test('0.99 AUD to double', () {
      final value = '0.99 AUD';
      final actual = value.toDoubleAmount();
      final expected = 0.99;
      expect(actual, expected);
    });

    test('1000,000,000.10 AUD to double', () {
      final value = '1000,000,000.10';
      final actual = value.toDoubleAmount();
      final expected = 1000000000.1;
      expect(actual, expected);
    });
  });

  group('String Amount to string', () {
    test('"EUR 100.10" to "100.10"', () {
      final value = 'EUR 100.10';
      final actual = value.toStringAmount();
      final expected = '100.10';
      expect(actual, expected);
    });

    test('"GBP 1000,000,000.10" to 1000000000.10,', () {
      final value = 'GBP 1000,000,000.10';
      final actual = value.toStringAmount();
      final expected = '1000000000.10';
      expect(actual, expected);
    });

    test('1000,000,000.10 to 1000000000.10', () {
      final value = '1000,000,000.10';
      final actual = value.toStringAmount();
      final expected = '1000000000.10';
      expect(actual, expected);
    });
  });

  group('Testing validation of phone number', () {
    test('validate phone number "", return true', () {
      final String? arg = '';
      final actual = arg.isPhoneNumberInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate phone number "qwertyuiopasdfghjklA", return true', () {
      final String? arg = 'qwertyuiopasdfghjklA';
      final actual = arg.isPhoneNumberInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate phone number "+12345", return true', () {
      final String? arg = '+12345';
      final actual = arg.isPhoneNumberInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate phone number "+1234567890", return true', () {
      final String? arg = '+1234567890';
      final actual = arg.isPhoneNumberInvalid();
      final expected = false;
      expect(actual, expected);
    });

    test('validate phone number "+12345678901234567890", return true', () {
      final String? arg = '+12345678901234567890';
      final actual = arg.isPhoneNumberInvalid();
      final expected = false;
      expect(actual, expected);
    });

    test('validate phone number "+123456789012345678901", return true', () {
      final String? arg = '+123456789012345678901';
      final actual = arg.isPhoneNumberInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate phone number "+9903668366", return false', () {
      final String? arg = '9903668366';
      final actual = arg.isPhoneNumberInvalid(false);
      final expected = true;
      expect(actual, expected);
    });

    test('validate phone number "91-9903668366", return false', () {
      final String? arg = '91-9903668366';
      final actual = arg.isPhoneNumberInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate phone number  "42-324", return true', () {
      final String? arg = '42-324';
      final actual = arg.isPhoneNumberInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate phone number "421-24",return true', () {
      final String? arg = '421-24';
      final actual = arg.isPhoneNumberInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate phone number "580004-1",return true', () {
      final String? arg = '580004-1';
      final actual = arg.isPhoneNumberInvalid();
      final expected = true;
      expect(actual, expected);
    });
  });

  group('Validate Postal code', () {
    test('validate postal code  "", return true', () {
      final String? arg = '';
      final actual = arg.isPostalCodeInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate postal code "qwertyuiopasdfghjklA", return true', () {
      final String? arg = 'qwertyuiopasdfghjklA';
      final actual = arg.isPostalCodeInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate postal code  "1234567890", return true', () {
      final String? arg = '1234567890';
      final actual = arg.isPostalCodeInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate postal code  "42-324", return true', () {
      final String? arg = '42-324';
      final actual = arg.isPostalCodeInvalid();
      final expected = false;
      expect(actual, expected);
    });

    test('validate postal code  "421-24", return true', () {
      final String? arg = '421-24';
      final actual = arg.isPostalCodeInvalid();
      final expected = true;
      expect(actual, expected);
    });

    test('validate postal code "580004-1", return true', () {
      final String? arg = '580004-1';
      final actual = arg.isPostalCodeInvalid();
      final expected = true;
      expect(actual, expected);
    });
  });

  group(
    'When toStringAmountWithThousandSeparator extension is used on amount string to return the amount with thousand separator ',
    () {
      test(
        'Converts "100000000" to "100,000,000.00" ',
        () {
          final value = '100000000';
          final actual = value.toStringAmountWithThousandSeparator();
          final expected = '100,000,000.00';
          expect(actual, expected);
        },
      );

      test(
        'Converts "9098328932" to "9,098,328,932.00" ',
        () {
          final value = '9098328932';
          final actual = value.toStringAmountWithThousandSeparator();
          final expected = '9,098,328,932.00';
          expect(actual, expected);
        },
      );
    },
  );

  group('When isSpaceNameInvalid extension is used it return whether name is valid or not', () {
    test('check the name="Tony Stark" is a spacednamevalid or not', () {
      final value = 'Tony Stark';
      final actual = value.isSpaceNameInvalid();
      final expected = false;
      expect(actual, expected);
    });

    test('check the name="Tarzan" is a spacednamevalid or not', () {
      final value = 'Tarzan';
      final actual = value.isSpaceNameInvalid();
      final expected = false;
      expect(actual, expected);
    });

    test('check the name ="" is a spacednamevalid or not', () {
      final value = '';
      final actual = value.isSpaceNameInvalid();
      final expected = false;
      expect(actual, expected);
    });
  });

  group('When isValidEmail extension it return whether email is valid or not', () {
    test('check the email="dubai@gmail.com" is a valid mail', () {
      final value = 'dubai@gmail.com';
      final actual = value.isValidEmail();
      final expected = true;
      expect(actual, expected);
    });

    test('check the email="dubai@gmail.com" is a valid mail', () {
      final value = 'dubaigmail.com';
      final actual = value.isValidEmail();
      final expected = false;
      expect(actual, expected);
    });

    test('check the email="dubai@gmailcom" is a valid mail', () {
      final value = 'dubai@gmailcom';
      final actual = value.isValidEmail();
      final expected = false;
      expect(actual, expected);
    });

    test('check the email="dubaigmailcom" is a valid mail', () {
      final value = 'dubaigmailcom';
      final actual = value.isValidEmail();
      final expected = false;
      expect(actual, expected);
    });

    test('check the email="" is a valid mail', () {
      final value = '';
      final actual = value.isValidEmail();
      final expected = false;
      expect(actual, expected);
    });
  });

  group('Validate Date using isValidDate extension', () {
    test('Validatation for 12-12-2000 normal date', () {
      final value = '12-12-2000';
      final actual = value.isValidDate();
      final expected = true;
      expect(actual, expected);
    });

    test('Validatation for 12-12-2000 normal date', () {
      final value = '';
      final actual = value.isValidDate();
      final expected = false;
      expect(actual, expected);
    });
    test('Validatation for 12-12-1799 less 1800', () {
      final value = '12-12-1799';
      final actual = value.isValidDate();
      final expected = false;
      expect(actual, expected);
    });
    test('Validatation for 30-02-2000 which is Febraury month', () {
      final value = '30-02-2000';
      final actual = value.isValidDate();
      final expected = false;
      expect(actual, expected);
    });
    test('Validatation for 31-04-2000 which is April month', () {
      final value = '31-04-2000';
      final actual = value.isValidDate();
      final expected = false;
      expect(actual, expected);
    });
    test('Validatation for 29-02-2000 which is Leap Year', () {
      final value = '29-02-2000';
      final actual = value.isValidDate();
      final expected = true;
      expect(actual, expected);
    });
    test('Validatation for 29-02-2001 which is not a Leap Year', () {
      final value = '29-02-2001';
      final actual = value.isValidDate();
      final expected = false;
      expect(actual, expected);
    });

    test('Validatation for 29-02-2000 which is Leap Year', () {
      final value = '12-13-2001';
      final actual = value.isValidDate();
      final expected = false;
      expect(actual, expected);
    });

    test('Validatation for 20-2-2000 which is having single month digit', () {
      final value = '20-2-2000';
      final actual = value.isValidDate();
      final expected = true;
      expect(actual, expected);
    });
    test('Validatation for 29-12-20000 which is having single month digit', () {
      final value = '29-12-20000';
      final actual = value.isValidDate();
      final expected = false;
      expect(actual, expected);
    });
  });

  group('When extractWholeAmount extension is used on amount string to return the whole part of it ', () {
    test('Converts "100.98" to "100" ', () {
      final value = '100.98';
      final actual = value.extractWholeAmount();
      final expected = '100';
      expect(actual, expected);
    });

    test('Converts "932.0021" to "932" ', () {
      final value = '932.0021';
      final actual = value.extractWholeAmount();
      final expected = '932';
      expect(actual, expected);
    });

    test('Converts ' ' to "" ', () {
      final value = '';
      final actual = value.extractWholeAmount();
      final expected = '';
      expect(actual, expected);
    });
  });

  group('When extractCentAmount extension is used on amount string to return the cents part of it ', () {
    test('Converts "100.98" to ".98" ', () {
      final value = '100.98';
      final actual = value.extractCentAmount();
      final expected = '.98 ';
      expect(actual, expected);
    });

    test('Converts "932.0021" to ".0021" ', () {
      final value = '932.0021';
      final actual = value.extractCentAmount();
      final expected = '.0021 ';
      expect(actual, expected);
    });

    test('Converts "" to "" ', () {
      final value = '';
      final actual = value.extractCentAmount();
      final expected = '';
      expect(actual, expected);
    });
  });

  group('When toColor extension is used it convert the int data in color', () {
    test('Converts "0x99999999" to "Color(0x99999999)" ', () {
      final value = '0x99999999';
      final actual = value.toColor();
      final expected = Color(0x99999999);
      expect(actual, expected);
    });

    test('Converts "0xFFFFFF" to "Color(0x00FFFFFF)', () {
      final value = '0xFFFFFFF';
      final actual = value.toColor();
      final expected = Color(0x0FFFFFFF);
      expect(actual, expected);
    });

    test('Converts "0x1" to "Color(0x0000001F)', () {
      final value = '0x1';
      final actual = value.toColor();
      final expected = Color(0x00000001);
      expect(actual, expected);
    });
    test('Converts "0x1" to "Color(0x0000001F)', () {
      final value = '20';
      final actual = value.toColor();
      final expected = Color(0x00000014);
      expect(actual, expected);
    });
  });

  group('When toColor extension is used it convert the int data in color', () {
    test('Converts "0x99999999" to "Color(0x99999999)" ', () {
      final value = '0x99999999';
      final actual = value.toColorWithOpacity(0.2);
      final expected = Color(0x99999999).withOpacity(0.2);
      expect(actual, expected);
    });

    test('Converts "0xFFFFFF" to "Color(0x00FFFFFF)', () {
      final value = '0xFFFFFFF';
      final actual = value.toColorWithOpacity(0.2);
      final expected = Color(0x0FFFFFFF).withOpacity(0.2);
      expect(actual, expected);
    });

    test('Converts "0x1" to "Color(0x0000001F)', () {
      final value = '0x1';
      final actual = value.toColorWithOpacity(0.2);
      final expected = Color(0x00000001).withOpacity(0.2);
      expect(actual, expected);
    });
    test('Converts "0x1" to "Color(0x0000001F)', () {
      final value = '20';
      final actual = value.toColorWithOpacity(0.2);
      final expected = Color(0x00000014).withOpacity(0.2);
      expect(actual, expected);
    });
  });

  group('When toColor extension is used it convert the int data in color', () {
    test('Converts "1999-02-02" to "DateTime(1999,02,02)" ', () {
      final value = '1999-02-02';
      final actual = value.toDateTime();
      final expected = DateTime(1999, 02, 02);
      expect(actual, expected);
    });

    test('Converts "2012-02-04" to " DateTime(2012,02,04)" ', () {
      final value = '2012-02-04';
      final actual = value.toDateTime();
      final expected = DateTime(2012, 02, 04);
      expect(actual, expected);
    });
  });

  group('surround string with double quotes', () {
    test('Converts \'Foo\' to \'"Foo"\' ', () {
      final arg = 'Foo';
      final excepted = '"Foo"';
      final actual = arg.surroundQuotes();
      expect(actual, excepted);
    });

    test('null string should return null  ', () {
      final String? arg = null;
      final excepted = null;
      final actual = arg.surroundQuotes();
      expect(actual, excepted);
    });
  });

  group('When toColor extension is used it convert the int data in color', () {
    test('Converts "1999-02-02" to "DateTime(1999,02,02)" ', () {
      final value = '1999-02-02';
      final actual = value.formatFromDDMMYYYY();
      final expected = DateTime(02, 02, 1999);
      expect(actual, expected);
    });

    test('Converts "2012-02-04" to " DateTime(2012,02,04)" ', () {
      final value = '2012-02-04';
      final actual = value.formatFromDDMMYYYY();
      final expected = DateTime(04, 02, 2012);
      expect(actual, expected);
    });
  });

  group('isNotBlank', () {
    test('isNotBlank function testing', () async {
      final value = '';
      expect(value.isNotBlank(), false);
    });

    test('isNotBlank function testing', () async {
      final value = 'megumin';
      expect(value.isNotBlank(), true);
    });
  });

  group('dateFromISO8601Format extension testing', () {
    test('dateFromISO8601Format extension', () async {
      final date = '11-10-2020T18:30:05.006Z';
      expect(date.dateFromISO8601Format().day, 11);
    });

    test('dateFromISO8601Format extension', () async {
      final date = '11-10-2020T18:30:05.006Z';
      expect(date.dateFromISO8601Format().month, 4);
    });

    test('dateFromISO8601Format extension', () async {
      final date = '11-10-2020T18:30:05.006Z';
      expect(date.dateFromISO8601Format().hour, 18);
    });
  });

  group('containsUnsupportedEmailCharacters extension testing', () {
    test('containsUnsupportedEmailCharacters true case', () async {
      final email = 'nikgasd@email.com';
      expect(email.containsUnsupportedEmailCharacters(), false);
    });

    test('containsUnsupportedEmailCharacters false case', () async {
      final email = 'nikg@@@@@asd@email.com';
      expect(email.containsUnsupportedEmailCharacters(), true);
    });
  });

  group('getParsedDate extension testing', () {
    test('getParsedDate extension testing', () async {
      final date = '10-10-2020';
      expect(date.getParsedDate()!.day, 10);
    });

    test('getParsedDate extension testing', () async {
      final date = '10-10-2020';
      expect(date.getParsedDate()!.month, 10);
    });

    test('getParsedDate extension testing', () async {
      final date = '10-10-2020';
      expect(date.getParsedDate()!.year, 2020);
    });
  });

  group('isValidDate extension testing', () {
    test('isValidDate extension testing true case', () async {
      final date = '10-10-2020';
      expect(date.isValidDate(), true);
    });

    test('isValidDate extension testing false case', () async {
      final date = '10-10-20';
      expect(date.isValidDate(), false);
    });
  });

  group('isNotAllZeros extension testing', () {
    test('isNotAllZeros extension true case', () {
      final text = '0000';
      expect(text.isNotAllZeros, false);
    });

    test('isNotAllZeros extension false case', () {
      final text = '123123';
      expect(text.isNotAllZeros, true);
    });
  });

  group('isAlphaNumericWithSpace extension testing', () {
    test('isAlphaNumericWithSpace true case', () async {
      final text = 'abc123 123vx';
      expect(text.isAlphaNumericWithSpace(), true);
    });

    test('isAlphaNumericWithSpace true case', () async {
      final text = 'abc123123vx';
      expect(text.isAlphaNumericWithSpace(), true);
    });

    test('isAlphaNumericWithSpace false case', () async {
      final text = '@!#!@#';
      expect(text.isAlphaNumericWithSpace(), false);
    });
  });

  group('isAlphabetWithSpace extension test', () {
    test('isAlphabetWithSpace extension test true case', () {
      final text = 'abc vx';
      expect(text.isAlphabetWithSpace(), true);
    });

    test('isAlphabetWithSpace extension test true case', () {
      final text = 'abcvx';
      expect(text.isAlphabetWithSpace(), true);
    });

    test('isAlphabetWithSpace extension test false case', () {
      final text = 'abcv12312323x';
      expect(text.isAlphabetWithSpace(), false);
    });

    test('isAlphabetWithSpace extension test false case', () {
      final text = '12312323';
      expect(text.isAlphabetWithSpace(), false);
    });

    test('isAlphabetWithSpace extension test false case', () {
      final text = '!@#!@#!@#';
      expect(text.isAlphabetWithSpace(), false);
    });
  });

  group('getEmailUri function texting', () {
    test('case while subject is null', () {
      final value = 'sample@mail.com';
      final actual = value.getEmailUri(null);
      final expected = 'mailto:sample@mail.com?subject';
      expect(actual, expected);
    });
    test('case while subject is not null', () {
      final value = 'sample@mail.com';
      final actual = value.getEmailUri('Hello');
      final expected = 'mailto:sample@mail.com?subject=Hello';
      expect(actual, expected);
    });
  });
}
