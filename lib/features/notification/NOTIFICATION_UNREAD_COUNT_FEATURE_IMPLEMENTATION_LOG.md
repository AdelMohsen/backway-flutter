# Feature: Notification Unread Count

## 1. Endpoint Info
- **HTTP Method**: GET
- **Endpoint Constant**: `Endpoints.notificationUnreadCount = '/notifications/unread-count'`
- **Requires Auth**: Yes (handled automatically via `Network().request()`)
- **Request Type**: No query or body parameters.
- **Status Codes**: 200 OK (Success), 401/40X (Error handled by `ApiErrorHandler`)

## 2. Request Flow
UI (`HomeHeaderSliver`) → `NotificationUnreadCountCubit` → `NotificationUnreadCountRepository` → `Network().request` → Backend → `NotificationUnreadCountModel` →  Cubit → UI (Updating badge status).

The UI injects a `BlocProvider` and a `BlocBuilder` locally into `home_header_sliver.dart` for the notification icon. The underlying Cubit runs a `getUnreadCount()` method and triggers a background polling mechanism (`Timer.periodic`) operating every minute. If `unreadCount` > 0, the UI reacts immediately to toggle the red badge indicator. 

## 3. Files Created
1. `lib/features/notification/data/params/notification_unread_count_params.dart`
2. `lib/features/notification/data/models/notification_unread_count_model.dart`
3. `lib/features/notification/data/repository/notification_unread_count_repository.dart`
4. `lib/features/notification/logic/state/notification_unread_count_state.dart`
5. `lib/features/notification/logic/cubit/notification_unread_count_cubit.dart`
6. `lib/features/notification/NOTIFICATION_UNREAD_COUNT_FEATURE_IMPLEMENTATION_LOG.md`

## 4. Params Explanation
`NotificationUnreadCountParams` extends `Equatable` and possesses `returnedMap()` fetching an empty map `{}` as there are no requisite query params for this request.

## 5. Model Explanation
`NotificationUnreadCountModel` extracts `success` as a boolean safely, and mapping `unread_count` properly into `unreadCount` as an integer.

## 6. Repository Logic
`NotificationUnreadCountRepository.getUnreadCount()` uses the native static request class `Network().request()`. If successful, it parses utilizing `.fromJson()` and returns a `Right`. Upon exception, it uses `ApiErrorHandler().handleError(e)` and returns a `Left`.

## 7. State Management Logic
`NotificationUnreadCountCubit` drives the periodic polling via Dart's `Timer.periodic(const Duration(minutes: 1))`, firing silently in the background. It utilizes existing standard sealed class states (`Initial`, `Loading`, `Success`, `Error`). 

## 8. Error Handling
The standard `Either<ErrorEntity, Model>` structure controls potential failure outputs. Within the background fetching nature of the logic, the `Error` status safely remains tracked in Cubit state but operates entirely silently to avoid breaking UX (does not trigger arbitrary error toast notifications during offline/timeout drops).

## 9. Localization Keys Added
None requisite based purely on silent polling operations.

## 10. Post-Success Behavior
Upon `NotificationUnreadCountSuccess`, the listener reads `state.model.unreadCount`. If strictly greater than 0, `hasBadge: true` lights the home_header_sliver badge. 

## 11. Post-Error Behavior
The user visually remains unaffected. Background ping failures will map to state locally waiting comfortably for the subsequent periodic tick out of the 60 seconds lifecycle to repair the fetch without stalling standard usability.

## 12. Future Update Notes
- **Add new field**: Edit `NotificationUnreadCountModel` properties to ingest expanded properties (e.g. detailed types of unread).
- **Modify response**: Modify parsing if backend adjusts structure.
- **Add pagination later**: Conceptually invalid for counts.
