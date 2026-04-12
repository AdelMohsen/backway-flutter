 @order_details  You are an autonomous senior Flutter engineer working inside an EXISTING production Flutter project.

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
this is @order_details
2. Is it new feature or inside existing module?
inside module order_details
3. Endpoint constant name? (to add in api_names.dart)
/customer/orders/418?lang={{lang}}
4. HTTP method? (GET / POST / PUT / PATCH / DELETE)
GET
5. Does it require authentication?
iwnt token
6. Request type:
   - Body?
   - Query parameters?
   - Path parameters?
ihave Query parameters
lang
7. Example success JSON?
{
    "success": true,
    "data": {
        "id": 418,
        "order_number": "ORD-20260310-BE1439",
        "status": {
            "key": "negotiating",
            "label": "جاري التفاوض"
        },
        "type": {
            "key": "scheduled",
            "label": "مجدول"
        },
        "service_type": {
            "key": "installation",
            "label": "order.service_type.installation"
        },
        "vehicles_count": 5,
        "notes": "bbb",
        "pickup": {
            "address": "MPX3+JQW بجانب وكالة بورش،، شارع الأمير عبدالعزيز بن مساعد بن جلوي، السليمانية، الرياض 12234، السعودية, السليمانية, الرياض, منطقة الرياض",
            "location": {
                "lat": 24.6993059,
                "lng": 46.7041573
            },
            "contact_name": "bbb",
            "contact_phone": "966503211231",
            "avatar": "https://greenhub.sa-fvs.com/assets/dashboard/Ellipse%2030.png"
        },
        "delivery": {
            "address": "REJB7826، 7826 أبي الحرم الكاتب، 5128، حي جرير، الرياض 12837، السعودية, حي جرير, الرياض, منطقة الرياض",
            "location": {
                "lat": 24.6770024,
                "lng": 46.7575004
            },
            "contact_name": null,
            "contact_phone": "500000006"
        },
        "package": {
            "type": {
                "id": 3,
                "name": "مواد بناء",
                "name_ar": "مواد بناء",
                "name_en": "Building Materials",
                "is_active": true,
                "sort_order": 3
            },
            "weight": "124.00",
            "size": {
                "key": "small",
                "label": "صغير"
            },
            "images": [
                "https://greenhub.sa-fvs.com/storage/packages/joQhufkdFiipgkHoOQxrOSR22HNb3ePsSbqql7o4.jpg"
            ]
        },
        "pricing": {
            "driver_offer_price": null,
            "final_price": null,
            "vat_amount": 15,
            "platform_fee": 15,
            "driver_earnings": null
        },
        "scheduled_at": "2026-03-31T00:00:00.000000Z",
        "accepted_at": null,
        "picked_up_at": null,
        "delivered_at": null,
        "cancelled_at": null,
        "vehicle_type": {
            "id": 3,
            "code": "truck",
            "name": "شاحنة",
            "name_ar": "شاحنة",
            "name_en": "Truck",
            "image": null,
            "is_active": true
        },
        "driver": null,
        "negotiations": [
            {
                "id": 44,
                "order_id": 418,
                "driver_id": 338,
                "offered_price": "1244.00",
                "message": null,
                "status": "counter_offered",
                "status_label": "negotiation.status.counter_offered",
                "created_at": "2026-03-10T11:47:23.000000Z",
                "updated_at": "2026-03-10T11:54:23.000000Z",
                "driver": {
                    "id": 338,
                    "name": "سائق اختبار كامل",
                    "phone": "966507654322",
                    "rateing": "5.0",
                    "commission_rate": "10.00",
                    "is_online": true,
                    "current_location": {
                        "lat": 24.7136,
                        "lng": 46.6711
                    },
                    "face_image": null,
                    "vehicles": [
                        {
                            "id": 109,
                            "driver_id": 338,
                            "type": 1,
                            "plate_number": "zzz1234",
                            "status": "active",
                            "vehicle_size": "medium",
                            "is_default": false,
                            "images": {
                                "registration": "https://greenhub.sa-fvs.com/storage/vehicle-registrations/CUuH0OX6sWoN69ZINPPOsbCSCBUBHIxQ38NMphEK.png",
                                "authorization": null,
                                "front": "https://greenhub.sa-fvs.com/storage/vehicle-images/bC6koDEtcYwmdi78xHuRDylXxcLtnsmhSKTMzIlY.png",
                                "back": "https://greenhub.sa-fvs.com/storage/vehicle-images/YkrpCmyXXpKYTsKBloEDbFls8n4VjUKQiOq08TVo.png",
                                "left": "https://greenhub.sa-fvs.com/storage/vehicle-images/9REXetGDMfXZieDWTjFTW9bPRS7rNjSwOD5MXYPm.png",
                                "right": "https://greenhub.sa-fvs.com/storage/vehicle-images/DL4WkPW4K3NpiMq23MbIkt1SLcQovW4sTAwlldjS.png",
                                "combined": "https://greenhub.sa-fvs.com/storage/vehicle-images/combined/44d4b2bd-0fb9-4bfe-9712-ab4b31546da3.jpg"
                            },
                            "vehicle_type": {
                                "id": 1,
                                "code": "bike",
                                "name": "دراجة نارية",
                                "name_ar": "دراجة نارية",
                                "name_en": "Motorcycle",
                                "image": null,
                                "is_active": true
                            },
                            "created_at": "2026-03-07T14:04:10.000000Z",
                            "updated_at": "2026-03-07T14:04:10.000000Z"
                        }
                    ],
                    "created_at": "2026-03-04T12:07:16.000000Z",
                    "updated_at": "2026-03-09T18:33:43.000000Z"
                }
            }
        ],
        "created_at": "2026-03-10T11:47:23.000000Z",
        "updated_at": "2026-03-10T11:54:23.000000Z"
    }
}
8. Example error JSON?
{
    "message": "No query results for model [App\\Models\\Order] 480"
}
9. Post-success behavior?
   - Show message?
   - Navigate?
   - Save cache?
ihavent this 
10. Post-error behavior?
    - Show message?
    - Stay on screen?
    - Reset form?
ihavent this 
11. Does this feature require:
   - Pagination?
   - Multipart upload?
   - Debounce?
   - Pull-to-refresh?
   - Infinite scroll?
Pull-to-refresh 
12. Any special logic or business rule that should be considered?

order_details.dart#L44
 
  "name": "دراجة نارية",
                                "name_ar": "دراجة نارية",
                                "name_en": "Motorcycle",

order_details.dart#L52
 
            "weight": "124.00",

order_details.dart#L53
 
      "name": "مواد بناء",
                "name_ar": "مواد بناء",
                "name_en": "Building Materials",

order_details.dart#L54
 
  "contact_phone": "966503211231",


order_details.dart#L61
             "address": "MPX3+JQW بجانب وكالة بورش،، شارع الأمير عبدالعزيز بن مساعد بن جلوي، السليمانية، الرياض 12234، السعودية, السليمانية, الرياض, منطقة الرياض",

order_details.dart#L63
 
            "address": "REJB7826، 7826 أبي الحرم الكاتب، 5128، حي جرير، الرياض 12837، السعودية, حي جرير, الرياض, منطقة الرياض",

order_details.dart#L71-73
 
        "notes": "bbb",

order_details.dart#L79
 
                    "name": "سائق اختبار كامل",

order_details.dart#L80
 
      "face_image": null,
if null  icon.person

order_details.dart#L81
     "rateing": "5.0",

order_details.dart#L89
 
            "driver_offer_price": null,


order_details.dart#L90
 
   "vat_amount": 15,

order_details.dart#L91
 
            "final_price": null,



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