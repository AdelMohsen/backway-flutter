# Feature: Logout

## 1. Endpoint Info
- **HTTP Method:** POST
- **Endpoint Constant:** `Endpoints.logout` (`/customer/logout`)
- **Requires Auth:** Yes (Token required in headers)
- **Request Type:** Body (Empty)
- **Status Codes:**
  - 200: Success
  - 401: Unauthenticated
  - 403: Forbidden

## 2. Request Flow
UI (`MoreScreen` + `LogoutUserBottomSheet`) → `LogoutCubit` -> `LogoutRepo` → `Network().request` → Backend → `LogoutModel` → `LogoutCubit` → UI (`ToastService` & `Utility.logout`)

When the user confirms the logout via the bottom sheet, the cubit triggers an API request to the backend. The response is folded; on success, a toast appears, and the app clears the user cache and navigates to the login screen using `Utility.logout()`.

## 3. Files Created
- `lib/features/auth/logout/data/params/logout_params.dart`
- `lib/features/auth/logout/data/models/logout_model.dart`
- `lib/features/auth/logout/data/repository/logout_repo.dart`
- `lib/features/auth/logout/logic/state/logout_state.dart`
- `lib/features/auth/logout/logic/cubit/logout_cubit.dart`
- `lib/features/auth/logout/FEATURE_IMPLEMENTATION_LOG.md` (this file)

## 4. Params Explanation
`LogoutParams` extends `Equatable`. It contains an empty `returnedMap()` because the logout API endpoint only requires an authenticated request via headers without a body.

## 5. Model Explanation
`LogoutModel` captures the success and message keys from the API response to acknowledge successful token invalidation on the backend.

## 6. Repository Logic
`LogoutRepo` contains a static `logout()` method. It leverages the global `Network().request()` wrapped in a try-catch block to return `Either<ErrorEntity, LogoutModel>`.

## 7. State Management Logic
`LogoutCubit` implements basic states: `Initial`, `Loading`, `Success`, `Error`. Upon successful completion, it relies on global actions rather than complex consumer listening mechanisms to dictate UI reaction.

## 8. Error Handling
`LogoutRepo` catches Dio exceptions and delegates parsing to `ApiErrorHandler().handleError(error)` to produce an `ErrorEntity` globally understood across the codebase.

## 9. Localization Keys Added
- `loggedOutSuccessfully`
- `logoutConfirmationTitle`
- `logoutConfirmationSubtitle`

## 10. Post-Success Behavior
The application pops a green success toast via `ToastService` and executes `Utility.logout()`, triggering secure storage deletion for cached data (`CacheMethods.clearCachedLogin`) and a navigation stack reset towards the initial unauthenticated layer (`Routes.LOGIN`).

## 11. Post-Error Behavior
The user receives an error toast containing the backend's failure reason, but securely remains authenticated locally since discarding the token depends entirely upon verifying the correct teardown via the API.

## 12. Future Update Notes
- To intercept 401 errors globally regardless of direct repository calls, investigate logic residing within `core/services/error_handler/error_handler.dart`.
