# Feature: About Services

## 1. Endpoint Info
- HTTP Method: `GET`
- Endpoint Constant: `Endpoints.services`
- Requires Auth: Uses default headers (auth token sent if present)
- Request Type (Body / Query / Path): Query (`lang`)
- Status Codes: `200` on success, other statuses handled by `ApiErrorHandler`

## 2. Request Flow
UI → Cubit → Repository → Network → Backend → Model → Cubit → UI  
The UI triggers the cubit, which calls the repository. The repository uses
`Network().request()` with the endpoint and query params, then maps the response
into `AboutServicesModel`. The cubit emits states to update the UI.

## 3. Files Created
- `lib/features/about/data/params/about_services_params.dart`
- `lib/features/about/data/models/about_services_model.dart`
- `lib/features/about/data/repository/about_services_repository.dart`
- `lib/features/about/logic/cubit/about_services_cubit.dart`
- `lib/features/about/logic/state/about_services_state.dart`
- `lib/features/about/FEATURE_IMPLEMENTATION_LOG.md`

## 4. Params Explanation
`AboutServicesParams` sends the selected language as a query parameter:
`{ "lang": "<current_lang>" }`. Null values are removed before sending.

## 5. Model Explanation
`AboutServicesModel` mirrors the response:
- `success`: top-level boolean
- `data`: object containing `type`, `title`, and `body` (HTML string)

## 6. Repository Logic
`AboutServicesRepository.getServices()` calls:
`Network().request(Endpoints.services, method: GET, queryParameters: params.returnedMap())`
and converts the response to `AboutServicesModel`.

## 7. State Management Logic
- `AboutServicesInitial`: initial state
- `AboutServicesLoading`: first load (shows shimmer)
- `AboutServicesRefreshing`: pull-to-refresh (keeps last data)
- `AboutServicesSuccess`: data loaded successfully
- `AboutServicesError`: error returned from API

## 8. Error Handling
All errors are passed to `ApiErrorHandler().handleError(error)` and emitted as
`AboutServicesError` containing `ErrorEntity`.

## 9. Localization Keys Added
- None

## 10. Post-Success Behavior
The services title and HTML body render in `AboutFeaturesWidget` using
`HtmlWidget`, with pull-to-refresh available.

## 11. Post-Error Behavior
The screen remains visible and displays the error message, with pull-to-refresh
to retry.

## 12. Future Update Notes
- Add new field: extend `AboutServicesData` with the new key and update
  `fromJson()`/`toJson()`, then update UI where needed.
- Modify response structure: adjust `AboutServicesModel` and
  `AboutServicesData` parsing, then update the widget to match.
- Add pagination later: add `page` in params, extend cubit with pagination
  states (e.g., `PaginationLoading`), and append results in the UI.
