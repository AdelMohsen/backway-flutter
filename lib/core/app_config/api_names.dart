/// 📡 API Endpoints Configuration
/// This file contains all API endpoint paths used in the application.
abstract class Endpoints {
  // ═══════════════════════════════════════════════════════════════════════════
  // 🔐 AUTHENTICATION
  // ═══════════════════════════════════════════════════════════════════════════

  /// Customer send OTP for login
  static const String sendOtp = '/auth/customer/send-otp';

  /// Verify OTP and login (returns token)
  static const String verifyOtpThenLogin = '/auth/customer/verify-otp';

  /// Verify Registration OTP (returns token)
  static const String verifyRegisterOtp = '/auth/customer/register/verify-otp';

  /// Customer register (sends OTP)
  static const String register = '/auth/customer/register';

  // ═══════════════════════════════════════════════════════════════════════════
  // 👤 USER PROFILE
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get current user info
  static const String getUserInfo = '/customer/profile';

  /// Update current user profile
  static const String updateProfile = '/customer/profile';

  /// Logout user
  static const String logout = '/customer/logout';

  /// Delete user account
  static const String deleteAccount = '/customer/delete-account';

  // ═══════════════════════════════════════════════════════════════════════════
  // 📍 ADDRESS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get all addresses
  static const String getAddresses = '/customer/addresses';

  /// Add new address
  static const String addAddress = '/customer/addresses';

  /// Update address (used as '/customer/addresses/{id}')
  static const String updateAddress = '/customer/addresses';

  /// Get all regions
  static const String regions = '/regions';

  /// Get cities by region (usage: '${Endpoints.regionCities}/ID/cities')
  static const String regionCities = '/regions';

  // ═══════════════════════════════════════════════════════════════════════════
  // 📦 ORDERS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Create a new order
  static const String createOrder = '/customer/orders';



  /// Get orders list
  static const String getOrders = '/customer/orders';

  /// Rate an order (driver)
  static String rateDriver(int id) => '/ratings/order/$id';

  /// Get exact order details
  static String getOrderDetails(int id) => '/customer/orders/$id';

  /// Track specific order
  static String trackOrder(int id) => '/customer/orders/$id/track';

  /// Track order by order number (Home)
  static String trackOrderHome(String orderNumber) => '/customer/orders/$orderNumber/track';

  /// Cancel an order
  static String cancelOrder(int id) => '/customer/orders/$id/cancel';

  /// Get order invoice
  static String getInvoice(int id) => '/customer/orders/$id/invoice';

  /// Customer negotiations (offers)
  static const String customerNegotiations = '/customer/negotiations';

  /// Reject driver negotiation offer
  static String rejectNegotiation(int orderId, int negotiationId) =>
      '/customer/orders/$orderId/negotiations/$negotiationId/reject';

  /// Accept driver negotiation offer
  static String acceptNegotiation(int orderId, int negotiationId) =>
      '/customer/orders/$orderId/negotiations/$negotiationId/accept';

  /// Get available vehicle types
  static const String vehicleTypes = '/vehicle-types';

  /// Get available package types
  static const String packageTypes = '/package-types';

  // ═══════════════════════════════════════════════════════════════════════════
  // 💰 WALLET
  // ═══════════════════════════════════════════════════════════════════════════

  /// Add funds to wallet
  static const String addFunds = '/wallet/add-funds';

  /// Get wallet transactions
  static const String walletTransactions = '/wallet/transactions';

  /// Get wallet balance
  static const String walletBalance = '/wallet/balance';

  // ═══════════════════════════════════════════════════════════════════════════
  // 🖼️ APP IMAGES
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get app images (banners, etc.)
  static const String appImages = '/app-images';

  // ═══════════════════════════════════════════════════════════════════════════
  // ⚙️ APP SETTINGS
  // ═══════════════════════════════════════════════════════════════════════════

  /// App settings
  static const String appSettings = '/settings';

  /// Complaints
  static const String complaints = '/complaints';

  /// Social links
  static const String socialLinks = '/social-links';
  static const String about = '/content/about';
  static const String services = '/content/services';

  /// Messages
  static const String chat = '/chat';
  static String orderChat(int orderId) => '/chat/order/$orderId';
  static String sendOrderChatMessage(int orderId) => '/chat/order/$orderId/message';
  static String openChat(int orderId) => '/chat/order/$orderId/open';
  static String addService(int orderId) => '/customer/orders/$orderId/add-service';

  /// Notifications
  static const String notifications = '/notifications';
  static const String readAllNotifications = '/notifications/read-all';
  static const String notificationUnreadCount = '/notifications/unread-count';

  /// Enable Notification
  static const String enableNotification = '/customer/notifications';

  /// Pusher broadcasting auth
  static const String broadcastingAuth = '/broadcasting/auth';
}
