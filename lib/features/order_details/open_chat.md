@offers
You are an autonomous senior Flutter engineer working inside an EXISTING production Flutter project.

Your mission:
Integrate a new API feature STRICTLY followig the current architecture.

=====================================================
🚨 HARD RULES (NON-NEGOTIABLE)
=====================================================

- DO NOT refactor architecture.
- DO NOT introduce UseCases.
- DO NOT introduce RepositoryImpl.
- DO NOT modify core/services/network.
- DO NOT modify core/services/error_handler.
- DO NOT modify routing system.
- DO NOT change static repository pattern.
- DO NOT introduce new global patterns.
- DO NOT hardcode strings.
- ALWAYS reuse existing core modules.

This project uses:

- Static repository methods
- Network().request() wrapper
- ApiErrorHandler().handleError()
- ErrorEntity (global error model)
- Localization via AppStrings + .tr
- Endpoint constants inside core/app_config/api_names.dart
- Messages displayed via existing core utilities
- Feature-based structure

Respect the system.

=====================================================
🔎 PHASE 1 — PROJECT INVESTIGATION (MANDATORY)
=====================================================

Before writing any code:

1. Inspect and understand:
   - core/services/network
   - core/services/error_handler
   - core/navigation
   - core/app_config/api_names.dart
   - core/utils/constant/app_strings.dart
   - One existing feature module (example: login)

2. Understand:
   - How Network().request() works
   - How headers are injected
   - How auth is handled
   - How ErrorEntity is structured
   - How Cubit states are structured
   - How localization is added
   - How messages are shown
   - How routing is triggered

DO NOT assume.
DO NOT recreate core logic.
Reuse everything.

=====================================================
📌 PHASE 2 — REQUIREMENTS COLLECTION
=====================================================

Ask the user clearly:

1. Feature name?
inside this feature 

offers_screen.dart

  ngotoation
2. Is it new feature or inside existing module?
inside  this @offers
3. Endpoint constant name? (to add in api_names.dart)
/chat/order/451/open
4. HTTP method? (GET / POST / PUT / PATCH / DELETE)
POST 
5. Does it require authentication?
6. Request type:
   - Body?
   - Query parameters?
   - Path parameters?
