@offers  You are an autonomous senior Flutter engineer working inside an EXISTING production Flutter project.

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

ui

2. Is it new feature or inside existing module?
inside this module offers
3. Endpoint constant name? (to add in api_names.dart)
/customer/negotiations 
4. HTTP method? (GET / POST / PUT / PATCH / DELETE)
GET 
5. Does it require authentication?
yes ihave token
6. Request type:
   - Body?
   - Query parameters?
   - Path parameters?
7. Example success JSON?
{
    "success": true,
    "data": [
        {
            "id": 24,
            "order_id": 397,
            "driver_id": 338,
            "offered_price": "21.50",
            "message": "أستطيع التوصيل خلال 12 دقيقة",
            "status": "counter_offered",
            "status_label": "negotiation.status.counter_offered",
            "created_at": "2026-03-08T01:46:25.000000Z",
            "updated_at": "2026-03-08T11:19:04.000000Z",
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
                "updated_at": "2026-03-09T13:20:13.000000Z"
            }
        },
        {
            "id": 25,
            "order_id": 398,
            "driver_id": 338,
            "offered_price": "22.50",
            "message": null,
            "status": "counter_offered",
            "status_label": "negotiation.status.counter_offered",
            "created_at": "2026-03-08T10:29:29.000000Z",
            "updated_at": "2026-03-08T11:34:47.000000Z",
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
                "updated_at": "2026-03-09T13:20:13.000000Z"
            }
        },
        {
            "id": 28,
            "order_id": 401,
            "driver_id": 338,
            "offered_price": "500.00",
            "message": null,
            "status": "counter_offered",
            "status_label": "negotiation.status.counter_offered",
            "created_at": "2026-03-08T20:45:23.000000Z",
            "updated_at": "2026-03-08T21:39:05.000000Z",
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
                "updated_at": "2026-03-09T13:20:13.000000Z"
            }
        },
        {
            "id": 30,
            "order_id": 403,
            "driver_id": 338,
            "offered_price": "444.00",
            "message": "أستطيع التوصيل خلال 4 دقيقة",
            "status": "counter_offered",
            "status_label": "negotiation.status.counter_offered",
            "created_at": "2026-03-08T21:54:30.000000Z",
            "updated_at": "2026-03-09T12:25:13.000000Z",
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
                "updated_at": "2026-03-09T13:20:13.000000Z"
            }
        },
        {
            "id": 31,
            "order_id": 404,
            "driver_id": 338,
            "offered_price": "35.50",
            "message": "أستطيع التوصيل خلال 25 دقيقة",
            "status": "counter_offered",
            "status_label": "negotiation.status.counter_offered",
            "created_at": "2026-03-08T23:06:57.000000Z",
            "updated_at": "2026-03-09T00:05:54.000000Z",
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
                "updated_at": "2026-03-09T13:20:13.000000Z"
            }
        },
        {
            "id": 34,
            "order_id": 407,
            "driver_id": 338,
            "offered_price": "400.00",
            "message": "أستطيع التوصيل خلال 4 دقيقة",
            "status": "counter_offered",
            "status_label": "negotiation.status.counter_offered",
            "created_at": "2026-03-09T12:26:42.000000Z",
            "updated_at": "2026-03-09T12:29:13.000000Z",
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
                "updated_at": "2026-03-09T13:20:13.000000Z"
            }
        }
    ]
}
8. Example error JSON?
{
    "message": "Unauthenticated."
}
9. Post-success behavior?
   - Show message?
   - Navigate?
   - Save cache?
10. Post-error behavior?
    - Show message?
    - Stay on screen?
    - Reset form?

11. Does this feature require:
   - Pagination?
   - Multipart upload?
   - Debounce?
   - Pull-to-refresh?
   - Infinite scroll?
Pull-to-refresh 
12. Any special logic or business rule that should be considered?

        

offer_card.dart#L47
 
 this face_image 
if null avatar default 

offer_carrier_avatar.dart#L12
 

offer_card.dart#L50
 
this tis   "name": "سائق اختبار كامل",

offer_card.dart#L51
 
            "order_id": 397,

offer_card.dart#L52
 
            "offered_price": "21.50",

offer_card.dart#L55
 
                "rateing": "5.0",


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