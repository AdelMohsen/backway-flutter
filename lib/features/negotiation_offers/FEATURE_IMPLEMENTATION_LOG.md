# Feature: Negotiation Offers (Chat)

## 1. Endpoint Info
- **GET Chat History**: `Endpoints.orderChat(int orderId)` → `/chat/order/{orderId}`
- **POST Send Message**: `Endpoints.sendOrderChatMessage(int orderId)` → `/chat/order/{orderId}/message`
- **Requires Auth**: Yes (Inherited from `Network().request()`)
- **Request Types**:
  - GET: Query Parameter (lang, page) and Path Parameter (orderId)
  - POST: FormData body (`message`, `type`, optional `attachment` as MultipartFile)
- **Status Codes**: 200 (Success) / 401 (Unauthenticated)

## 2. Request Flow
### Chat History
UI `NegotiationOffersScreen` → `NegotiationOffersCubit.fetchNegotiations()` → `NegotiationOffersRepository.getOrderChat` → `Network().request` → Parses `NegotiationOffersModel` → Emits `NegotiationOffersSuccess` → UI renders messages.

### Send Message
UI `NegotiationInputArea._sendMessage()` → `NegotiationOffersCubit.sendMessage()` → `NegotiationOffersRepository.sendMessage` (FormData) → `Network().request` POST → Backend → Real-time event via Pusher adds message.

### Real-time (Pusher)
`PusherCubit` (reusable) connects → Subscribes to `private-order.{orderId}` → Listens for `message.sent` → Parses `NegotiationMessageModel` → Inserts into messages list → Emits `NegotiationOffersNewMessage` + haptic feedback → UI smooth scrolls to bottom. Also listens `messages.read` event.

## 3. Files Created / Modified
- `data/params/negotiation_offers_params.dart`
- `data/params/send_message_params.dart` (NEW)
- `data/models/negotiation_offers_model.dart`
- `data/repository/negotiation_offers_repository.dart` (Modified — added `sendMessage`)
- `logic/cubit/negotiation_offers_cubit.dart` (Modified — send, Pusher, haptic)
- `logic/state/negotiation_offers_state.dart` (Modified — 3 new states)
- `ui/pages/negotiation_offers.dart` (Modified — MultiBlocProvider, Pusher banner, scroll, snackbar)
- `ui/widgets/negotiation_app_bar.dart`
- `ui/widgets/negotiation_message_bubble.dart` (Modified — image support, zoom)
- `ui/widgets/negotiation_input_area.dart` (Modified — image picker, preview, send)
- `core/navigation/app_router.dart`
- `core/app_config/api_names.dart` (Modified — `sendOrderChatMessage`)
- `core/app_config/app_config.dart` (Modified — Pusher credentials updated)
- `core/services/pusher/pusher_cubit.dart` (NEW — reusable)
- `core/services/pusher/pusher_state.dart` (NEW — reusable)
- `core/utils/widgets/misc/default_network_image.dart` (Uncommented and fixed)

## 4. Pusher Integration
- **Package**: `pusher_channels_flutter: ^2.2.1` (already in pubspec)
- **Config**: `AppConfig.PUSHER_APP_ID = '2128028'`, `PUSHER_API_KEY = '421f0d0824504886ac64'`, `PUSHER_API_CLUSTER = 'ap2'`
- **Auth**: Bearer token via `CacheMethods.getToken()` sent to `PUSHER_AUTH_ENDPOINT`
- **Channel**: `private-order.{orderId}`
- **Events**:
  - `message.sent` → Parses message JSON, deduplicates by ID, inserts at top, haptic feedback
  - `messages.read` → Refreshes state (for future read receipts)
- **Connection States**: `PusherConnecting`, `PusherConnected`, `PusherReconnecting`, `PusherDisconnected`, `PusherError` → UI shows status banners

## 5. Send Message Flow
1. User types message and/or picks image from gallery
2. Image preview shown above input with remove button
3. Send button shows loading spinner while sending
4. `SendMessageParams` builds FormData with `MultipartFile` for image
5. On success, Pusher event adds message to list
6. On error, `SnackBar` shown with error message, input preserved

## 6. Image Attachment
- **Picker**: `image_picker: ^1.2.1` (already in pubspec) — gallery only, images only
- **Preview**: 80×80 thumbnail with red close button
- **Send**: `type: 'image'`, message optional, `attachment: MultipartFile`
- **Display**: `DefaultNetworkImage` in bubble, tap to zoom via `InteractiveViewer` (min 1x, max 4x)

## 7. Advanced UX Features
- **Loading**: CircularProgressIndicator on send button during message send
- **Smooth Scroll**: `ScrollController.animateTo(0.0)` on new message (reverse list)
- **Haptic Feedback**: `HapticFeedback.lightImpact()` on incoming message
- **Error Handling**: SnackBar for send errors, status banner for Pusher connection issues
- **Pusher Status Banner**: Visual indicators for connecting/reconnecting/disconnected/error states

## 8. State Management
- `NegotiationOffersSendingMessage` — while message is being sent
- `NegotiationOffersSendMessageError` — when send fails (with `ErrorEntity`)
- `NegotiationOffersNewMessage` — when real-time message arrives (with message data)

## 9. Error Handling
Global API error handling applies via `ApiErrorHandler().handleError()`. Send errors show snackbar and re-emit success state to maintain message list. Pusher errors show connection status banner.

## 10. Future Update Notes
- **Read Receipts**: `messages.read` event is captured but visual read indicators not yet implemented
- **Opponent Checking**: `isMe` relies on `message.senderId != targetUser?.id`
- **Pagination**: Infinite scroll unchanged, check `_isLastPage` in cubit
- **PusherCubit**: Reusable across features — just inject and subscribe to channels
