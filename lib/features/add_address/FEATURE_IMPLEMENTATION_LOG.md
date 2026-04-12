# Feature: Add Address Integration

## 1. Endpoint Info
- **HTTP Method**: POST
- **Endpoint Constant**: `Endpoints.addAddress` (`/customer/addresses`)
- **Requires Auth**: Yes (Bearer Token via `Network().request`)
- **Request Type**: Body (JSON)
- **Status Codes**:
  - 200/201: Success
  - 422: Validation Error
  - 401: Unauthorized

## 2. Request Flow
UI (**AddAddressScreen**) → Cubit (**AddAddressCubit**) → Repository (**AddAddressRepo**) → Network (**Network().request**) → Backend → Model (**AddAddressModel**) → Cubit → UI (Success/Failure Bottom Sheet)

The UI triggers `saveAddress()` in the Cubit, which collects data from controllers and internal state (`type`, `isDefault`), wraps it in `AddAddressParams`, and calls the static `addAddress` method in the Repository.

## 3. Files Created / Modified
- `lib/features/add_address/data/params/add_address_params.dart` (Verified: handles `is_default` and `type`)
- `lib/features/add_address/data/models/add_address_model.dart` (Verified)
- `lib/features/add_address/data/models/region_model.dart` (Verified)
- `lib/features/add_address/data/models/city_model.dart` (Verified)
- `lib/features/add_address/data/repo/add_address_repo.dart` (Modified/Verified: static methods for addAddress, getRegions, getCities)
- `lib/features/add_address/logic/add_address_cubit.dart` (Modified: added `changeType`, `toggleIsDefault`, and state emissions)
- `lib/features/add_address/logic/add_address_state.dart` (Modified: added `AddAddressTypeChanged`, `AddAddressDefaultChanged`)
- `lib/features/add_address/ui/widgets/all_filds_form_add_address.dart` (Modified: added ChoiceChips for type and Checkbox for isDefault)
- `lib/core/utils/constant/app_strings.dart` (Modified: added localization keys)
- `assets/langs/en.json` & `assets/langs/ar.json` (Modified: added translations)

## 4. Params Explanation
`AddAddressParams`:
- Maps UI fields (controllers) to backend keys.
- `returnedMap()` removes null or empty values.
- Keys match backend: `type`, `address`, `latitude`, `longitude`, `building_number`, `floor`, `apartment`, `is_default`, `region_id`, `city_id`, `notes`, `street_address`, `district`.

## 5. Model Explanation
- `AddAddressModel`: Root response model with `success`, `message`, and `data`.
- `AddAddressDataModel`: Contains full address details returned by backend.
- `RegionModel` & `CityModel`: Nested models for structured location data.

## 6. Repository Logic
Uses `AddAddressRepo` with static methods:
- `addAddress(params)`: Calls POST request.
- `getRegions()`: Fetches regions based on current app language.
- `getCities(regionId)`: Fetches cities for a specific region.

## 7. State Management Logic
- `AddAddressInitial`: Initial state.
- `AddAddressSaving`: Emitted while waiting for API response.
- `AddAddressSaved(success)`: Emitted on successful addition, triggers navigation.
- `AddAddressError(failure)`: Emitted on API error, triggers failure bottom sheet.
- `AddAddressTypeChanged(type)`: Emitted when address type is selected.
- `AddAddressDefaultChanged(isDefault)`: Emitted when default checkbox is toggled.

## 8. Error Handling
Uses `ApiErrorHandler().handleError(error)` to convert Dio exceptions into a global `ErrorEntity`. This entity contains the status code and localized error messages displayed in the UI.

## 9. Localization Keys Added
- `addressType`
- `addressTypeHome`
- `addressTypeWork`
- `addressTypeOffice`
- `setAsDefaultAddress`

## 10. Post-Success Behavior
- Shows `SuccessBottomSheet` with localized message.
- Navigates to `Routes.ADDRESS` (Address screen) and cleans the stack.

## 11. Post-Error Behavior
- Shows `FailureBottomSheet` with the error message returned from backend.
- Stays on the screen to allow the user to correct data.

## 12. Future Update Notes
- **Add new field**: Add property in `AddAddressParams`, update `returnedMap()`, add controller/variable in `AddAddressCubit`, and add widget in `AllFildsFormAddAddress`.
- **Modify response**: Update `AddAddressDataModel` fields and `fromJson`.
- **Add pagination**: Not required for this feature as it's a creation form.
