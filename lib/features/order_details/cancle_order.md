
order_details
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

order_details

2. Is it new feature or inside existing module?
inside 

order_details

3. Endpoint constant name? (to add in api_names.dart)
/customer/orders/403/cancel
4. HTTP method? (GET / POST / PUT / PATCH / DELETE)
POST 
5. Does it require authentication?
iwnt token 
6. Request type:
   - Body?
   - Query parameters?
   - Path parameters?
Body 
reason : string 

7. Example success JSON?
{
    "success": true,
    "message": "Order cancelled successfully"
}
8. Example error JSON?
{
    "message": "No query results for model [App\\Models\\Order] 410"
}
9. Post-success behavior?
   - Show message?
   - Navigate?
   - Save cache?
Show message and navigate 

navbar_layout_cubit.dart#L76
 
this index
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
 ihavent this
12. Any special logic or business rule that should be considered?

order_details.dart#L184
 
when tap  show bottomsheet exactly this  and cancle order import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ship_hub_deliveries/core/navigation/custom_navigation.dart';
import 'package:ship_hub_deliveries/core/services/toast/toast_service.dart';
import 'package:ship_hub_deliveries/core/theme/colors/styles.dart';
import 'package:ship_hub_deliveries/core/theme/text_styles/text_styles.dart';
import 'package:ship_hub_deliveries/core/utils/constant/app_strings.dart';
import 'package:ship_hub_deliveries/core/utils/extensions/extensions.dart';
import 'package:ship_hub_deliveries/core/utils/widgets/buttons/default_button.dart';
import 'package:ship_hub_deliveries/core/utils/widgets/form_fields/default_username_form_field.dart';
import 'package:ship_hub_deliveries/features/home/logic/cubit/cancel_order_cubit.dart';
import 'package:ship_hub_deliveries/features/home/logic/state/cancel_order_state.dart';

class CancelOrderBottomSheet extends StatefulWidget {
  final int orderId;

  const CancelOrderBottomSheet({Key? key, required this.orderId})
    : super(key: key);

  @override
  State<CancelOrderBottomSheet> createState() => _CancelOrderBottomSheetState();
}

class _CancelOrderBottomSheetState extends State<CancelOrderBottomSheet> {
  final _reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CancelOrderCubit(),
      child: BlocConsumer<CancelOrderCubit, CancelOrderState>(
        listener: (context, state) {
          if (state is CancelOrderSuccess) {
            ToastService.showSuccess(
              state.model.message.isNotEmpty
                  ? state.model.message
                  : AppStrings.cancelOrderSuccess.tr,
              context,
            );
            CustomNavigator.pop();
          }
          if (state is CancelOrderError) {
            ToastService.showError(state.error.message, context);
          }
        },
        builder: (context, state) {
          final isLoading = state is CancelOrderLoading;
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Drag Handle
                      Center(
                        child: Container(
                          width: 48,
                          height: 4,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E0E0),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),

                      // Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.cancelOrderReason.tr,
                            style: AppTextStyles.ibmPlexSansSize18w600White
                                .copyWith(color: Colors.black),
                          ),
                          InkWell(
                            onTap: () => CustomNavigator.pop(),
                            child: Container(
                              child: Center(
                                child: const Icon(
                                  Icons.close,
                                  size: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color.fromRGBO(161, 161, 161, 1),
                                  width: 1.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Divider(
                          height: 1,
                          color: Color.fromRGBO(225, 233, 239, 1),
                        ),
                      ),

                      const SizedBox(height: 12),

                      DefaultUsernameFormField(
                        controller: _reasonController,
                        hintText: AppStrings.cancelOrderReason.tr,
                        fillColor: const Color(0xffF7F7F7),
                        borderRadious: 44,
                        contentPadding: const EdgeInsetsDirectional.fromSTEB(
                          15,
                          15,
                          15,
                          15,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return AppStrings.pleaseEnterCancelReason.tr;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      // Confirm Button
                      DefaultButton(
                        text: AppStrings.confirm.tr,
                        backgroundColor: AppColors.primaryGreenHub,
                        borderRadiusValue: 45,
                        height: 60,
                        isLoading: isLoading,
                        onPressed: () {
                          _onSubmit(context);
                        },
                        textStyle: AppTextStyles.ibmPlexSansSize16w600Black
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _onSubmit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final reasonText = _reasonController.text.trim();

    CancelOrderCubit.get(
      context,
    ).cancelOrder(orderId: widget.orderId, reason: reasonText);
  }
}
 

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