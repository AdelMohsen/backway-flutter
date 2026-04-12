# Feature: Orders Integration

## 1. Endpoint Info
- **HTTP Method**: GET
- **Endpoint Constant**: `Endpoints.getOrders` (`/customer/orders`)
- **Requires Auth**: Yes (Token sent in header by `Network().request()`)
- **Request Type**: Query parameters (`page`, `per_page`, `status`)
- **Status Codes**: 200 (Success), 401 (Unauthenticated), etc.

## 2. Request Flow
UI (`loadOrders`) → Cubit (`OrdersCubit.loadOrders`) → Repository (`OrdersRepository.getOrders`) → Network (`Network().request()`) → Backend → Model (`OrdersResponseModel`) → Cubit emits `OrdersLoaded` → UI (`ListView` in `OrderScreen`) rebuilds.

## 3. Files Created / Modified
**Modified:**
- `core/app_config/api_names.dart` (added `getOrders`)
- `features/orders/data/models/orders_model.dart` (re-mapped to new API JSON)
- `features/orders/ui/widgets/order_header_row.dart`
- `features/orders/ui/widgets/order_location_timeline.dart`
- `features/orders/ui/widgets/details_order.dart`

**Created:**
- `features/orders/data/params/orders_params.dart`
- `features/orders/data/repository/orders_repository.dart`
- `features/orders/logic/orders_state.dart` (rewritten as sealed class)
- `features/orders/logic/orders_cubit.dart` (rewritten with pagination logic)
- `features/orders/FEATURE_IMPLEMENTATION_LOG.md`

## 4. Params Explanation
`OrdersParams` requires `page`, `perPage`, and `status`. It contains `returnedMap()` mapping exactly to backend query keys (`page`, `per_page`, `status`).

## 5. Model Explanation
`OrderModel` exactly maps the structure from backend containing objects for `status`, `type`, `serviceType`, `pickup` (ParticipantModel), `delivery`, `package` (PackageModel), `pricing`, `driver` (DriverModel with Vehicles), etc. Avoids code-generation blocks and utilizes Equatable.

## 6. Repository Logic
`OrdersRepository` provides static method `getOrders` taking `OrdersParams`. Calls `Network().request(Endpoints.getOrders, method: ServerMethods.GET, queryParameters: params.returnedMap())`. Returns `Either<ErrorEntity, OrdersResponseModel>`. Error handling utilizes the existing `ApiErrorHandler().handleError(e)`.

## 7. State Management Logic
`OrdersCubit` maintains standard emit states `OrdersInitial`, `OrdersLoading`, `OrdersLoaded`, and `OrdersError`. Added `OrdersPaginationLoading` for silent loading of next pages. Implemented `hasReachedMax` indicator for infinite scroll limits. `changeTab` automatically refreshes the orders list fetching based on string statuses `['new', 'in_progress', 'completed']`.

## 8. Error Handling
Returns `Left(ApiErrorHandler().handleError(e))` returning a global `ErrorEntity`. The Cubit receives it via DartZ fold and emits an `OrdersError` state, which the UI can react to seamlessly. No modifying generic error handler required.

## 9. Localization Keys Added
No new localization strings were strictly needed since backend provides `label` mapping for dynamic types and statuses. Used existing `AppStrings.scheduled`, `inTransit`, and `previous` for mappings.

## 10. Post-Success Behavior
Upon successful retrieval, Cubit checks for pagination ending limits, appends new list to existing `OrdersLoaded.orders` list object and switches state seamlessly updating the visual UI cards.

## 11. Post-Error Behavior
Cubit emits `OrdersError` preventing further paging while preserving tab context. UI can safely handle global messaging or stay static.

## 12. Future Update Notes
- **Add new field**: Simply update `OrderModel` variables, `props`, `fromJson`, and `toJson`.
- **Modify response**: Maintain exact JSON matching.
- **Add pagination later**: Infinite scroll scrolling triggers are handled on the UI layer. Call `cubit.loadOrders()` to fetch next valid page while listening to `hasReachedMax` bound.
