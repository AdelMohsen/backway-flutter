# Feature: Delete Account

## 1. Endpoint Info
- **HTTP Method:** POST
- **Endpoint Constant:** `Endpoints.deleteAccount` (`/customer/delete-account`)
- **Requires Auth:** Yes (Token required in headers)
- **Request Type:** Body (Empty)
- **Status Codes:**
  - 200: Success
  - 401: Unauthenticated
  - 403: Forbidden

## 2. Request Flow
UI (`AppSettingsScreen` + `DeleteUserBottomSheet`) → `DeleteAccountCubit` -> `DeleteAccountRepo` → `Network().request` → Backend → `DeleteAccountModel` → `DeleteAccountCubit` → UI (`ToastService` & `Utility.logout`)

When the user confirms deletion from the bottom sheet, the cubit initiates an API request. The response is handled similarly to the Logout flow; on success, a toast appears, and the app clears the user cache and navigates to the login screen using `Utility.logout()`.

## 3. Files Created
- `lib/features/auth/delete_account/data/params/delete_account_params.dart`
- `lib/features/auth/delete_account/data/models/delete_account_model.dart`
- `lib/features/auth/delete_account/data/repository/delete_account_repo.dart`
- `lib/features/auth/delete_account/logic/state/delete_account_state.dart`
- `lib/features/auth/delete_account/logic/cubit/delete_account_cubit.dart`
- `lib/features/auth/delete_account/FEATURE_IMPLEMENTATION_LOG.md` (this file)

## 4. Params Explanation
`DeleteAccountParams` extends `Equatable`. It contains an empty `returnedMap()` because the backend only requires an authenticated token rather than a dedicated deletion request body.

## 5. Model Explanation
`DeleteAccountModel` captures the success flag and message string, mirroring the baseline success response format for authentication tear-down interactions.

## 6. Repository Logic
`DeleteAccountRepo.deleteAccount(params)` executes the POST request using the generic `Network().request()` and routes failure tracking through `ApiErrorHandler`.

## 7. State Management Logic
`DeleteAccountCubit` orchestrates identical transitions as `LogoutCubit`, surfacing `Initial`, `Loading`, `Success`, and `Error`. The UI solely depends on the global event invocations (toasts and routing) triggered within the Cubit. 

## 8. Error Handling
Delegates robust parsing logic straight cleanly to `ApiErrorHandler().handleError(error)` emitting standard `ErrorEntity`.

## 9. Localization Keys Added
The deletion implementation heavily reused pre-existing elements located within `AppSettingsScreen`, circumventing the requirement for introducing new keys into `ar.json` and `en.json`. Used `AppStrings.settingsDeleteAccountConfirm` and existing back/retry variables.

## 10. Post-Success Behavior
Displays a success toast mapping directly off the message payload sent down by the API. Subsequently, it completely strips local secure storage variables (token & user identity) before force-pushing the navigation stack to the unauthenticated module.

## 11. Post-Error Behavior
Presents a standard error toast utilizing the encapsulated `failure.message` while safely suspending the active user session without unauthenticated tear-downs on the local device.

## 12. Future Update Notes
- Similar to `Logout`, modifying global tear-down behavior across platforms hinges strictly on modifying static utilities such as `Utility.logout` or mapping authentication contexts into a system-wide `AuthenticationBloc` watcher.
