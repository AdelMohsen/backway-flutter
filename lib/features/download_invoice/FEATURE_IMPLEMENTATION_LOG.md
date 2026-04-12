# Feature: Download Invoice

## 1. Endpoint Info
- HTTP Method: GET
- Endpoint Constant: `Endpoints.getInvoice(id)` -> `/customer/orders/$id/invoice`
- Requires Auth: Yes
- Request Type: Query Parameters (`lang`)
- Status Codes: 200 (Success), 4xx/5xx (Error)

## 2. Request Flow
UI (`DownloadInvoiceScreen`) → Cubit (`DownloadInvoiceCubit`) → Repository (`DownloadInvoiceRepository`) → Network (`Network().request`) → Backend → Model (`InvoiceModel`) → Cubit (`SuccessState`) → UI (Update widgets with `InvoiceData`)

## 3. Files Created
- `lib/features/download_invoice/data/params/download_invoice_params.dart`
- `lib/features/download_invoice/data/models/invoice_model.dart`
- `lib/features/download_invoice/data/repository/download_invoice_repository.dart`
- `lib/features/download_invoice/logic/state/download_invoice_state.dart`
- `lib/features/download_invoice/logic/cubit/download_invoice_cubit.dart`
- `lib/features/download_invoice/FEATURE_IMPLEMENTATION_LOG.md` (This file)

## 4. Params Explanation
`DownloadInvoiceParams` handles the `lang` query parameter. It uses `mainAppBloc.globalLang` to provide the current language of the app to the API.

## 5. Model Explanation
`InvoiceModel` represents the complete backend response. `InvoiceData` contains:
- `invoice_number`, `order_number`, `invoice_date`
- `company`: Name, address, tax number.
- `labels`: Localized labels for UI headers/rows.
- `amounts`: Subtotal, VAT rate, VAT amount, and total.
- `qr_code`: URL for the invoice QR code.

## 6. Repository Logic
Uses the static method pattern. It calls `Network().request` with `ServerMethods.GET`. It handles errors using `ApiErrorHandler().handleError(error)` and returns an `Either<ErrorEntity, InvoiceModel>`.

## 7. State Management Logic
- `DownloadInvoiceInitial`: Initial state before fetching.
- `DownloadInvoiceLoading`: Emitted while fetching data (triggers Shimmer UI).
- `DownloadInvoiceSuccess`: Emitted when data is successfully fetched (contains `InvoiceData`).
- `DownloadInvoiceError`: Emitted on failure (contains `ErrorEntity` to display the message).

## 8. Error Handling
The Cubit uses `fold` on the repository result. If a `Left` is returned, it emits `DownloadInvoiceError`. The UI then displays the message from `ErrorEntity.message`.

## 9. Localization Keys Added
No new keys were added to `app_strings.dart` as the labels are primarily fetched from the backend or already existed. Fallbacks use existing `AppStrings`.

## 10. Post-Success Behavior
The UI updates to display the invoice details, header, and QR code. Action buttons remain functional. Action for PDF download is a TODO depending on backend implementation for the actual file.

## 11. Post-Error Behavior
An error message is displayed with a "Try Again" button to re-trigger the fetch.

## 12. Future Update Notes
- To add a new field: Update `InvoiceData` model and add the corresponding row in `InvoiceDetailsSectionWidget`.
- To modify response: Update manual `fromJson` in `InvoiceModel`.
- To add PDF download: Implement file download logic in `onDownload` using `Network` download method or `url_launcher`.
