 

add_address
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

add_address

2. Is it new feature or inside existing module?
 نعم، هي ضمن الوحدة الموجودة بالفعل. 

add_address

3. Endpoint constant name? (to add in api_names.dart)
/customer/addresses
4. HTTP method? (GET / POST / PUT / PATCH / DELETE)
POST 
5. Does it require authentication?
yes iwnt token 
6. Request type:
   - Body?
   - Query parameters?
   - Path parameters?
{
    "type": "home",
    "address": "مكة حي النخيل، شارع ",
    "latitude": 21.37630,
    "longitude": 39.79460,
    "building_number": "1233",
    "floor": "11",
    "apartment": "A2",
    "is_default": true,
     "region_id":"2",
    "city_id": "2",
    "notes": "ملاحظات",
    "street_address": "النخيل، شارع",
        "district":"الفيصلية"

}Body
7. Example success JSON?
{
    "success": true,
    "message": "Address added successfully",
    "data": {
        "id": 4,
        "type": "home",
        "title": "النخيل، شارع، حي: الفيصلية، نعمي، منطقة مكة المكرمة، دور: 11، شقة: A2",
        "street_address": "النخيل، شارع",
        "building": null,
        "floor": "11",
        "apartment": "A2",
        "district": "الفيصلية",
        "landmark": null,
        "is_default": true,
        "region": {
            "id": 2,
            "name": "منطقة مكة المكرمة",
            "code": null
        },
        "city": {
            "id": 2,
            "name": "نعمي",
            "region_id": 7
        },
        "created_at": "2026-03-01T12:09:06.000000Z",
        "updated_at": "2026-03-01T12:09:06.000000Z"
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
Show message and  Navigate to 

address_screen.dart

10. Post-error behavior?
    - Show message?
    - Stay on screen?
    - Reset form?
Show message Stay on screen
11. Does this feature require:
   - Pagination?
   - Multipart upload?
   - Debounce?
   - Pull-to-refresh?
   - Infinite scroll?
 no ihavent them 
12. Any special logic or business rule that should be considered?

 هنا عند اضفاة عنوان    "region_id":"2",
    "city_id": "2",

دول عبار عن دروب داون فيهم محافظات والمدن هنجيبهم من Reustاخر وهو /regions?lang=ar دة هيجيب المناطق ودى الداتا بتظهر {
    "success": true,
    "data": [
    
       
        {
            "id": 6051,
            "region_id": 2,
            "name": "حرف المروة"
        },
        {
            "id": 6052,
            "region_id": 2,
            "name": "فريدة الصلة"
        },
        {
            "id": 6137,
            "region_id": 2,
            "name": "الطراحية"
        },
        {
            "id": 6138,
            "region_id": 2,
            "name": "المساعيد"
        },
        {
            "id": 6175,
            "region_id": 2,
            "name": "الفلحة"
        },
        {
            "id": 6302,
            "region_id": 2,
            "name": "ضهياء"
        },
        {
            "id": 6778,
            "region_id": 2,
            "name": "حفار"
        },
        {
            "id": 6907,
            "region_id": 2,
            "name": "الصغو"
        },
        {
            "id": 7035,
            "region_id": 2,
            "name": "غران"
        },
        {
            "id": 7642,
            "region_id": 2,
            "name": "الركنة"
        },
        {
            "id": 7680,
            "region_id": 2,
            "name": "الشباشبة"
        },
        {
            "id": 8238,
            "region_id": 2,
            "name": "الغريسة"
        },
        {
            "id": 8653,
            "region_id": 2,
            "name": "المطحنه"
        },
        {
            "id": 8654,
            "region_id": 2,
            "name": "الجناح"
        },
        {
            "id": 8749,
            "region_id": 2,
            "name": "مشرف"
        },
        {
            "id": 9176,
            "region_id": 2,
            "name": "دقم الذنيب"
        },
        {
            "id": 23640,
            "region_id": 2,
            "name": "العرضية الجنوبية"
        },
        {
            "id": 23641,
            "region_id": 2,
            "name": "العرضيات"
        },
        {
            "id": 23642,
            "region_id": 2,
            "name": "العرضية الشمالية"
        },
        {
            "id": 23660,
            "region_id": 2,
            "name": "بطاط"
        }
    ]
} الاتتنين محتاجين توكن بردة عايزك تكريت كل حاجة زى Address لcity و region 

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