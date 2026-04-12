# Feature: Open Chat (Negotiation)

## 1. Endpoint Info
- **HTTP Method**: POST
- **Endpoint Constant**: `Endpoints.openChat(int orderId) => '/chat/order/$orderId/open'`
- **Requires Auth**: Yes (handled automatically by `Network().request`)
- **Request Type**: Path parameter (`orderId`), empty body
- **Status Codes**: 200 OK (Success), 401/40X (Error handled by `ApiErrorHandler`)

## 2. Request Flow
UI (`OfferCard`) → `OpenChatCubit` → `OpenChatRepository` → `Network().request` → Backend → `OpenChatModel` → `OpenChatCubit` → UI (`BlocConsumer` listener navigates or shows error).

The UI wraps `OfferActionButtons` in a `BlocProvider` and `BlocConsumer` for `OpenChatCubit`. When the Negotiation button is tapped, it calls `openChat(orderId)`. On loading, the button displays a native `CircularProgressIndicator`. On success, it reads the retrieved `orderId` or the existing `orderId` and navigates to `Routes.NEGOTIATION_OFFERS`. On error, it displays a `CustomToast.showError()`.

## 3. Files Created
1. `lib/features/offers/data/params/open_chat_params.dart`
2. `lib/features/offers/data/models/open_chat_model.dart`
3. `lib/features/offers/data/repository/open_chat_repository.dart`
4. `lib/features/offers/logic/state/open_chat_state.dart`
5. `lib/features/offers/logic/cubit/open_chat_cubit.dart`
6. `lib/features/offers/OPEN_CHAT_FEATURE_IMPLEMENTATION_LOG.md`

## 4. Params Explanation
`OpenChatParams` extends `Equatable` and contains `returnedMap()` which maps what the API needs. Since the HTTP method is a POST but relies exclusively on the path parameter (`orderId`), `returnedMap()` is empty (`{}`).

## 5. Model Explanation
`OpenChatModel` models the response with `success`, `message`, and `data`. The nested `OpenChatData` contains a `ChatDetails` object with the fields `id` and `orderId`, which directly maps to the `data.chat` received from the backend, avoiding over-engineering while securing type safety.

## 6. Repository Logic
`OpenChatRepository` contains a static `openChat` method. It delegates the HTTP POST request to `Network().request()`, capturing the response. If the `statusCode` is 200 and the structure is valid, we decode the response JSON block into `OpenChatModel`. Otherwise, it maps errors via `ApiErrorHandler().handleError(e)`.

## 7. State Management Logic
`OpenChatCubit` handles emitting states for the process:
- `OpenChatInitial`: At object creation.
- `OpenChatLoading`: Request sent, shows progress indicator.
- `OpenChatSuccess`: Holds the serialized `OpenChatModel`.
- `OpenChatError`: Emits whenever the Left side of the `Either` error mapping catches an `ErrorEntity`.

## 8. Error Handling
The `Network().request()` wrapped code sits in a try/catch block sending arbitrary catches and explicit API errors into `ApiErrorHandler().handleError()`, converting exceptions and backend format issues into a cohesive `ErrorEntity`. The UI layer catches `OpenChatError` and pulls `error.message` for `CustomToast.showError()`.

## 9. Localization Keys Added
- Added `negotiation` in `app_strings.dart`.
- Added `"negotiation": "Negotiation"` to `en.json`.
- Added `"negotiation": "تفاوض"` to `ar.json`.

## 10. Post-Success Behavior
The Bloc listener catches `OpenChatSuccess`, navigating the user directly to `Routes.NEGOTIATION_OFFERS`, preserving workflow integrity while providing the necessary `orderId`.

## 11. Post-Error Behavior
The user remains on the screen. The button ceases spinning. An error displays via `CustomToast.showError()`.

## 12. Future Update Notes
- **Add new field**: If the request demands new body params or query parameters, insert them inside `OpenChatParams`, map inside `returnedMap()`, and update `Network().request()`.
- **Modify response**: If more driver/customer data becomes requisite, expand `OpenChatModel` properties or reconstruct from full responses.
- **Add pagination later**: Pagination conceptually misaligns for singular-action creation endpoints, but updating data fetching processes requires injecting pagination flags inside equivalent request wrappers.
