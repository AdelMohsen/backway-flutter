# Feature: Rate Driver Implementation

## 1. Endpoint Info
- **HTTP Method**: POST
- **Endpoint Constant**: `Endpoints.rateDriver(id)` maps to `/ratings/order/{id}`
- **Requires Auth**: Yes (handled by `Network().request()` inject headers)
- **Request Type**: Body
- **Status Codes**: 
  - 200: Success
  - 400/422: Validation Error
  - 401: Unauthorized
  - 404: Order not found

## 2. Request Flow
UI (`RateNegotiationScreen`) → Cubit (`RateNegotiationCubit`) → Repository (`RateNegotiationRepository`) → Network (`Network().request()`) → Backend → Model (`RateNegotiationModel`) → Cubit → UI

- User selects emoji and enters a note.
- Cubit maps emoji index to a 1-5 rating.
- Repository calls the backend via the centralized network service.
- Success shows a success bottom sheet; failure shows a snackbar.

## 3. Files Created
- `lib/features/rate_negotiation/data/params/rate_negotiation_params.dart`
- `lib/features/rate_negotiation/data/models/rate_negotiation_model.dart`
- `lib/features/rate_negotiation/data/repository/rate_negotiation_repository.dart`
- `lib/features/rate_negotiation/logic/state/rate_negotiation_state.dart`
- `lib/features/rate_negotiation/logic/cubit/rate_negotiation_cubit.dart`
- `lib/features/rate_negotiation/FEATURE_IMPLEMENTATION_LOG.md`

## 4. Params Explanation
- `RateNegotiationParams` handles mapping `rating` and `comment` to the JSON body required by the backend.

## 5. Model Explanation
- `RateNegotiationModel` represents the backend response, including a nested `RateNegotiationData` object containing order and rating IDs.

## 6. Repository Logic
- `RateNegotiationRepository.submitRating` uses `Network().request()` with `ServerMethods.POST` and handles endpoint construction via `Endpoints.rateDriver(id)`. Errors are caught and passed through `ApiErrorHandler().handleError()`.

## 7. State Management Logic
- `RateNegotiationCubit` manages `Initial`, `Loading`, `Success`, and `Error` states.
- It calculates the rating from the emoji index (rating = 5 - index).

## 8. Error Handling
- `ErrorEntity` is returned on failure and displayed to the user via a Snackbar on the screen.

## 9. Localization Keys Used
- `AppStrings.confirm.tr`
- `AppStrings.cancel.tr`
- `AppStrings.writeNotesHere.tr`
- Custom hardcoded Arabic/English strings were used where specific localized keys were not already present or requested by the user.

## 10. Post-Success Behavior
- Shows `RatingSuccessBottomSheet`.
- Provides options to navigate back to order details or shipment history.

## 11. Post-Error Behavior
- Displays error message in a Snackbar.
- User stays on the screen to retry or correct their input.

## 12. Future Update Notes
- To add a new field: Update the `RateNegotiationParams` map and `RateNegotiationData` model fromJson.
- To modify response: Update the `RateNegotiationModel` JSON parsing logic.
