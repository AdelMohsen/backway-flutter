
notification
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
this 

notification
 
2. Is it new feature or inside existing module?
inside this module 

notification
 
3. Endpoint constant name? (to add in api_names.dart)
/notifications
4. HTTP method? (GET / POST / PUT / PATCH / DELETE)
GET 
5. Does it require authentication?
iwnt token 
6. Request type:
   - Body?
   - Query parameters?
   - Path parameters?
Query parameters
page
per_page
lang

7. Example success JSON?
{
    "success": true,
    "data": {
        "current_page": 1,
        "data": [
            {
                "id": 63,
                "user_id": 339,
                "recipient_type": null,
                "type": "new_message",
                "title": "رسالة جديدة",
                "title_en": null,
                "body": "test33 انا السواق مرحباً، نعم وصلت للعنوان",
                "body_en": null,
                "data": {
                    "chat_id": 3,
                    "order_id": 446,
                    "message_id": 19,
                    "sender_id": 338,
                    "i18n": {
                        "ar": {
                            "title": "رسالة جديدة",
                            "body": "test33 انا السواق مرحباً، نعم وصلت للعنوان"
                        },
                        "en": {
                            "title": "New message",
                            "body": "test33 انا السواق مرحباً، نعم وصلت للعنوان"
                        }
                    }
                },
                "is_read": false,
                "read_at": null,
                "created_at": "2026-03-18T16:57:11.000000Z",
                "updated_at": "2026-03-18T16:57:11.000000Z",
                "title_localized": "رسالة جديدة",
                "body_localized": "test33 انا السواق مرحباً، نعم وصلت للعنوان",
                "icon": "https://greenhub.sa-fvs.com/favicon-16x16.png"
            }
        ],
        "first_page_url": "https://greenhub.sa-fvs.com/api/v1/notifications?page=1",
        "from": 1,
        "last_page": 1,
        "last_page_url": "https://greenhub.sa-fvs.com/api/v1/notifications?page=1",
        "links": [
            {
                "url": null,
                "label": "&laquo; Previous",
                "page": null,
                "active": false
            },
            {
                "url": "https://greenhub.sa-fvs.com/api/v1/notifications?page=1",
                "label": "1",
                "page": 1,
                "active": true
            },
            {
                "url": null,
                "label": "Next &raquo;",
                "page": null,
                "active": false
            }
        ],
        "next_page_url": null,
        "path": "https://greenhub.sa-fvs.com/api/v1/notifications",
        "per_page": 20,
        "prev_page_url": null,
        "to": 1,
        "total": 1
    },
    "unread_count": 1
}
8. Example error JSON?
{
    "message": "Unauthenticated."
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
 Stay on screen
11. Does this feature require:
   - Pagination?
   - Multipart upload?
   - Debounce?
   - Pull-to-refresh?
   - Infinite scroll?
ihave Pagination and Pull-to-refresh

12. Does this feature require :
   -  deafault native loading screen?
   -  deafault native loading on button?
   -  shimmer loading ?
 shimmer loading

13. Any special logic or business rule that should be considered?

notifications_screen.dart#L59
 
  "title": "رسالة جديدة",
  body:
                      'احصل على خصم 20% عند استخدام InstaPay للدفع اليوم فقط!',
                  time: 'من ساعة واحدة',
       "body": "test33 انا السواق مرحباً، نعم وصلت للعنوان",
type
   "type": "new_message",
هنا فية انواع الtype
NotificationType _resolveType(String type) {
    switch (type) {
      case 'new_order':
        return NotificationType.orderSuccess;
      case 'offer':
        return NotificationType.offer;
      case 'new_message':
        return NotificationType.message;
      case 'update_order':
      case 'general':
      default:
        return NotificationType.update;
    }
  }

notifications_screen.dart#L64
 
   "is_read": false,

notification_card.dart#L56-65
 
      "icon": "https://greenhub.sa-fvs.com/favicon-16x16.png"
     time: 'من 5 ساعات',
 "created_at": "2026-03-18T16:57:11.000000Z",


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