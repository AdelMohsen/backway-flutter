# Feature: Order Details

## 1. Endpoint Info
- HTTP Method: GET
- Endpoint Constant: `/customer/orders/$id`
- Requires Auth: Yes (Requires Token)
- Request Type: Path parameter (orderId) and query parameter (`lang`)
- Status Codes: 200 OK, 40x Errors

## 2. Request Flow
UI → OrderDetailsCubit → OrderDetailsRepository → Network → Backend → OrderDetailsResponseModel → OrderDetailsCubit → UI

The UI triggers `fetchOrderDetails` on load, the repository makes a GET request via the `Network` wrapper with the injected language queries, returning `Either<ErrorEntity, OrderDetailsResponseModel>`. The Cubit emits Loading, then Loaded (with `OrderModel`), or Error.

## 3. Files Created
- `lib/features/order_details/data/params/order_details_params.dart`
- `lib/features/order_details/data/models/order_details_model.dart`
- `lib/features/order_details/data/repository/order_details_repository.dart`
- `lib/features/order_details/logic/state/order_details_state.dart`
- `lib/features/order_details/logic/cubit/order_details_cubit.dart`

**Files Modified:**
- `lib/core/app_config/api_names.dart`
- `lib/features/order_details/ui/pages/order_details.dart`
- `lib/features/orders/data/models/orders_model.dart` (Shared models updated for completeness)

## 4. Params Explanation
`OrderDetailsParams` takes the required `orderId` to construct the path and an optional `lang` query string. `returnedMap()` extracts only `lang` to pass as dynamic queries.

## 5. Model Explanation
`OrderDetailsResponseModel` maps the `success` and `data` objects. `data` parses directly to the existing robust `OrderModel` ensuring consistent usage across lists and details. Note: The external `vehicleType` definition was added to the shared order model during this phase.

## 6. Repository Logic
`OrderDetailsRepository.getOrderDetails` uses `Network().request` with `ServerMethods.GET`. It passes the id through the new string builder method in `Endpoints.getOrderDetails(id)` and query variables. `ApiErrorHandler` ensures consistent global error mapping.

## 7. State Management Logic
`OrderDetailsCubit` relies on `OrderDetailsState` sealed classes:
- `OrderDetailsInitial`: Idle.
- `OrderDetailsLoading`: Active fetch request.
- `OrderDetailsLoaded`: Retains the fetched `OrderModel`.
- `OrderDetailsError`: Retains an `ErrorEntity`.

It supports `isRefresh: true` logic to avoid unneeded loaders on pull-to-refresh actions.

## 8. Error Handling
Global handler returns an `ErrorEntity` mapped through `ApiErrorHandler().handleError()`. The UI directly prints the error string `message` and ignores unhandled UI logic gracefully.

## 9. Localization Keys Added
None required for this specific view mapping as values rely on dynamic `AppStrings` already defined and remote backend localized mappings (e.g `nameAr`, `nameEn`).

## 10. Post-Success Behavior
Upon data fetch, `BlocBuilder` presents the full set of widget panels. Dynamic handling presents CarrierDetails conditionally (either negotiated drivers or direct drivers), mapping the values safely to avoid empty state render errors.

## 11. Post-Error Behavior
Cubit retains `OrderDetailsError`. Screen shows a centered text element presenting `error.message`.

## 12. Future Update Notes
- To modify the request: Adjust `OrderDetailsParams`.
- To present new fields: Update the shared `OrderModel` in `lib/features/orders/data/models/orders_model.dart` and bind to UI widgets. Pull to refresh is implemented globally natively.
