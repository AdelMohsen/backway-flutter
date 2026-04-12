
new_order
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

new_order
 this is feature
2. Is it new feature or inside existing module?
inside this folder 

new_order

3. Endpoint constant name? (to add in api_names.dart)
/customer/orders?lang=ar
4. HTTP method? (GET / POST / PUT / PATCH / DELETE)
POST 
5. Does it require authentication?
yes iwnt token
6. Request type:
   - Body?
   - Query parameters?
   - Path parameters?
   {
  type :
vehicle_type_id:
service_type:
service_type:
package_type_id:
vehicles_count:
package_size
package_weight:
notes:
pickup_lat:
pickup_lng
pickup_address:
delivery_address:
delivery_lat:
delivery_lng:
delivery_contact_phone:
package_images[]:


}
7. Example success JSON?
{
    "success": true,
    "message": "Order created successfully",
    "data": {
        "id": 376,
        "order_number": "ORD-20260303-EAA40F",
        "status": {
            "key": "pending",
            "label": "order.status.pending"
        },
        "type": {
            "key": "instant",
            "label": "order.type.instant"
        },
        "service_type": {
            "key": "transport",
            "label": "order.service_type.transport"
        },
        "vehicles_count": "1",
        "notes": "يوجد مصعد في الموقع",
        "pickup": {
            "address": "الرياض - حي العليا",
            "location": {
                "lat": 24.7136,
                "lng": 46.6753
            },
            "contact_name": "مريم",
            "contact_phone": "9665013456732"
        },
        "delivery": {
            "address": "الرياض - حي الملقا",
            "location": {
                "lat": 24.7743,
                "lng": 46.7386
            },
            "contact_name": null,
            "contact_phone": "966500000002"
        },
        "package": {
            "type": {
                "id": 1,
                "name": "أثاث",
                "name_ar": "أثاث",
                "name_en": "Furniture",
                "is_active": true,
                "sort_order": 1
            },
            "weight": "15.00",
            "size": {
                "key": "medium",
                "label": "order.package_size.medium"
            },
            "images": []
        },
        "pricing": {
            "customer_offer_price": null,
            "driver_offer_price": null,
            "final_price": null,
            "vat_amount": null,
            "platform_fee": null,
            "driver_earnings": null
        },
        "scheduled_at": null,
        "accepted_at": null,
        "picked_up_at": null,
        "delivered_at": null,
        "cancelled_at": null,
        "driver": null,
        "negotiations": [],
        "created_at": "2026-03-03T11:26:54.000000Z",
        "updated_at": "2026-03-03T11:26:54.000000Z"
    }
}

8. Example error JSON?
{
    "success": false,
    "message": "Validation failed",
    "errors": {
        "type": [
            "The type field is required."
        ]
    }
}
9. Post-success behavior?
   - Show message?
   - Navigate?
   - Save cache?
Show message and navigate step screen   currentStep = 2; 

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
  no ihavent this
12. Any special logic or business rule that should be considered?
type this is filed  final int? orderType; 
orderType: orderType); by this   int selectedType = 0;  this is type 
instant,scheduled 
vehicle_type_id this is by 
هنجيب الvechile by this request 
/vehicle-types?lang=ar 
this is endpoint 
{
    "success": true,
    "data": [
        {
            "id": 1,
            "code": "bike",
            "name": "دراجة نارية",
            "image": "https://greenhub.sa-fvs.com/assets/dashboard/cars.png"
        },
        {
            "id": 2,
            "code": "car",
            "name": "سيارة",
            "image": "https://greenhub.sa-fvs.com/assets/dashboard/cars.png"
        },
        {
            "id": 3,
            "code": "truck",
            "name": "شاحنة",
            "image": "https://greenhub.sa-fvs.com/assets/dashboard/cars.png"
        }
    ]
}   this is 

transport_type_section_widget.dart#L53-78
 
 service_type this is installation,transport 

transport_type_section_widget.dart#L81-179
 
package_type_id ده هنجيبة عن طريق request 
/package-types?lang=en this is endpoint 
{
    "success": true,
    "data": [
        {
            "id": 1,
            "name": "أثاث"
        },
        {
            "id": 2,
            "name": "أجهزة كهربائية"
        },
        {
            "id": 3,
            "name": "مواد بناء"
        },
        {
            "id": 4,
            "name": "بضائع تجارية"
        },
        {
            "id": 5,
            "name": "مستندات"
        },
        {
            "id": 6,
            "name": "أخرى"
        }
    ]
} this is data 

shipment_data_section_widget.dart#L127-151
 
vehicles_count this is int 

shipment_data_section_widget.dart#L174-254





 package_size this is small,medium,large add opinal 
package_weight this is 

shipment_data_section_widget.dart#L92-117



notes this is  

notes_section_widget.dart#L10
 
pickup_lat and pickup_lng 

address_section_widget.dart#L72-94
 
عايز لما اضغط يحدد lat and lng يفتح خريطة ويحدد منها ويبقى فى زى سيرش فوق اقدر اجيب منة الموقع 
عايز بعد ميختار الموقع ياخد addressيحطة مكان                  hintText: AppStrings.selectStartingPoint.tr,
عشان يبان اننا اختارت المكان 
pickup_address دة هبعتة عن طريق lat lng للى جبناهم من الخريطة 

delivery_lat and delivery_lng 
نفس الكلام على الفيلد دة 

address_section_widget.dart#L148-170
 

delivery_address 
نفس الكلام هنحدد lat and lng هيظهر 
delivery_address                    hintText: AppStrings.selectDestination.tr,
ويبعتة 

shipment_data_section_widget.dart#L162-170
 

package_images[] this عبارة عن file 
عايز ددة ممكن يكون كاميرا او الاستوديو وعايز لو الصورة حجمها زاد  3ميجا يبعت زى توست حجم الصورة كبير 


delivery_contact_phone فاهس 
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