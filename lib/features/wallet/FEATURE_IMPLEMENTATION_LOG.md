# Feature: Wallet Add Funds (Recharge Balance)

## 1. Endpoint Info
- **HTTP Method**: POST
- **Endpoint Constant**: `Endpoints.addFunds` → `/wallet/add-funds`
- **Requires Auth**: Yes (Bearer token injected automatically by `Network`)
- **Request Type**: JSON Body
- **Expected Status**: 200 (success), 422 (validation error)

## 2. Request Flow
```
UI (RechargeBalanceScreen)
  → AddFundsCubit.addFunds(amount, paymentMethod)
    → AddFundsRepo.addFunds(AddFundsParams)
      → Network().request(POST /wallet/add-funds, body)
      → Right(AddFundsResponseModel) or Left(ErrorEntity)
    → emit AddFundsSuccess or AddFundsError
  → BlocListener handles toast + navigation
```

## 3. Files Created (Add Funds)
| File | Path |
|------|------|
| Params | `data/params/add_funds_params.dart` |
| Model | `data/models/add_funds_model.dart` |
| Repository | `data/repository/add_funds_repo.dart` |
| State | `logic/state/add_funds_state.dart` |
| Cubit | `logic/cubit/add_funds_cubit.dart` |

---

# Feature: Wallet Transactions List

## 1. Endpoint Info
- **HTTP Method**: GET
- **Endpoint Constant**: `Endpoints.walletTransactions` → `/wallet/transactions`
- **Requires Auth**: Yes (Bearer token)
- **Request Type**: Query parameters (`type`, `page`, `per_page`)
- **Expected Status**: 200 (success), 401 (unauthenticated)

## 2. Request Flow
```
UI (WalletScreen)
  → WalletCubit.fetchWalletData(type)
    → WalletBalanceRepo.getBalance() AND WalletTransactionsRepo.getTransactions(params)
    → Network().request(GET ...)
    → Right(WalletBalanceResponseModel) / Right(WalletTransactionsResponseModel)
  → emit WalletLoaded or WalletError
  → BlocBuilder in WalletBalanceCard and TransactionHistoryWidget renders data
```

## 3. Files Created/Modified (Transactions & Balance)
| File | Path |
|------|------|
| Params | `data/params/wallet_transactions_params.dart`, `wallet_balance_params.dart` |
| Model | `data/models/wallet_transactions_model.dart`, `wallet_balance_model.dart` |
| Repository | `data/repository/wallet_transactions_repo.dart`, `wallet_balance_repo.dart` |
| State *(Unified)* | `logic/state/wallet_state.dart` |
| Cubit *(Unified)* | `logic/cubit/wallet_cubit.dart` |

## 4. Params Explanation
- `type` (String?) → filter by transaction type (e.g. `'credit'`)
- `page` (int) → current page number, defaults to 1
- `per_page` (int) → items per page, defaults to 20

## 5. Model Explanation
- `WalletTransactionsResponseModel`: wraps pagination metadata (`current_page`, `last_page`, `total`) and list of `WalletTransactionModel`
- `WalletTransactionModel`: maps `transaction_id`, `type`, `amount`, `balance_before`, `balance_after`, `status`, `description`, `created_at`

## 6. State Management Logic (Unified WalletState)
- `WalletInitial` → default
- `WalletLoading` → initial load for both balance and first page of transactions
- `WalletPaginationLoading` → loading next page of transactions (keeps balance and existing transactions)
- `WalletLoaded` → carries `balanceData`, `transactions` list, and pagination meta
- `WalletError` → carries `ErrorEntity`

## 7. Pagination
- `fetchWalletData()` → resets to page 1, clears list, fetches balance
- `fetchMoreTransactions()` → increments page, appends to existing list
- `hasMorePages` → checks `currentPage < lastPage`
- Auto-triggered when user scrolls to the pagination loader item

## 8. Pull-to-Refresh
- `onRefresh()` → calls `fetchWalletData()` which resets to page 1 and fetches balance again
- `RefreshIndicator` wraps `SingleChildScrollView` in `WalletScreen`

## 9. Localization Keys Added
| Key | EN | AR |
|-----|----|----|
| `rechargeSuccess` | Balance recharged successfully | تم شحن الرصيد بنجاح |
| `rechargeFailed` | Failed to recharge balance | فشل شحن الرصيد |
| `pleaseEnterAmount` | Please enter the amount | الرجاء إدخال المبلغ |
| `deposit` | Deposit | إيداع |
| `withdrawal` | Withdrawal | سحب |
| `noTransactionsFound` | No transactions found | لا توجد معاملات |

## 10. Future Update Notes
- **Add transaction type filter tabs**: Add a tab bar in the UI, pass different `type` values to the cubit
- **Add date range filter**: Add `from_date`/`to_date` to `WalletTransactionsParams.returnedMap()`
- **Modify response**: Update `WalletTransactionModel.fromJson()` and add new fields
