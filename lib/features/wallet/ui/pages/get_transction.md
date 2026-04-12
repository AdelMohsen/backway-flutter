
wallet
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

transaction_history_widget.dart

2. Is it new feature or inside existing module?
inside this module 

wallet

3. Endpoint constant name? (to add in api_names.dart)
/wallet/transactions?type=credit&page=1&per_page=20
4. HTTP method? (GET / POST / PUT / PATCH / DELETE)
GET 
5. Does it require authentication?
iwnt token
6. Request type:
   - Body?
   - Query parameters?
   - Path parameters?
Query parameters 
type
page
per_page
7. Example success JSON?
{
    "success": true,
    "data": {
        "current_page": 1,
        "data": [
            {
                "id": 7,
                "transaction_id": "TXN-20260311-FB2A6C10",
                "user_id": 338,
                "order_id": null,
                "type": "deposit",
                "amount": "450.00",
                "balance_before": "100.00",
                "balance_after": "550.00",
                "status": "completed",
                "description": "Deposit via credit_card",
                "metadata": null,
                "created_at": "2026-03-11T13:35:46.000000Z",
                "updated_at": "2026-03-11T13:35:46.000000Z",
                "order": null
            },
            {
                "id": 5,
                "transaction_id": "TXN-20260309-287A76C1",
                "user_id": 338,
                "order_id": null,
                "type": "deposit",
                "amount": "100.00",
                "balance_before": "0.00",
                "balance_after": "100.00",
                "status": "completed",
                "description": "Deposit via credit_card",
                "metadata": null,
                "created_at": "2026-03-09T18:33:43.000000Z",
                "updated_at": "2026-03-09T18:33:43.000000Z",
                "order": null
            }
        ],
        "first_page_url": "https://greenhub.sa-fvs.com/api/v1/wallet/transactions?page=1",
        "from": 1,
        "last_page": 1,
        "last_page_url": "https://greenhub.sa-fvs.com/api/v1/wallet/transactions?page=1",
        "links": [
            {
                "url": null,
                "label": "&laquo; Previous",
                "page": null,
                "active": false
            },
            {
                "url": "https://greenhub.sa-fvs.com/api/v1/wallet/transactions?page=1",
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
        "path": "https://greenhub.sa-fvs.com/api/v1/wallet/transactions",
        "per_page": 20,
        "prev_page_url": null,
        "to": 2,
        "total": 2
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
 ihave Pagination and Pull-to-refresh
12. Any special logic or business rule that should be considered?

transaction_history_widget.dart#L31
 
   "total": 9

transaction_history_widget.dart#L90
 
    "transaction_id": "TXN-20260311-9F4D5791",

transaction_history_widget.dart#L100
 
   "amount": "300.00",

transaction_history_widget.dart#L147
 
                "created_at": "2026-03-11T14:19:32.000000Z",

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