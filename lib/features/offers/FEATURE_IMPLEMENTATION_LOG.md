# Feature: Offers Negotiations (Fetch & Reject)

## 1. Endpoint Info
### Fetch Negotiations
- **HTTP Method:** GET
- **Endpoint Constant:** `Endpoints.customerNegotiations` (`/customer/negotiations`)
- **Requires Auth:** Yes
- **Request Type:** Query Parameters
- **Status Codes:** 200 (Success), 401 (Unauthenticated)

### Reject Negotiation
- **HTTP Method:** POST
- **Endpoint Method:** `Endpoints.rejectNegotiation(orderId, negotiationId)` (`/customer/orders/{order_id}/negotiations/{negotiation_id}/reject`)
- **Requires Auth:** Yes
- **Request Type:** Path Parameters
- **Status Codes:** 200 (Success)

## 2. Request Flow
**Fetch:** UI (OffersScreen via BlocProvider) → Cubit (`fetchNegotiations()`) → `NegotiationsRepository.getNegotiations()` → `Network().request()` → Backend → `NegotiationModel.fromJson()` → `NegotiationsSuccess(data)` → UI update (List of OfferCard).

**Reject:** UI (OfferCard Reject Btn) → Cubit (`rejectNegotiation()`) → `NegotiationsRepository.rejectNegotiation()` → `Network().request()` → Backend → `RejectNegotiationModel.fromJson()` → `NegotiationRejectSuccess(data)` → UI triggers Toast & calls `fetchNegotiations(isRefresh: true)`.

## 3. Files Created / Modified
- `lib/features/offers/data/params/negotiations_params.dart`
- `lib/features/offers/data/models/negotiation_model.dart`
- `lib/features/offers/data/models/reject_negotiation_model.dart`
- `lib/features/offers/data/repository/negotiations_repository.dart`
- `lib/features/offers/logic/state/negotiations_state.dart` (Handles both fetch and reject states)
- `lib/features/offers/logic/cubit/negotiations_cubit.dart` (Handles both fetch and reject functions)
- `lib/features/offers/ui/pages/offers_screen.dart` (Handles UI and BlocListener for Toasts)
- `lib/features/offers/ui/widgets/offer_card.dart`
- `lib/features/offers/ui/widgets/offer_carrier_avatar.dart`
- `lib/features/offers/FEATURE_IMPLEMENTATION_LOG.md`

## 4. Params Explanation
`NegotiationsParams` currently handles an empty param map as pagination is not required. Reject API uses raw path parameters directly in the Repository instead of a Param class.

## 5. Model Explanation
- `NegotiationModel`: Represents a single entity in the `"data": [...]`. Contains core offer details and a nested `NegotiationDriverModel`.
- `RejectNegotiationModel`: Represents the simple success response (`success`, `message`) when rejecting an offer.
- `AcceptNegotiationModel`: Represents the simple success response (`success`, `message`) when accepting an offer.

## 6. Repository Logic
The repository provides static methods for `getNegotiations`, `rejectNegotiation`, and `acceptNegotiation`. All methods use `Network().request()` mapped to their respective models, and return typed `Either<ErrorEntity, Model>`.

## 7. State Management Logic
`NegotiationsCubit` controls data and actions in `offers`:
- **Fetch States:** `NegotiationsInitial`, `NegotiationsLoading`, `NegotiationsSuccess`, `NegotiationsError`
- **Reject States:** `NegotiationRejectLoading`, `NegotiationRejectSuccess`, `NegotiationRejectError`
- **Accept States:** `NegotiationAcceptLoading`, `NegotiationAcceptSuccess`, `NegotiationAcceptError`

## 8. Error Handling
All `Network` or `Dio` exceptions inside the API calls are effortlessly piped into `ApiErrorHandler`. This ensures the Cubit ultimately receives an `ErrorEntity` preserving the consistent global error handling setup.

## 9. Localization Keys Added
No new localization keys added currently; standard backend messages are used for Toast popups via payload `RejectNegotiationModel.message`.

## 10. Post-Success Behavior
**Fetch:** Updates `allNegotiations` cache list and emits a `NegotiationsSuccess`.
**Reject / Accept:** Emits `NegotiationRejectSuccess` or `NegotiationAcceptSuccess` which triggers a global Success Toast directly from the UI BlocListener. The Cubit then immediately fires `fetchNegotiations(isRefresh: true)` to silently update the background list without showing a blocking loading indicator.

## 11. Post-Error Behavior
The Cubit emits Error states carrying an `ErrorEntity`. `OffersScreen` BlocListener intercepts this for Reject/Accept errors and displays a Warning Toast with the error message.

## 12. Future Update Notes
- **Add new field:** Open `NegotiationModel`, add the variable, update `.props`, `fromJson` and `toJson`.
- **Add pagination later:** The param interface already supports `page`. State can be added for `PaginationLoading`, and fetching increments internal page count before appending to `allNegotiations`.
