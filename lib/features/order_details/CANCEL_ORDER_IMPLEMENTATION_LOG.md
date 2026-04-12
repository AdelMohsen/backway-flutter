# Feature: Order Cancel

## 1. Endpoint Info
- HTTP Method: POST
- Endpoint Constant: `/customer/orders/$id/cancel`
- Requires Auth: Yes (handled contextually by `Network().request()`)
- Request Type: Body (`{"reason": "string"}`)
- Status Codes:
  - 200/Success: `{ "success": true, "message": "..." }`
  - Error: `{ "message": "..." }`

## 2. Request Flow
UI (OrderDetailsCancelBottomSheet) → Cubit (CancelOrderDetailsCubit) → Repository (CancelOrderDetailsRepository) → Network → Backend → Model (CancelOrderResponseModel) → Cubit (CancelOrderDetailsState) → UI

When the user taps "Cancel Order" in `OrderDetailsScreen`, the `OrderDetailsCancelBottomSheet` is shown. Entering a reason and confirming triggers `cancelOrder()` on the Cubit, which talks to the repository. The repo calls `Network().request(POST,...body)`, parses it, and returns Either. The Cubit emits Success or Error, changing UI state appropriately (Toasts and navigation).

## 3. Files Created
- `lib/features/order_details/data/params/cancel_order_params.dart`
- `lib/features/order_details/data/models/cancel_order_model.dart`
- `lib/features/order_details/data/repository/cancel_order_repository.dart`
- `lib/features/order_details/logic/cubit/cancel_order_cubit.dart`
- `lib/features/order_details/logic/state/cancel_order_state.dart`
- `lib/features/order_details/ui/widgets/order_details_cancel_bottom_sheet.dart`

## 4. Params Explanation
`CancelOrderParams` receives a `reason` String. `returnedMap()` checks if it's not empty, then injects `{'reason': reason}` which gets passed directly into the Network body. The `orderId` is passed directly to the repository as a path parameter rather than being in the body.

## 5. Model Explanation
`CancelOrderResponseModel` mimics the success JSON:
```json
{
    "success": true,
    "message": "Order cancelled successfully"
}
```
Only contains `success` (bool) and `message` (String). Uses `fromJson()` to safely extract.

## 6. Repository Logic
Uses static method `CancelOrderDetailsRepository.cancelOrder({orderId, params})`.
Builds the path via `Endpoints.cancelOrder(orderId)`.
Sends a POST with `params.returnedMap()`.
Returns `Either<ErrorEntity, CancelOrderResponseModel>`. Error handling goes directly through `ApiErrorHandler().handleError(error)`.

## 7. State Management Logic
- `CancelOrderDetailsInitial`: Idle.
- `CancelOrderDetailsLoading`: Spinning indicator on button.
- `CancelOrderDetailsSuccess`: Returns `CancelOrderResponseModel`.
- `CancelOrderDetailsError`: Returns standard `ErrorEntity`.

## 8. Error Handling
Catches network anomalies inside repository (`catch(error)`). Translates backend specific error JSON into `ErrorEntity` globally. Emitted via `CancelOrderDetailsError` state where UI presents it through `ToastService.showError(...)` staying on screen.

## 9. Localization Keys Added
- `cancelOrderReason`: "Reason for cancellation" / "سبب الإلغاء"
- `pleaseEnterCancelReason`: "Please enter a reason for cancellation" / "الرجاء إدخال سبب الإلغاء"
- `cancelOrderSuccess`: "Order cancelled successfully" / "تم إلغاء الطلب بنجاح"

## 10. Post-Success Behavior
- Success toast is shown.
- Bottom sheet pops itself closed (`CustomNavigator.pop()`).
- Navigates replacement to index 3 (`NAV_LAYOUT` at `Routes.orders`).

## 11. Post-Error Behavior
- Error toast is shown with backend message.
- Dialog stays open so user can retry or cancel.

## 12. Future Update Notes
- To add a new parameter to cancellation, simply add it to `CancelOrderParams`.
- If new info is returned from the cancel response, update `CancelOrderResponseModel` and `fromJson`.