not ihavnt
7. Example success JSON?
{
    "success": true,
    "message": "Chat opened successfully",
    "data": {
        "chat": {
            "id": 5,
            "order_id": 451,
            "customer_id": 339,
            "driver_id": 338,
            "last_message_at": "2026-03-29T23:19:43.000000Z",
            "created_at": "2026-03-25T22:24:54.000000Z",
            "updated_at": "2026-03-29T23:19:43.000000Z",
            "order": {
                "id": 451,
                "parent_order_id": null,
                "order_number": "ORD-20260326-6B9A26",
                "customer_id": 339,
                "driver_id": 338,
                "payout_company_id": null,
                "type": "instant",
                "service_type": "transport",
                "vehicle_type_id": 3,
                "pickup_address": "RHFA6439، 6439 النبقية، 2755، الملك فهد، الرياض 12271، السعودية, الملك فهد, الرياض, منطقة الرياض",
                "pickup_lat": "24.7329572",
                "pickup_lng": "46.6662231",
                "pickup_contact_name": "bbb",
                "pickup_contact_phone": "966503211231",
                "pickup_notes": null,
                "delivery_address": "6530 القمراء، الرحمانية، الرياض 12342، السعودية, الرحمانية, الرياض, منطقة الرياض",
                "delivery_lat": "24.7091652",
                "delivery_lng": "46.6614451",
                "delivery_contact_name": null,
                "delivery_contact_phone": "500000099",
                "delivery_notes": null,
                "package_description": null,
                "package_weight": "690.00",
                "package_size": "small",
                "package_type_id": 4,
                "vehicles_count": 1,
                "notes": "bbbbbbb",
                "package_images": [
                    "https://greenhub.sa-fvs.com/storage/packages/XcAHSMtLK0fGuEVauM8lLP8ZiOvPwhWhLrQBZPia.jpg"
                ],
                "customer_offer_price": null,
                "subtotal": "777.00",
                "vat_rate": "0.1500",
                "vat_amount": "116.55",
                "commission_rate": "0.1000",
                "driver_offer_price": null,
                "final_price": "893.55",
                "platform_fee": "77.70",
                "payout_amount": "699.30",
                "payee_type": "driver",
                "company_earnings": null,
                "driver_earnings": "699.30",
                "scheduled_at": null,
                "accepted_at": "2026-03-25T22:24:42.000000Z",
                "picked_up_at": null,
                "delivered_at": null,
                "cancelled_at": null,
                "status": "accepted",
                "cancellation_reason": null,
                "cancelled_by": null,
                "created_at": "2026-03-25T22:15:18.000000Z",
                "updated_at": "2026-03-25T22:24:42.000000Z",
                "deleted_at": null,
                "pickup_location": {
                    "lat": 24.7329572,
                    "lng": 46.6662231
                },
                "delivery_location": {
                    "lat": 24.7091652,
                    "lng": 46.6614451
                }
            },
            "customer": {
                "id": 339,
                "sn": null,
                "company_id": null,
                "driver_type": null,
                "name": "bbb",
                "phone": "966503211231",
                "birth_date": null,
                "nationality": null,
                "email": "asas@yahoo.com",
                "gender": "male",
                "notifications_enabled": true,
                "role": "customer",
                "status": "active",
                "avatar": null,
                "national_id": null,
                "license_number": null,
                "license_expiry": null,
                "face_image": null,
                "id_image": null,
                "driver_license_image": null,
                "phone_verified_at": "2026-03-28T15:20:26.000000Z",
                "rating": "5.00",
                "total_ratings": 1,
                "wallet_balance": "4076.00",
                "iban": null,
                "commission_rate": null,
                "is_commission_enabled": false,
                "is_online": false,
                "current_lat": "31.0321318",
                "current_lng": "31.3697651",
                "last_seen": null,
                "created_at": "2026-03-04T11:48:41.000000Z",
                "updated_at": "2026-03-29T05:08:45.000000Z",
                "deleted_at": null,
                "current_location": {
                    "lat": 31.0321318,
                    "lng": 31.3697651
                },
                "face_image_url": null,
                "id_image_url": null,
                "driver_license_image_url": null
            },
            "driver": {
                "id": 338,
                "sn": null,
                "company_id": null,
                "driver_type": "individual",
                "name": "سائق اختبار كامل",
                "phone": "966507654322",
                "birth_date": "1995-05-19T21:00:00.000000Z",
                "nationality": "1",
                "email": "mariam844@fvs.com.sa",
                "gender": "male",
                "notifications_enabled": true,
                "role": "driver",
                "status": "active",
                "avatar": null,
                "national_id": "191234567832",
                "license_number": "LIC-REF-92211",
                "license_expiry": "2027-12-29T21:00:00.000000Z",
                "face_image": null,
                "id_image": null,
                "driver_license_image": null,
                "phone_verified_at": "2026-03-28T06:31:37.000000Z",
                "rating": "3.80",
                "total_ratings": 5,
                "wallet_balance": "450.00",
                "iban": "SA4420000001234567891234",
                "commission_rate": "10.00",
                "is_commission_enabled": true,
                "is_online": true,
                "current_lat": "24.7136000",
                "current_lng": "46.6753000",
                "last_seen": "2026-03-25T21:58:49.000000Z",
                "created_at": "2026-03-04T09:07:16.000000Z",
                "updated_at": "2026-03-29T04:14:20.000000Z",
                "deleted_at": null,
                "current_location": {
                    "lat": 24.7136,
                    "lng": 46.6753
                },
                "face_image_url": null,
                "id_image_url": null,
                "driver_license_image_url": null
            }
        }
    }
}
8. Example error JSON?
{
    "message": "Unauthenticated."
}
9. Post-success behavior?
   - Show message?
   - Navigate?
   - Save cache?
   navigate to NegotiationOffersScreen
10. Post-error behavior?
    - Show message?
    - Stay on screen?
    - Reset form?
Show message and  Stay on screen
11. Does this feature require:
   - Pagination?
   - Multipart upload?
   - Debounce?
   - Pull-to-refresh?
   - Infinite scroll?
not ihavet this 

