@order_tracking  You are an autonomous senior Flutter engineer working inside an EXISTING production Flutter project.

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
 @order_tracking
2. Is it new feature or inside existing module?
inside this module  @order_tracking
3. Endpoint constant name? (to add in api_names.dart)
/customer/orders/418/track
4. HTTP method? (GET / POST / PUT / PATCH / DELETE)
GET 
5. Does it require authentication?
yes ihave token
6. Request type:
   - Body?
   - Query parameters?
   - Path parameters?
ihavent this 
7. Example success JSON?
{
    "success": true,
    "data": {
        "order": {
            "id": 418,
            "order_number": "ORD-20260310-BE1439",
            "status": {
                "key": "picked_up",
                "label": "تم الاستلام"
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
                "final_price": "1430.60",
                "vat_amount": "186.60",
                "platform_fee": "124.40",
                "driver_earnings": "1119.60"
            },
            "scheduled_at": "2026-03-31T00:00:00.000000Z",
            "accepted_at": "2026-03-10T13:10:57.000000Z",
            "picked_up_at": "2026-03-12T14:53:19.000000Z",
            "delivered_at": null,
            "cancelled_at": null,
            "driver": {
                "id": 338,
                "name": "سائق اختبار كامل",
                "phone": "966507654322",
                "rateing": "5.0",
                "number_of_rateing": "100",
                "commission_rate": "10.00",
                "is_online": false,
                "current_location": {
                    "lat": 31.032176,
                    "lng": 31.3697445
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
                    },
                    {
                        "id": 111,
                        "driver_id": 338,
                        "type": 3,
                        "plate_number": "578754",
                        "status": "active",
                        "vehicle_size": "medium",
                        "is_default": false,
                        "images": {
                            "registration": null,
                            "authorization": null,
                            "front": null,
                            "back": null,
                            "left": null,
                            "right": null,
                            "combined": null
                        },
                        "vehicle_type": {
                            "id": 3,
                            "code": "truck",
                            "name": "شاحنة",
                            "name_ar": "شاحنة",
                            "name_en": "Truck",
                            "image": null,
                            "is_active": true
                        },
                        "created_at": "2026-03-12T04:58:57.000000Z",
                        "updated_at": "2026-03-12T04:58:57.000000Z"
                    },
                    {
                        "id": 112,
                        "driver_id": 338,
                        "type": 2,
                        "plate_number": "47954",
                        "status": "active",
                        "vehicle_size": "medium",
                        "is_default": false,
                        "images": {
                            "registration": null,
                            "authorization": null,
                            "front": null,
                            "back": null,
                            "left": null,
                            "right": null,
                            "combined": null
                        },
                        "vehicle_type": {
                            "id": 2,
                            "code": "car",
                            "name": "سيارة",
                            "name_ar": "سيارة",
                            "name_en": "Car",
                            "image": null,
                            "is_active": true
                        },
                        "created_at": "2026-03-12T05:01:43.000000Z",
                        "updated_at": "2026-03-12T05:01:43.000000Z"
                    },
                    {
                        "id": 113,
                        "driver_id": 338,
                        "type": 1,
                        "plate_number": "11111111111",
                        "status": "active",
                        "vehicle_size": "large",
                        "is_default": false,
                        "images": {
                            "registration": null,
                            "authorization": null,
                            "front": null,
                            "back": null,
                            "left": null,
                            "right": null,
                            "combined": null
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
                        "created_at": "2026-03-12T05:05:07.000000Z",
                        "updated_at": "2026-03-12T05:05:07.000000Z"
                    }
                ],
                "created_at": "2026-03-04T12:07:16.000000Z",
                "updated_at": "2026-03-12T16:46:41.000000Z"
            },
            "created_at": "2026-03-10T11:47:23.000000Z",
            "updated_at": "2026-03-12T14:53:19.000000Z"
        },
        "driver_location": {
            "lat": 31.032176,
            "lng": 31.3697445
        },
        "driver_online": false
    }
}
8. Example error JSON?
{
    "message": "No query results for model [App\\Models\\Order] 444"
}
9. Post-success behavior?
   - Show message?
   - Navigate?
   - Save cache?
 no ihavent this
10. Post-error behavior?
    - Show message?
    - Stay on screen?
    - Reset form?
 Show message and Stay on screen
11. Does this feature require:
   - Pagination?
   - Multipart upload?
   - Debounce?
   - Pull-to-refresh?
   - Infinite scroll?

Pull-to-refresh
12. Does this feature require :
   -  deafault native loading screen?
   -  deafault native loading on button?
   -  shimmer loading ?
deafault native loading screen

13. Any special logic or business rule that should be considered?
"I need to build a 'Step-by-Step' delivery progress system. Here is the ordered list: driver_on_way_to_pickup, arrived_at_pickup, picked_up, on_delivery, arrived_at_delivery, and delivered.

The Logic Rules:

All statuses start as Active (meaning they are pending).

When a driver clicks a status (e.g., picked_up), that specific status AND all previous statuses in the list must change to Inactive (marking them as completed/finished).

The statuses following the clicked one must remain Active (marking them as 'yet to come').

Include a cancelled status that, if triggered, sets everything to Inactive.

Return the code with a clear mapping of English and Arabic labels for each key."

driver_info_card.dart#L171-188
 

driver_info_card.dart#L194-309
 

driver_info_card.dart#L118
 
this         "name": "سائق اختبار كامل",

driver_info_card.dart#L146
 
   "rateing": "5.0",

driver_info_card.dart#L154
 
                "number_of_rateing": "100",

driver_info_card.dart#L76
 
  "status": {
                "key": "picked_up",
                "label": "تم الاستلام"
            },
Marker(
        markerId: const MarkerId('pickup'),
        position: widget.orderData.pickupLocation,
        icon:
            _locationIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: InfoWindow(
          title: 'نقطة الاستلام',
          snippet: widget.orderData.pickupAddress,
        ),
      ),  
this   "pickup": {
                "address": "MPX3+JQW بجانب وكالة بورش،، شارع الأمير عبدالعزيز بن مساعد بن جلوي، السليمانية، الرياض 12234، السعودية, السليمانية, الرياض, منطقة الرياض",
                "location": {
                    "lat": 24.6993059,
                    "lng": 46.7041573
                },
 Marker(
        markerId: const MarkerId('delivery'),
        position: widget.orderData.deliveryLocation,
        icon:
            _locationIcon ??
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: 'نقطة التسليم',
          snippet: widget.orderData.deliveryAddress,
        ),
      ),
  "delivery": {
                "address": "REJB7826، 7826 أبي الحرم الكاتب، 5128، حي جرير، الرياض 12837، السعودية, حي جرير, الرياض, منطقة الرياض",
                "location": {
                    "lat": 24.6770024,
                    "lng": 46.7575004
                },
  if (widget.orderData.currentDriverLocation != null)
        Marker(
          markerId: const MarkerId('driver'),
          position: widget.orderData.currentDriverLocation!,
          icon:
              _customIcon ??
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          infoWindow: const InfoWindow(title: 'موقع السائق الحالي'),
        ),
    };
  }   "name": "سائق اختبار كامل",
                "phone": "966507654322",
                "rateing": "5.0",
                "number_of_rateing": "100",
                "commission_rate": "10.00",
                "is_online": false,
                "current_location": {
                    "lat": 31.032176,
                    "lng": 31.3697445
                },
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