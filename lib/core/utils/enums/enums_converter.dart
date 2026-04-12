import '../../shared/blocs/main_app_bloc.dart';
import 'enums.dart';

class UserEnumsConverter {
  static UserStatus intToUserStatus(int? value) {
    switch (value) {
      case 1:
        return UserStatus.active;
      case 0:
        return UserStatus.inactive;
      default:
        return UserStatus.active;
    }
  }

  static int userStatusToInt(UserStatus value) {
    switch (value) {
      case UserStatus.active:
        return 1;
      case UserStatus.inactive:
        return 0;
    }
  }
}

class GenderTypeConverter {
  static GenderTypes? stringToGenderType(String? gender) {
    switch (gender) {
      case 'male':
        return GenderTypes.male;
      case 'female':
        return GenderTypes.female;
      default:
        return null;
    }
  }
}

class FileTypeConverter {
  static FileType stringToFileType(String fileType) {
    switch (fileType) {
      case 'image':
        return FileType.image;
      case 'video':
        return FileType.video;
      default:
        return FileType.image;
    }
  }
}

class PaymentMethodTransaferConverter {
  static String stringToPaymentMethodTransafer(String paymentMethodTransafer) {
    switch (paymentMethodTransafer) {
      case 'bank_account':
        return mainAppBloc.isArabic ? 'حساب بنكي' : 'Bank transfer';
      case 'bank_card':
        return mainAppBloc.isArabic ? 'بطاقه خصم مباشر/إئتمان' : 'Credit card';
      default:
        return '';
    }
  }
}

class OrderTypeConverter {
  static String stringToOrderType(String orderType) {
    switch (orderType.toLowerCase()) {
      case 'package':
        return mainAppBloc.isArabic ? 'باقه' : 'Package';
      case 'service':
        return mainAppBloc.isArabic ? 'خدمه' : 'Service';
      default:
        return '';
    }
  }
}
