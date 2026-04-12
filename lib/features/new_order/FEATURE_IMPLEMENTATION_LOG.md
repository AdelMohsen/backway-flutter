# Create New Order — Feature Implementation Log

## Overview

Integrated the **Create Order API** (`POST /customer/orders`) with 2 supporting lookup APIs into the existing `new_order` feature module.

### APIs Integrated

| Method | Endpoint | Purpose |
|--------|----------|---------|
| `POST` | `/customer/orders` | Create a new order (multipart for images) |
| `GET` | `/vehicle-types?lang=` | Get available vehicle types |
| `GET` | `/package-types?lang=` | Get available package types |

---

## Architecture

Follows the existing project patterns strictly:

```
lib/features/new_order/
├── data/
│   ├── models/
│   │   ├── vehicle_type_model.dart      ← VehicleTypeModel (id, code, name, image)
│   │   ├── package_type_model.dart      ← PackageTypeModel (id, name)
│   │   └── create_order_model.dart      ← CreateOrderResponseModel + CreateOrderModel
│   ├── params/
│   │   └── create_order_params.dart     ← CreateOrderParams with returnedMap() + multipart
│   └── repository/
│       └── create_order_repo.dart       ← 3 static methods (createOrder, getVehicleTypes, getPackageTypes)
├── logic/
│   ├── cubit/
│   │   └── create_order_cubit.dart      ← Form state, API calls, image picking, location
│   └── state/
│       └── create_order_state.dart      ← Sealed states (10 total)
└── ui/
    ├── pages/
    │   ├── create_new_order_screen.dart  ← BlocProvider + BlocListener (success/error)
    │   └── map_picker_screen.dart        ← Google Maps picker with search
    └── widgets/
        ├── details_order.dart            ← Orchestrator wiring all sections to cubit
        └── details_order_widget/
            ├── transport_type_section_widget.dart  ← Vehicle type dropdown (API)
            ├── shipment_data_section_widget.dart   ← Package type, size chips, phone, counter
            ├── address_section_widget.dart         ← From/To with map picker
            └── image_upload_section_widget.dart    ← Camera/gallery + preview + remove
```

---

## Request Parameters (`POST /customer/orders`)

| Parameter | Type | Source |
|-----------|------|--------|
| `type` | `String` | `'instant'` or `'scheduled'` |
| `vehicle_type_id` | `int?` | Vehicle types dropdown (from API) |
| `service_type` | `String?` | `'transport'` or `'installation'` radio |
| `package_type_id` | `int?` | Package types dropdown (from API) |
| `vehicles_count` | `int` | Counter widget (default: 1) |
| `package_size` | `String?` | `'small'` / `'medium'` / `'large'` chips |
| `package_weight` | `String?` | Weight text field |
| `notes` | `String?` | Notes text field |
| `pickup_lat` | `double?` | Map picker |
| `pickup_lng` | `double?` | Map picker |
| `pickup_address` | `String?` | Geocoded from map |
| `delivery_lat` | `double?` | Map picker |
| `delivery_lng` | `double?` | Map picker |
| `delivery_address` | `String?` | Geocoded from map |
| `delivery_contact_phone` | `String?` | Phone form field |
| `scheduled_at` | `String?` | Date picker → ISO 8601 (`2026-03-05T00:00:00.000000Z`) |
| `package_images[]` | `MultipartFile[]` | Camera/gallery (max 3MB each) |

---

## State Management

**Cubit**: `CreateOrderCubit` manages all form state + API calls.  
**Provider**: Created inside `CreateNewOrderScreen` via `BlocProvider`.

### States (sealed class)

| State | Trigger |
|-------|---------|
| `CreateOrderInitial` | Default / after form field changes |
| `CreateOrderLoading` | `createOrder()` called |
| `CreateOrderSuccess` | API returned success |
| `CreateOrderError` | API returned error |
| `VehicleTypesLoading` | `loadVehicleTypes()` called |
| `VehicleTypesLoaded` | Vehicle types fetched |
| `VehicleTypesError` | Vehicle types fetch failed |
| `PackageTypesLoading` | `loadPackageTypes()` called |
| `PackageTypesLoaded` | Package types fetched |
| `PackageTypesError` | Package types fetch failed |

---

## Behaviors

| Event | Action |
|-------|--------|
| **Order created successfully** | SnackBar (green) + navigate to Carriers List (step 1) |
| **Order creation failed** | SnackBar (red) + stay on current screen |
| **Image > 3MB** | Error toast, image rejected |
| **Screen opened** | Auto-loads vehicle types + package types from API |

---

## Localization

**21 keys added** to `app_strings.dart`, `en.json`, and `ar.json`:

`orderCreatedSuccessfully`, `orderCreationFailed`, `searchForLocation`, `pickLocationOnMap`, `selectPackageType`, `selectPackageSize`, `packageSize`, `small`, `large`, `selectVehicleType`, `selectServiceType`, `recipientPhoneNumber`, `deliveryContactPhone`, `transport`, `instant`, `noVehicleTypesAvailable`, `noPackageTypesAvailable`, `takePhoto`, `chooseFromGallery`, `addImage`

---

## Endpoints Added (`api_names.dart`)

```dart
static const String createOrder = '/customer/orders';
static const String vehicleTypes = '/vehicle-types';
static const String packageTypes = '/package-types';
```

---

## Key Design Decisions

1. **Dropdown uses `String?`** — `DefaultDropdownFormField` expects `String` values, so IDs are stored as strings in the cubit and parsed back to `int` when building `CreateOrderParams`.
2. **`setState` for form field updates** — Cubit setter methods emit `CreateOrderInitial()` which Bloc considers equal (Equatable + empty props), so `setState` is used in `details_order.dart` callbacks to force rebuild.
3. **`scheduled_at` formatting** — Date picker stores `yyyy-MM-dd`, cubit appends `T00:00:00.000000Z` before sending.
4. **Image validation & integrated UI** — 3MB limit checked before adding. UI redesigned as an integrated grid inside the upload section for better UX. Each image has a stacked cross button for removal.
5. **Pre-request Validation** — A manual `validate()` method in the Cubit checks all mandatory fields (Vehicle Type, Package Type, Pickup, Delivery, Phone, Date if scheduled) before allowing the API call. Clear error messages are emitted via `CreateOrderError`.

---

## Recent Updates (March 3, 2026)

- **Validation Fix**: Implemented a state reset (`emit(CreateOrderInitial())`) at the start of the `validate()` method. This ensures that the `BlocListener` in the UI correctly detects and displays validation errors even if the user triggers them consecutively.
- **Image Handling Enhancements**:
    - **Multiple Selection**: Upgraded the image picker to support **multiple choice** from the gallery (`pickMultiImage`).
    - **Source Restriction**: Updated the UI to open the Gallery directly when tapping the upload area, removing the redundant camera/gallery choice.
    - **Quantity Limits (Strictly Enforced)**: 
        - **Minimum 1 image**: A specific error message ("At least one image is required") is shown if the user tries to proceed without images.
        - **Maximum 8 images**: Users are blocked from adding more than 8. If they select more in the picker, only the first available slots are filled, and an error message ("Maximum of 8 images allowed") is displayed as feedback.
    - **UI Refresh**: Wrapped image addition and removal actions with `setState` in the main widget to ensure immediate UI updates.
- **Improved UX**: Redesigned the image display to show as an integrated grid within the upload field for a more premium look and feel.



