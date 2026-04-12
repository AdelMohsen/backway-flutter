# Bottom Sheets Usage Guide

This document explains how to use the reusable bottom sheet widgets in the application.

## Available Bottom Sheets

### 1. Success Bottom Sheet
Located at: `lib/core/utils/widgets/bottom_sheets/success_bottom_sheet.dart`

**Features:**
- Green check icon with decorative elements
- Customizable title and subtitle
- Auto-dismissible
- Optional callback on dismiss

**Usage Example:**
```dart
import 'package:greenhub/core/utils/widgets/bottom_sheets/success_bottom_sheet.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

// Show success bottom sheet
SuccessBottomSheet.show(
  context,
  title: AppStrings.accountCreatedSuccessTitle.tr,
  subtitle: AppStrings.accountCreatedSuccessMessage.tr,
  onDismiss: () {
    // Optional: Navigate to another screen or perform action
    Navigator.pushReplacementNamed(context, '/home');
  },
);
```

### 2. Failure Bottom Sheet
Located at: `lib/core/utils/widgets/bottom_sheets/failure_bottom_sheet.dart`

**Features:**
- Red X icon with decorative elements
- Customizable title and subtitle
- Optional retry button
- Optional back to login button
- Callbacks for both buttons

**Usage Example:**
```dart
import 'package:greenhub/core/utils/widgets/bottom_sheets/failure_bottom_sheet.dart';
import 'package:greenhub/core/utils/constant/app_strings.dart';
import 'package:greenhub/core/utils/extensions/extensions.dart';

// Show failure bottom sheet
FailureBottomSheet.show(
  context,
  title: AppStrings.accountCreationFailedTitle.tr,
  subtitle: AppStrings.accountCreationFailedMessage.tr,
  retryButtonText: AppStrings.tryAgain.tr,
  backToLoginText: AppStrings.backToLogin.tr,
  onRetry: () {
    // Retry the action
    _registerUser();
  },
  onBackToLogin: () {
    // Navigate back to login
    Navigator.pushReplacementNamed(context, '/login');
  },
);
```

## Integration Example in Register Screen

```dart
// In your register screen button onPressed:
DefaultButton(
  text: AppStrings.saveData.tr,
  onPressed: () async {
    try {
      // Attempt to register user
      final result = await registerUser();
      
      if (result.success) {
        // Show success bottom sheet
        SuccessBottomSheet.show(
          context,
          title: AppStrings.accountCreatedSuccessTitle.tr,
          subtitle: AppStrings.accountCreatedSuccessMessage.tr,
          onDismiss: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        );
      } else {
        // Show failure bottom sheet
        FailureBottomSheet.show(
          context,
          title: AppStrings.accountCreationFailedTitle.tr,
          subtitle: AppStrings.accountCreationFailedMessage.tr,
          retryButtonText: AppStrings.tryAgain.tr,
          backToLoginText: AppStrings.backToLogin.tr,
          onRetry: () {
            // Retry registration
          },
          onBackToLogin: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
        );
      }
    } catch (e) {
      // Handle error
    }
  },
)
```

## Available Translation Keys

### Success Messages
- `accountCreatedSuccessTitle` - "تم إنشاء الحساب بنجاح!" / "Account Created Successfully!"
- `accountCreatedSuccessMessage` - "سعداء بك معنا! جاهز لبدء رحلة التوصيل الذكية؟" / "We're happy to have you! Ready to start your smart delivery journey?"

### Failure Messages
- `accountCreationFailedTitle` - "فشل إنشاء الحساب" / "Account Creation Failed"
- `accountCreationFailedMessage` - "يبدو أن الرقم أو البريد الإلكتروني مستخدم مسبقًا..." / "It seems the phone number or email is already in use..."

### Button Labels
- `tryAgain` - "جرب مرة اخرى" / "Try Again"
- `backToLogin` - "عودة لتسجيل الدخول" / "Back to Login"

## Customization

Both bottom sheets support:
- Custom titles and subtitles
- RTL layout (automatically handled)
- Theme colors from `AppColors`
- Text styles from `AppTextStyles`
- Translation support via `.tr` extension
