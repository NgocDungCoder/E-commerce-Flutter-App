// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Dress`
  String get dress {
    return Intl.message('Dress', name: 'dress', desc: '', args: []);
  }

  /// `T-Shirt`
  String get tshirt {
    return Intl.message('T-Shirt', name: 'tshirt', desc: '', args: []);
  }

  /// `Bag`
  String get bag {
    return Intl.message('Bag', name: 'bag', desc: '', args: []);
  }

  /// `Shoes`
  String get shoes {
    return Intl.message('Shoes', name: 'shoes', desc: '', args: []);
  }

  /// `New Arrival`
  String get newArrival {
    return Intl.message('New Arrival', name: 'newArrival', desc: '', args: []);
  }

  /// `Explore more`
  String get explore {
    return Intl.message('Explore more', name: 'explore', desc: '', args: []);
  }

  /// `Collection`
  String get collection {
    return Intl.message('Collection', name: 'collection', desc: '', args: []);
  }

  /// `Just For You`
  String get forYou {
    return Intl.message('Just For You', name: 'forYou', desc: '', args: []);
  }

  /// `Trending`
  String get trending {
    return Intl.message('Trending', name: 'trending', desc: '', args: []);
  }

  /// `About`
  String get about {
    return Intl.message('About', name: 'about', desc: '', args: []);
  }

  /// `Contact`
  String get contact {
    return Intl.message('Contact', name: 'contact', desc: '', args: []);
  }

  /// `Blog`
  String get blog {
    return Intl.message('Blog', name: 'blog', desc: '', args: []);
  }

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  /// `Account Setting`
  String get accountSetting {
    return Intl.message(
      'Account Setting',
      name: 'accountSetting',
      desc: '',
      args: [],
    );
  }

  /// `Account`
  String get account {
    return Intl.message('Account', name: 'account', desc: '', args: []);
  }

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Account / Bank Card`
  String get credit {
    return Intl.message(
      'Account / Bank Card',
      name: 'credit',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get setting {
    return Intl.message('Settings', name: 'setting', desc: '', args: []);
  }

  /// `Chat Settings`
  String get settingChat {
    return Intl.message(
      'Chat Settings',
      name: 'settingChat',
      desc: '',
      args: [],
    );
  }

  /// `Notification Settings`
  String get settingNoti {
    return Intl.message(
      'Notification Settings',
      name: 'settingNoti',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Support`
  String get support {
    return Intl.message('Support', name: 'support', desc: '', args: []);
  }

  /// `Contact Store`
  String get contactStore {
    return Intl.message(
      'Contact Store',
      name: 'contactStore',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Policy`
  String get termsPolicy {
    return Intl.message(
      'Terms and Policy',
      name: 'termsPolicy',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message('About Us', name: 'aboutUs', desc: '', args: []);
  }

  /// `Delete Account Request`
  String get deleteAccountRequest {
    return Intl.message(
      'Delete Account Request',
      name: 'deleteAccountRequest',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `Account & Security`
  String get accountSecurity {
    return Intl.message(
      'Account & Security',
      name: 'accountSecurity',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login with `
  String get loginWith {
    return Intl.message('Login with ', name: 'loginWith', desc: '', args: []);
  }

  /// `Login with OTP`
  String get loginOtp {
    return Intl.message('Login with OTP', name: 'loginOtp', desc: '', args: []);
  }

  /// `Use fingerprint`
  String get useFingerprint {
    return Intl.message(
      'Use fingerprint',
      name: 'useFingerprint',
      desc: '',
      args: [],
    );
  }

  /// `Send notification`
  String get sendNotification {
    return Intl.message(
      'Send notification',
      name: 'sendNotification',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get member {
    return Intl.message('Member', name: 'member', desc: '', args: []);
  }

  /// `Purchase Order`
  String get purchaseOrder {
    return Intl.message(
      'Purchase Order',
      name: 'purchaseOrder',
      desc: '',
      args: [],
    );
  }

  /// `View Purchase History`
  String get purchaseHistory {
    return Intl.message(
      'View Purchase History',
      name: 'purchaseHistory',
      desc: '',
      args: [],
    );
  }

  /// `Confirmation`
  String get waitingForConfirmation {
    return Intl.message(
      'Confirmation',
      name: 'waitingForConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Pickup`
  String get waitingForPickup {
    return Intl.message('Pickup', name: 'waitingForPickup', desc: '', args: []);
  }

  /// `Delivery`
  String get waitingForDelivery {
    return Intl.message(
      'Delivery',
      name: 'waitingForDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Utilities`
  String get utilities {
    return Intl.message('Utilities', name: 'utilities', desc: '', args: []);
  }

  /// `E-Wallet`
  String get eWallet {
    return Intl.message('E-Wallet', name: 'eWallet', desc: '', args: []);
  }

  /// `Voucher Storage`
  String get voucherStorage {
    return Intl.message(
      'Voucher Storage',
      name: 'voucherStorage',
      desc: '',
      args: [],
    );
  }

  /// `Liked`
  String get liked {
    return Intl.message('Liked', name: 'liked', desc: '', args: []);
  }

  /// `Chat with Staff`
  String get chatWithStaff {
    return Intl.message(
      'Chat with Staff',
      name: 'chatWithStaff',
      desc: '',
      args: [],
    );
  }

  /// `You May Also Like`
  String get youMayAlsoLike {
    return Intl.message(
      'You May Also Like',
      name: 'youMayAlsoLike',
      desc: '',
      args: [],
    );
  }

  /// `Rating`
  String get rating {
    return Intl.message('Rating', name: 'rating', desc: '', args: []);
  }

  /// `Edit profile`
  String get editProfile {
    return Intl.message(
      'Edit profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Setup now`
  String get setupNow {
    return Intl.message('Setup now', name: 'setupNow', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Birthday`
  String get birthday {
    return Intl.message('Birthday', name: 'birthday', desc: '', args: []);
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Linked account`
  String get linkedAccount {
    return Intl.message(
      'Linked account',
      name: 'linkedAccount',
      desc: '',
      args: [],
    );
  }

  /// `Update order`
  String get updateOrder {
    return Intl.message(
      'Update order',
      name: 'updateOrder',
      desc: '',
      args: [],
    );
  }

  /// `Read all`
  String get readAll {
    return Intl.message('Read all', name: 'readAll', desc: '', args: []);
  }

  /// `Shop now`
  String get shopNow {
    return Intl.message('Shop now', name: 'shopNow', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Total items`
  String get totalItems {
    return Intl.message('Total items', name: 'totalItems', desc: '', args: []);
  }

  /// `Total price`
  String get totalPrice {
    return Intl.message('Total price', name: 'totalPrice', desc: '', args: []);
  }

  /// `Buy now`
  String get buyNow {
    return Intl.message('Buy now', name: 'buyNow', desc: '', args: []);
  }

  /// `Products`
  String get product {
    return Intl.message('Products', name: 'product', desc: '', args: []);
  }

  /// `Sold`
  String get sold {
    return Intl.message('Sold', name: 'sold', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message('Add to cart', name: 'addToCart', desc: '', args: []);
  }

  /// `Material`
  String get material {
    return Intl.message('Material', name: 'material', desc: '', args: []);
  }

  /// `Care`
  String get care {
    return Intl.message('Care', name: 'care', desc: '', args: []);
  }

  /// `Free shipping`
  String get freeShipping {
    return Intl.message(
      'Free shipping',
      name: 'freeShipping',
      desc: '',
      args: [],
    );
  }

  /// `Express shipping`
  String get expressShipping {
    return Intl.message(
      'Express shipping',
      name: 'expressShipping',
      desc: '',
      args: [],
    );
  }

  /// `Same day delivery`
  String get sameDayDelivery {
    return Intl.message(
      'Same day delivery',
      name: 'sameDayDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message('Checkout', name: 'checkout', desc: '', args: []);
  }

  /// `Shipping address`
  String get shippingAddress {
    return Intl.message(
      'Shipping address',
      name: 'shippingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add voucher`
  String get addVoucher {
    return Intl.message('Add voucher', name: 'addVoucher', desc: '', args: []);
  }

  /// `Shipping`
  String get shipping {
    return Intl.message('Shipping', name: 'shipping', desc: '', args: []);
  }

  /// `Free`
  String get free {
    return Intl.message('Free', name: 'free', desc: '', args: []);
  }

  /// `Payment method`
  String get paymentMethod {
    return Intl.message(
      'Payment method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Cash on delivery`
  String get cod {
    return Intl.message('Cash on delivery', name: 'cod', desc: '', args: []);
  }

  /// `Credit/Debit card`
  String get creditDebitCard {
    return Intl.message(
      'Credit/Debit card',
      name: 'creditDebitCard',
      desc: '',
      args: [],
    );
  }

  /// `Payment details`
  String get paymentDetail {
    return Intl.message(
      'Payment details',
      name: 'paymentDetail',
      desc: '',
      args: [],
    );
  }

  /// `Shipping fee total`
  String get shippingFee {
    return Intl.message(
      'Shipping fee total',
      name: 'shippingFee',
      desc: '',
      args: [],
    );
  }

  /// `Voucher discount`
  String get shippingDiscount {
    return Intl.message(
      'Voucher discount',
      name: 'shippingDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Total payment`
  String get totalPayment {
    return Intl.message(
      'Total payment',
      name: 'totalPayment',
      desc: '',
      args: [],
    );
  }

  /// `Saving`
  String get saving {
    return Intl.message('Saving', name: 'saving', desc: '', args: []);
  }

  /// `Order`
  String get placeOrder {
    return Intl.message('Order', name: 'placeOrder', desc: '', args: []);
  }

  /// `Order Detail`
  String get order {
    return Intl.message('Order Detail', name: 'order', desc: '', args: []);
  }

  /// `Order Completed`
  String get orderCompleted {
    return Intl.message(
      'Order Completed',
      name: 'orderCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Information`
  String get shippingInfo {
    return Intl.message(
      'Shipping Information',
      name: 'shippingInfo',
      desc: '',
      args: [],
    );
  }

  /// `Product List`
  String get productList {
    return Intl.message(
      'Product List',
      name: 'productList',
      desc: '',
      args: [],
    );
  }

  /// `Need Help?`
  String get needHelp {
    return Intl.message('Need Help?', name: 'needHelp', desc: '', args: []);
  }

  /// `Send Return Request`
  String get sendReturnRequest {
    return Intl.message(
      'Send Return Request',
      name: 'sendReturnRequest',
      desc: '',
      args: [],
    );
  }

  /// `Support Center`
  String get supportCenter {
    return Intl.message(
      'Support Center',
      name: 'supportCenter',
      desc: '',
      args: [],
    );
  }

  /// `Order Code`
  String get orderCode {
    return Intl.message('Order Code', name: 'orderCode', desc: '', args: []);
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `Order Time`
  String get orderTime {
    return Intl.message('Order Time', name: 'orderTime', desc: '', args: []);
  }

  /// `Order Completed Time`
  String get completeTime {
    return Intl.message(
      'Order Completed Time',
      name: 'completeTime',
      desc: '',
      args: [],
    );
  }

  /// `Show Less`
  String get showLess {
    return Intl.message('Show Less', name: 'showLess', desc: '', args: []);
  }

  /// `Order Detail`
  String get orderDetail {
    return Intl.message(
      'Order Detail',
      name: 'orderDetail',
      desc: '',
      args: [],
    );
  }

  /// `Delivered Successfully`
  String get deliverySuccess {
    return Intl.message(
      'Delivered Successfully',
      name: 'deliverySuccess',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message('Register', name: 'register', desc: '', args: []);
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account ?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have an account ?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email to reset your password`
  String get enterEmailToResetPassword {
    return Intl.message(
      'Enter your email to reset your password',
      name: 'enterEmailToResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Send Password Reset Email`
  String get sendResetEmail {
    return Intl.message(
      'Send Password Reset Email',
      name: 'sendResetEmail',
      desc: '',
      args: [],
    );
  }

  /// `Go Back`
  String get goBack {
    return Intl.message('Go Back', name: 'goBack', desc: '', args: []);
  }

  /// `Send OTP`
  String get sendOtp {
    return Intl.message('Send OTP', name: 'sendOtp', desc: '', args: []);
  }

  /// `Invalid email`
  String get invalidEmail {
    return Intl.message(
      'Invalid email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwordNotMatch {
    return Intl.message(
      'Passwords do not match',
      name: 'passwordNotMatch',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
