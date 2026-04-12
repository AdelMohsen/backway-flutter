# Feature: Enable Notification

## 1. Endpoint Info
- **HTTP Method**: PUT
- **Endpoint Constant**: `Endpoints.enableNotification` → `/customer/notifications`
- **Requires Auth**: Yes (Bearer token injected automatically by `Network()`)
- **Request Type**: Body (JSON)
- **Status Codes**: 200 OK (success), 401 Unauthenticated (error)

## 2. Request Flow
```
UI (Switch toggle)
  → EnableNotificationCubit.toggleNotification(bool)
    → EnableNotificationRepo.toggleNotification(params)
      → Network().request(Endpoints.enableNotification, method: PUT, body: params.returnedMap())
        → Backend responds with EnableNotificationModel
          → Cubit emits Success/Error
            → UI shows Toast + updates switch / reverts switch
```

## 3. Files Created

| File | Path |
|------|------|
| Params | `lib/features/enable_notification/data/params/enable_notification_params.dart` |
| Model | `lib/features/enable_notification/data/models/enable_notification_model.dart` |
| Repository | `lib/features/enable_notification/data/repository/enable_notification_repo.dart` |
| State | `lib/features/enable_notification/logic/state/enable_notification_state.dart` |
| Cubit | `lib/features/enable_notification/logic/cubit/enable_notification_cubit.dart` |
| Log | `lib/features/enable_notification/FEATURE_IMPLEMENTATION_LOG.md` |

### Files Modified

| File | Change |
|------|--------|
| `core/app_config/api_names.dart` | Added `enableNotification` endpoint |
| `core/utils/constant/app_strings.dart` | Added 3 localization keys |
| `assets/langs/ar.json` | Added Arabic translations |
| `assets/langs/en.json` | Added English translations |
| `features/user/entity/user_entity.dart` | Added `notificationsEnabled` field |
| `features/user/model/user_model.dart` | Parse `notifications_enabled` from API |
| `features/settings/ui/pages/app_settings_screen.dart` | Integrated cubit + shimmer + toast |

## 4. Params Explanation
`EnableNotificationParams` maps:
- `notificationsEnabled` (bool) → `"notifications_enabled"` in JSON body

Extends `Equatable` with `returnedMap()` method.

## 5. Model Explanation
`EnableNotificationModel` parses:
```json
{
  "success": true,
  "message": "تم تحديث إعدادات الإشعارات",
  "data": {
    "notifications_enabled": false
  }
}
```
- `success` (bool?)
- `message` (String?)
- `data` → `NotificationSettingsData` with `notificationsEnabled` (bool?)

## 6. Repository Logic
Static method `EnableNotificationRepo.toggleNotification()`:
- Uses `Network().request()` with `ServerMethods.PUT`
- Body from `params.returnedMap()`
- Returns `Either<ErrorEntity, EnableNotificationModel>`
- Catches errors via `ApiErrorHandler().handleError(error)`

## 7. State Management Logic
Sealed class `EnableNotificationState`:
- `EnableNotificationInitial` → default state
- `EnableNotificationLoading` → shimmer shown on the switch area
- `EnableNotificationSuccess(data)` → switch updated, toast shown, user profile refreshed
- `EnableNotificationError(error)` → switch reverted, error toast shown

## 8. Error Handling
- On `DioException` or any exception → `ApiErrorHandler().handleError()` builds `ErrorEntity`
- `EnableNotificationError` state carries the `ErrorEntity`
- UI shows `ToastService.showError(state.error.message, context)`
- Switch value is reverted to previous state

## 9. Localization Keys Added

| Key | English | Arabic |
|-----|---------|--------|
| `notificationsEnabled` | Notifications enabled successfully | تم تفعيل الإشعارات بنجاح |
| `notificationsDisabled` | Notifications disabled successfully | تم إيقاف الإشعارات بنجاح |
| `failedToUpdateNotifications` | Failed to update notifications status | فشل في تحديث حالة الإشعارات |

## 10. Post-Success Behavior
1. Switch updates to reflect the new value from backend response
2. Success toast is shown (enabled/disabled message based on state)
3. `UserCubit.getUserProfile()` is called to re-sync user data + cache

## 11. Post-Error Behavior
1. Switch reverts to its previous value
2. Error toast is shown with the error message
3. User stays on screen

## 12. Future Update Notes

### Add new field
- Add to `EnableNotificationParams.returnedMap()` and `EnableNotificationModel.fromJson()`

### Modify response
- Update `EnableNotificationModel` and `NotificationSettingsData` models

### Add pagination later
- Not applicable for this feature (single toggle action)

### Change HTTP method
- Update `ServerMethods.PUT` in `EnableNotificationRepo`
