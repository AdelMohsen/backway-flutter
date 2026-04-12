# Feature: Social Media Links

## 1. Endpoint Info
- HTTP Method: GET
- Endpoint Constant: `Endpoints.socialLinks` (`/social-links`)
- Requires Auth: No (Follows general public info)
- Request Type: Query parameters (`lang`)
- Status Codes: 200 (Success), 400+ (Error handled by `ApiErrorHandler`)

## 2. Request Flow
UI (`ContactUsScreen`) → Cubit (`SocialLinksCubit`) → Repository (`SocialLinksRepository`) → Network (`Network()`) → Backend → Model (`SocialLinksModel`) → Cubit → UI (`SocialMediaLinksWidget`)

The `ContactUsScreen` provides the `SocialLinksCubit` and uses a `RefreshIndicator` to trigger data fetching. The `SocialMediaLinksWidget` listens to state changes and builds the UI accordingly.

## 3. Files Created
- `lib/features/contact_us/data/params/social_links_params.dart`
- `lib/features/contact_us/data/models/social_links_model.dart`
- `lib/features/contact_us/data/repository/social_links_repository.dart`
- `lib/features/contact_us/logic/state/social_links_state.dart`
- `lib/features/contact_us/logic/cubit/social_links_cubit.dart`

## 4. Params Explanation
`SocialLinksParams` takes a `lang` parameter which is passed as a query parameter to the GET request.

## 5. Model Explanation
- `SocialLinksModel`: Root model for the response.
- `SocialLinksData`: Contains the `title` and a list of `items`.
- `SocialLinkItem`: Represents each social link with a `name` and `url`.

## 6. Repository Logic
Uses the static `SocialLinksRepository.getSocialLinks` method. It calls `Network().request` with `ServerMethods.GET` and returns an `Either<ErrorEntity, SocialLinksModel>`.

## 7. State Management Logic
- `SocialLinksInitial`: Initial state.
- `SocialLinksLoading`: Emitted when fetching data (triggers shimmer).
- `SocialLinksSuccess`: Emitted with data when the request succeeds.
- `SocialLinksError`: Emitted with `ErrorEntity` when the request fails.

## 8. Error Handling
Errors are caught in the repository using `ApiErrorHandler().handleError(error)` and returned as `ErrorEntity` within a `Left` result.

## 9. Localization Keys Added
No new localization keys were added as existing keys (`followUsOn`, `socialMedia`, etc.) were reused as fallbacks. The title is fetched dynamically from the API.

## 10. Post-Success Behavior
Displays the social media links in a list of cards. Tapping a card launches the URL in an external application using `url_launcher`.

## 11. Post-Error Behavior
Falls back to a static list of social media links (defined in code as fallback) if the API fails, ensuring the user still sees some contact options.

## 12. Future Update Notes
- To add a new field: Update `SocialLinkItem` model and `fromJson`.
- To modify response: Adjust `SocialLinksModel`.
- To add pagination: Add `page` to `SocialLinksParams` and handle it in the repository/cubit.
