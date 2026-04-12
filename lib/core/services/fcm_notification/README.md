# FCM Notification Service for Momento App

A comprehensive Firebase Cloud Messaging (FCM) notification service specifically configured for the Momento wedding services app.

## Features

- **Firebase Cloud Messaging Integration**: Complete FCM setup with background and foreground message handling
- **Local Notifications**: Fallback local notifications when FCM is not available
- **In-App Notifications**: Custom overlay notifications with ToastService integration
- **Momento-Specific Notification Types**: Support for services, packages, bookings, payments, etc.
- **Smart Navigation**: Automatic navigation to relevant screens based on notification type
- **Topic Subscriptions**: Category, city, and user-specific topic management
- **Provider Support**: Special handling for service providers
- **Background Message Handling**: Proper handling of background messages
- **Permission Management**: Automatic notification permission requests
- **Token Management**: FCM token generation and refresh handling

## Setup

### 1. Firebase Configuration

Ensure your app is properly configured with Firebase:

1. Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files
2. Firebase is already configured in `init_main_functions.dart`

### 2. Automatic Initialization

FCM is automatically initialized when the app starts:

```dart
// Already configured in init_main_functions.dart
await FCMIntegrationHelper.initializeFCM();
```

### 3. Handle User Login

When a user logs in, subscribe to relevant topics:

```dart
// After successful login with user preferences
await FCMIntegrationHelper.initializeForUser(
  userId: 123,
  preferredCategoryIds: [1, 2, 3], // Wedding categories
  preferredCityIds: [10, 20], // Preferred cities
  providerId: 456, // If user is a service provider
);
```

### 4. Handle User Logout

When a user logs out, clean up subscriptions:

```dart
// Before logout
await FCMIntegrationHelper.cleanupOnLogout(
  123, // userId
  providerId: 456, // If user was a provider
);
```

## Momento-Specific Usage

### Notification Types Supported

The service handles these Momento-specific notification types:

- **booking**: Wedding booking confirmations and updates
- **service**: Service-related notifications (photographers, venues, etc.)
- **package**: Wedding package deals and updates
- **order**: Order status and confirmations
- **payment**: Payment confirmations and reminders
- **promotion**: Special offers and discounts
- **favourite**: Favourite item updates
- **cart**: Cart reminders and updates
- **provider**: Notifications for service providers
- **general**: General app notifications

### Smart Navigation

Notifications automatically navigate to the appropriate screens:

```dart
// Service notification -> Service Details Screen
// Package notification -> Product Details Screen
// Booking notification -> My Orders Screen
// Cart notification -> Cart Screen
// Favourite notification -> Favourites Screen
```

### Custom Notification Data Format

Send notifications with Momento-specific data:

- Graceful fallbacks for missing permissions
- Logging for debugging
- Safe navigation handling
- Null safety throughout

## Dependencies Required

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  firebase_messaging: ^14.7.9
  flutter_local_notifications: ^16.3.0
```

## Platform Configuration

### Android

Add to `android/app/src/main/AndroidManifest.xml`:

```xml
<meta-data
  android:name="com.google.firebase.messaging.default_notification_channel_id"
  android:value="high_importance_channel" />
```

### iOS

Add notification capability in `ios/Runner/Runner.entitlements`:

```xml
<key>aps-environment</key>
<string>development</string>
```

## Testing

### Test Notification Payload

```json
{
  "to": "FCM_TOKEN_HERE",
  "notification": {
    "title": "Test Notification",
    "body": "This is a test notification"
  },
  "data": {
    "type": "auction",
    "auction_id": "123",
    "action": "navigate"
  }
}
```

## Best Practices

1. **Always check initialization**: Use `FCMIntegrationHelper.isInitialized()`
2. **Handle token refresh**: Update server when token changes
3. **Manage topics properly**: Subscribe on login, unsubscribe on logout
4. **Test all scenarios**: Foreground, background, and terminated states
5. **Handle permissions**: Request permissions gracefully
6. **Use appropriate channels**: Different channels for different notification types

## Troubleshooting

### Common Issues

1. **Notifications not received**: Check FCM token and server configuration
2. **Background handler not working**: Ensure function is top-level
3. **Navigation not working**: Check route definitions and context availability
4. **Permissions denied**: Handle permission requests properly

### Debug Tips

- Check console logs for FCM-related messages
- Verify Firebase project configuration
- Test with Firebase Console first
- Check device notification settings

## Integration Checklist

- [ ] Firebase project configured
- [ ] FCM dependencies added
- [ ] Platform-specific configuration done
- [ ] FCM initialized in main.dart
- [ ] Background handler registered
- [ ] Topic subscriptions implemented
- [ ] Navigation routes configured
- [ ] Testing completed for all scenarios

## Support

For issues or questions regarding this FCM notification module, please check:

1. Firebase documentation
2. Flutter local notifications documentation
3. Platform-specific notification guidelines
4. This module's implementation details
