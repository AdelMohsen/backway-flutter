# Feature: Offers Section Integration

## 1. Endpoint Info
- **HTTP Method**: GET
- **Endpoint Constant**: `Endpoints.appImages` (`/app-images`)
- **Requires Auth**: Handled by base `Network().request` (no override needed here)
- **Request Type**: Query parameters (`lang`, `section=banners`, `app=customer`)
- **Status Codes**: 200 OK (handled via standard models), error codes handled via `ApiErrorHandler`

## 2. Request Flow
UI (`OffersSectionWidget`) → injected `OffersCubit` triggers `getOffers` on initialization → Cubit delegates to `OffersRepository` passing `OffersParams` → `OffersRepository` sends the GET request using `Network().request` → Backend returns JSON list of images → `OffersModel` parses the JSON array → Cubit receives Success response via dartz `Either` wrapper → Cubit emits `OffersSuccess` holding the model → UI updates to display images via network.

## 3. Files Created
- `lib/features/home/data/params/offers_params.dart`
- `lib/features/home/data/models/offers_model.dart`
- `lib/features/home/data/repository/offers_repository.dart`
- `lib/features/home/logic/state/offers_state.dart`
- `lib/features/home/logic/cubit/offers_cubit.dart`
- `lib/features/home/FEATURE_IMPLEMENTATION_LOG.md`
- Modified existing file (`lib/core/app_config/api_names.dart`) to add `Endpoints.appImages`
- Modified existing UI component (`lib/features/home/ui/widgets/offers_section_widget.dart`) to fetch dynamically
- Modified existing UI page (`lib/features/home/ui/pages/home_screen.dart`) to initialize the widget without static parameters

## 4. Params Explanation
`OffersParams` converts request queries into a `Map<String, dynamic>`. Default values are `banners` for section and `customer` for app. Null values are prevented from appearing in query parameters via conditional syntax.

## 5. Model Explanation
`OffersModel` represents the exact JSON structure of the API `{ "success": true, "data": [...] }`. Contains basic properties `success` and `data` indicating parsed `List<String>`. Avoids overcomplicating with external generators like json_serializable or Freezed.

## 6. Repository Logic
`OffersRepository` statically defines the `getOffers` method. Uses the singleton instance `Network().request()` and delegates the response modeling dynamically to `OffersModel`. Error cases are wrapped using `ApiErrorHandler().handleError()`. Returns an `Either` containing either mapped data (`Right`) or a captured standard error (`Left`).

## 7. State Management Logic
`OffersState` defines four states (`Initial`, `Loading`, `Success`, `Error`). 
`OffersCubit` runs state machines using simple function calls (`getOffers()`), catching the `Left` and `Right` of the repository return, and emitting appropriately to automatically change the UI state without complex bindings or intermediate states.

## 8. Error Handling
Failure modes trigger a `Left(ErrorEntity)`, yielding `OffersError`. `OffersSectionWidget` renders an error generic UI block fetching `state.error.message` automatically translated from the central ErrorHandler mechanism with an inline manual retry action.

## 9. Localization Keys Added
The existing framework string tokens (like `AppStrings.error`) were sufficient, keeping translation arrays minimal. `OffersSectionWidget` utilizes dynamic string concatenations (`AppStrings.homeOffersSend.tr` ...) explicitly imported and reused.

## 10. Post-Success Behavior
The `OffersSectionWidget` stops displaying its `CustomShimmerContainer` and builds a smooth rendering slider using `SharedCarousalWidget` overlaid using the standard project UI style, using `NetworkImage` for fetching the real paths returned in `data`.

## 11. Post-Error Behavior
Stops processing logic and loads a grey placeholder container displaying `state.error.message` along with a retry/reload icon/button. State doesn't modify navigation or block usage.

## 12. Future Update Notes
- **To Add new fields to API logic**: Add fields individually securely typed as dynamic inside `OffersModel.fromJson` properties definition.
- **To Modify parameters needed during GET**: Enhance the `OffersParams` constructor arguments, remembering to declare non-defaults and export to the `returnedMap()`.
- **To Add Pagination**: If pagination is required, inject `page=X` in `OffersParams`, add Pagination thresholds/infinite scrolling variables iteratively into `OffersCubit`, yielding `OffersPaginationLoading` onto `OffersState`.
