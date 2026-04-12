abstract class Enum<T> {
  final T _value;
  const Enum(this._value);
  T get value => _value;
}

enum UserStatus { active, inactive }

/// [fromResetPassword] for ResetPasswordScreen and [fromRegister] for RegisterScreen
/// [fromChangePhoneNumber] for changing phone number in profile
/// [fromDeleteAccount] for deleting account with OTP verification
/// [fromChangePassword] for changing password with OTP verification
/// Cuz they have the same layout and behavior but different actions
enum VerifyCodeFromScreen {
  fromLogin,
  fromRegister,
  fromChangePhoneNumber,
  fromDeleteAccount,
  fromChangePassword,
}

enum FileTypeEnum { question, answer, audio, image, user_profile }

enum LangKeysConstances { ar, en }

enum MediaType { image, audio, video }

enum GenderTypes { male, female }

enum FileType { image, video }

enum LanguageOption { arabic, english }