12. Does this feature require :
   -  deafault native loading screen?
   -  deafault native loading on button?
   -  shimmer loading ?
deafault native loading on button

13. Any special logic or business rule that should be considered?

iwnt add button name negotiation 
side this 

offer_card.dart#L74-91
 
when tap navigate chat 
=====================================================
📂 PHASE 3 — IMPLEMENTATION STRUCTURE
=====================================================

Create the feature using EXACT structure:

feature_name/
 ├── data/
 │   ├── params/
 │   ├── models/
 │   └── repository/
 ├── logic/
 │   ├── cubit/
 │   └── state/
 ├── presentation/
 │   ├── pages/
 │   └── widgets/

Do NOT add extra folders.

=====================================================
📦 IMPLEMENTATION RULES
=====================================================

PARAMS (data/params):
- Extend Equatable
- Include returnedMap()
- Remove null values
- Match backend keys exactly
- Used directly inside repository

MODEL (data/models):
- Represent backend response exactly
- Manual fromJson()
- Manual toJson()
- Extend Equatable
- No code generation
- Do NOT over-engineer

REPOSITORY (data/repository):
- Use static method pattern
- Use:

  final response = await Network().request(
     Endpoints.endpointName,
     method: ServerMethods.POST,
     body: params.returnedMap(),
  );

- Return:
  Either<ErrorEntity, Model>

- Catch errors using:
  ApiErrorHandler().handleError(error)

Do NOT modify Network or ErrorHandler.

CUBIT (logic/cubit):
- Emit:
  Initial
  Loading
  Success
  Error

- Call repository only
- Use fold properly
- Trigger:
   - CacheMethods if needed
   - Navigation via existing navigation
   - Messages via core messaging
- Use localization keys (.tr)

STATE (logic/state):
- Use sealed classes
- Error state carries ErrorEntity
- Success state carries model/entity

=====================================================
🌍 LOCALIZATION RULES
=====================================================

If new text is required:

1. Add key inside:
   core/utils/constant/app_strings.dart

2. Add translation inside:
   assets/en.json
   assets/ar.json

3. Use in UI:
   AppStrings.keyName.tr

Never hardcode strings.

=====================================================
⚙️ ADVANCED BEHAVIOR
=====================================================

Only apply if feature requires:

✔ Pagination → Add page param in Params
✔ Multipart → Use FormData in repository
✔ Debounce → Handle inside Cubit
✔ Pull-to-refresh → Add refresh state
✔ Infinite scroll → Add PaginationLoading state

Do NOT add complexity unless needed.

=====================================================
🧠 PHASE 4 — SELF-DOCUMENTATION (MANDATORY)
=====================================================

After successful implementation:

Create a markdown file:

feature_name/FEATURE_IMPLEMENTATION_LOG.md

This file MUST include:

# Feature: <Feature Name>

## 1. Endpoint Info
- HTTP Method
- Endpoint Constant
- Requires Auth
- Request Type (Body / Query / Path)
- Status Codes

## 2. Request Flow
UI → Cubit → Repository → Network → Backend → Model → Cubit → UI

Explain briefly.

## 3. Files Created
List all created files with paths.

## 4. Params Explanation
Explain request mapping.

## 5. Model Explanation
Explain response structure.

## 6. Repository Logic
Explain how Network() is used.

## 7. State Management Logic
Explain state transitions.

## 8. Error Handling
Explain how ErrorEntity is returned and handled.

## 9. Localization Keys Added
List new keys added.

## 10. Post-Success Behavior
Explain what happens.

## 11. Post-Error Behavior
Explain what happens.

## 12. Future Update Notes
Explain how to:
- Add new field
- Modify response
- Add pagination later

Goal:
Another engineer should understand the feature
without reading all code.

=====================================================
🎯 FINAL OUTPUT FORMAT
=====================================================

1. Show folder structure
2. Show full code for:
   - Params
   - Model
   - Repository
   - Cubit
   - State
3. Show additions to:
   - api_names.dart
   - app_strings.dart
   - en.json
   - ar.json
4. Generate FEATURE_IMPLEMENTATION_LOG.md content

Everything must:
- Match existing style
- Be production-ready
- Not modify core
- Respect architecture