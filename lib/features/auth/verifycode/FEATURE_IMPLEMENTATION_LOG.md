# Feature: Dual Verification Flow (Login & Register OTP)

*Note: This feature was implemented entirely within the existing `verifycode` module to maintain architectural integrity, handle both verification scenarios correctly, and avoid code duplication.*

## 1. Endpoint Info
- **HTTP Method**: POST
- **Endpoint Constants**: 
  - `Endpoints.verifyOtpThenLogin` → `/auth/customer/verify-otp` (Login Verification)
  - `Endpoints.verifyRegisterOtp` → `/auth/customer/register/verify-otp` (Registration Verification)
- **Requires Auth**: No
- **Request Type**: Body parameter
- **Status Codes**: 200 (Success), 403 (Account not active), 4xx/5xx (Error)

## 2. Request Flow
UI (`VerifyCodeScreen`) → Cubit (`VerifyCodeCubit.verifyOtpThenLogin`) → (Checks `fromScreen` flag) → Repository (`VerifyCodeRepo.verifyRegisterOtp` OR `VerifyCodeRepo.verifyOtpThenLogin`) → Network → Backend → Model (`VerifyOtpThenLoginModel`) → Cubit caches token & user → UI listens for Success/Error.

## 3. Files Created / Modified
**Modified Files**:
- `lib/core/app_config/api_names.dart` : Added `verifyRegisterOtp` endpoint string.
- `lib/features/auth/verifycode/data/repo/verify_code_repo.dart` : Created static method `verifyRegisterOtp` matching the model signature of `verifyOtpThenLogin`.
- `lib/features/auth/verifycode/logic/verify_code_cubit.dart` : Re-introduced `fromScreen` constructor parameter, checking it to route OTP requests to the right endpoint.
- `lib/features/auth/verifycode/ui/pages/verify_code_screen.dart` : Passed `params.fromScreen` into Cubit initialization.

## 4. Params Explanation
**Class**: `VerifyOtpThenLoginParams`
- `phone`: The parsed mobile number mapped cleanly.
- `otp`: The typed 6-digit confirmation code.
- Both endpoints strictly accept identical parameters. `returnedMap()` cleans the variables before passing them into the request body.

## 5. Model Explanation
**Class**: `VerifyOtpThenLoginModel`
Both login and registration verification paths return the exact same backend entity shape:
```json
{
    "success": true,
    "message": "Account verified and activated", // Or "Logged in"
    "data": { ...user, "token": "..." }
}
```

## 6. Repository Logic
`VerifyCodeRepo` handles the dual endpoints via statically typed functions. 
- `verifyRegisterOtp` maps perfectly to `/auth/customer/register/verify-otp` via `Network().request()`.
- Captures mapping into `VerifyOtpThenLoginModel`.
- Saves cached token via `CacheMethods.saveToken`.
- Converts UserData inside the Model towards User schema via `UserModel.fromJson`, caching it using `CacheMethods.saveUser`.

## 7. State Management Logic
`VerifyCodeCubit` transitions between:
- `VerifyCodeInitial`
- `VerifyOtpLoading`
- `VerifyOtpSuccess` (carries the `VerifyOtpThenLoginModel`)
- `VerifyOtpError` (carries the `ErrorEntity`)

Depending on the `VerifyCodeFromScreen` flag (`fromRegister` or `fromLogin`), the cubit dynamically switches which repository function to await, leaving the states identical. 

## 8. Error Handling
All Network calls are caught explicitly inside `catch (error)` using the existing global singleton `ApiErrorHandler().handleError(error)`. 
These errors map safely down as a `Left(ErrorEntity)` structure flowing seamlessly back into `VerifyOtpError` within the Cubit.

## 9. Localization Keys Added
No new localization keys were added because this was an infrastructural module enhancement routing logic utilizing pre-existing toast/snackbars that already use `AppStrings`.

## 10. Post-Success Behavior
The Cubit emits `VerifyOtpSuccess(success)`. The `BlocConsumer` inside the VerifyCode feature listens for this state.
1. The token and User config are securely cached by the Repo.
2. An AnimatedLoading overlay is dismissed.
3. A success message visually pops reflecting `state.data.message`.
4. User automatically navigates to `Routes.NAV_LAYOUT`.

## 11. Post-Error Behavior
The Cubit folds the Either response into `VerifyOtpError(failure)`.
1. The framework clears the loading context overlay.
2. Dispatches a Toast indicating the server-sent `state.error.message` (e.g. Invalid or expired OTP).
3. Holds the interface stable on the `VerifyCodeScreen` preventing unnecessary back-routing and re-allowing modification of OTP inputs.

## 12. Future Update Notes
- **Extending Parameters**: If you want to log IP or DevideID inside verifying, mutate `VerifyOtpThenLoginParams` keeping equatable extensions synced.
- **Handling Resend from Verification**: Note that resending an OTP from the Registration Verification Screen actually requires verifying if the `resendOtp` endpoint matches both paths. Currently, the fallback defaults safely to Login's OTP rules.
