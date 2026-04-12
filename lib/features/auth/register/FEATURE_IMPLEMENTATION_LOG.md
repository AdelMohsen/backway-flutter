# Feature: Customer Register

## 1. Endpoint Info
- **HTTP Method**: POST
- **Endpoint Constant**: `Endpoints.register` → `/auth/customer/register`
- **Requires Auth**: No (registration flow)
- **Request Type**: Body (JSON)
- **Status Codes**: 200 (success with OTP sent), 4xx (validation/duplicate errors)

## 2. Request Flow
```
UI (RegisterScreen)
  → FormFiledRegister (validation)
  → RegisterCubit.registerUser()
  → RegisterRepo.register(RegisterParams)
  → Network().request(Endpoints.register, method: POST, body: params.returnedMap())
  → Backend
  → RegisterModel.fromJson(response.data)
  → RegisterCubit emits RegisterSuccess / RegisterError
  → UI (SuccessBottomSheet + navigate to VerifyCode / FailureBottomSheet)
```

## 3. Files Created

| File | Path |
|------|------|
| RegisterParams | `lib/features/auth/register/data/params/register_params.dart` |
| RegisterModel | `lib/features/auth/register/data/model/register_model.dart` |
| RegisterRepo | `lib/features/auth/register/data/repo/register_repo.dart` |
| RegisterCubit | `lib/features/auth/register/logic/register_cubit.dart` |
| RegisterState | `lib/features/auth/register/logic/register_state.dart` |

### Files Modified

| File | Change |
|------|--------|
| `api_names.dart` | Added `Endpoints.register` |
| `error_handler.dart` | Added `Endpoints.register` to auth screen check |
| `app_strings.dart` | Added 9 new localization keys |
| `en.json` | Added 9 English translations |
| `ar.json` | Added 9 Arabic translations |
| `form_filed_register.dart` | Added validation, controllers, location detection |
| `register_screen.dart` | Added BlocProvider, BlocListener, Form, loading state |

## 4. Params Explanation

`RegisterParams` maps to backend keys:
- `name` → `name`
- `phone` → `phone` (normalized with `966` prefix)
- `email` → `email`
- `currentLat` → `current_lat`
- `currentLng` → `current_lng`
- `address` → `address`

Null/empty values are removed via `removeWhere`.

## 5. Model Explanation

`RegisterModel` parses:
```json
{
  "success": true,      → bool success
  "message": "OTP sent" → String message
  "data": {
    "user_id": 308      → int userId
    "status": "pending"  → String status
  }
}
```

## 6. Repository Logic

- Uses `Network().request()` singleton with `ServerMethods.POST`
- Sends `params.returnedMap()` as body
- Returns `Right(RegisterModel)` on success
- Catches errors with `ApiErrorHandler().handleError(error)` returning `Left(ErrorEntity)`

## 7. State Management Logic

| State | When |
|-------|------|
| `RegisterInitial` | Default / after terms toggle |
| `RegisterLoading` | API request in progress |
| `RegisterSuccess` | API returns success |
| `RegisterError` | API error or validation failure |
| `LocationDetecting` | Getting GPS coordinates |
| `LocationDetected` | Location resolved to address |
| `LocationDetectFailed` | Location detection failed |

## 8. Error Handling

- **API errors**: `ApiErrorHandler().handleError()` → `ErrorEntity` with message from backend
- **Validation errors**: Local `ErrorEntity` built with localized message
- **Display**: `FailureBottomSheet.show()` with error message
- **401 on register**: Does NOT trigger logout (added to `isFromAuthScreen` check)

## 9. Localization Keys Added

| Key | English | Arabic |
|-----|---------|--------|
| `registerSuccess` | OTP sent successfully | تم إرسال رمز التحقق بنجاح |
| `registerFailed` | Registration failed | فشل التسجيل |
| `detectingLocation` | Detecting your location... | جاري تحديد موقعك... |
| `locationDetected` | Location detected successfully | تم تحديد الموقع بنجاح |
| `locationFailed` | Failed to detect location. Please try again. | فشل تحديد الموقع. يرجى المحاولة مرة أخرى. |
| `pleaseAcceptTerms` | Please accept the terms and conditions | يرجى الموافقة على الشروط والأحكام |
| `pleaseSelectLocation` | Please select your location first | يرجى تحديد موقعك أولاً |
| `nameValidationError` | Please enter a valid name (at least 2 characters) | يرجى إدخال اسم صحيح (حرفان على الأقل) |
| `tapToDetectLocation` | Tap to detect your location | اضغط لتحديد موقعك |

## 10. Post-Success Behavior

1. `RegisterSuccess` emitted
2. `SuccessBottomSheet.show()` with OTP sent message
3. On dismiss → navigates to `VerifyCodeScreen` with `VerifyCodeRouteParams(phoneNumber, fromScreen: fromRegister)`

## 11. Post-Error Behavior

1. `RegisterError` emitted
2. `FailureBottomSheet.show()` with error message from backend
3. User stays on register screen
4. Form data preserved

## 12. Future Update Notes

### Add New Field
1. Add field to `RegisterParams` constructor and `returnedMap()`
2. Add controller in `RegisterCubit`
3. Add form field in `FormFiledRegister`
4. Dispose controller in `RegisterCubit.close()`

### Modify Response
1. Update `RegisterModel` fields and `fromJson()`
2. Update `RegisterState.RegisterSuccess` if needed
3. Update `RegisterCubit` success handling

### Add Pagination
Not applicable for registration endpoint.

### Add Multipart Upload
1. Change `body: params.returnedMap()` to `body: FormData.fromMap(params.returnedMap())` in repository
2. Add file fields to params as needed
