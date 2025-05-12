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

class TR {
  TR();

  static TR? _current;

  static TR get current {
    assert(_current != null,
        'No instance of TR was loaded. Try to initialize the TR delegate before accessing TR.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<TR> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = TR();
      TR._current = instance;

      return instance;
    });
  }

  static TR of(BuildContext context) {
    final instance = TR.maybeOf(context);
    assert(instance != null,
        'No instance of TR present in the widget tree. Did you add TR.delegate in localizationsDelegates?');
    return instance!;
  }

  static TR? maybeOf(BuildContext context) {
    return Localizations.of<TR>(context, TR);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgot_password {
    return Intl.message(
      'Forgot password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Reset password`
  String get reset_password {
    return Intl.message(
      'Reset password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get change_password {
    return Intl.message(
      'Change password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `update password`
  String get update_password {
    return Intl.message(
      'update password',
      name: 'update_password',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
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

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Active Status`
  String get activeStatus {
    return Intl.message(
      'Active Status',
      name: 'activeStatus',
      desc: '',
      args: [],
    );
  }

  /// `General`
  String get general {
    return Intl.message(
      'General',
      name: 'general',
      desc: '',
      args: [],
    );
  }

  /// `Others`
  String get others {
    return Intl.message(
      'Others',
      name: 'others',
      desc: '',
      args: [],
    );
  }

  /// `Referral Rewards`
  String get referralRewards {
    return Intl.message(
      'Referral Rewards',
      name: 'referralRewards',
      desc: '',
      args: [],
    );
  }

  /// `View Order`
  String get viewOrder {
    return Intl.message(
      'View Order',
      name: 'viewOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order Number`
  String get orderNumber {
    return Intl.message(
      'Order Number',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `See All`
  String get seeAll {
    return Intl.message(
      'See All',
      name: 'seeAll',
      desc: '',
      args: [],
    );
  }

  /// `New Orders`
  String get newOrders {
    return Intl.message(
      'New Orders',
      name: 'newOrders',
      desc: '',
      args: [],
    );
  }

  /// `Order History`
  String get orderHistory {
    return Intl.message(
      'Order History',
      name: 'orderHistory',
      desc: '',
      args: [],
    );
  }

  /// `Reject Order`
  String get rejectOrder {
    return Intl.message(
      'Reject Order',
      name: 'rejectOrder',
      desc: '',
      args: [],
    );
  }

  /// `Reviews`
  String get reviews {
    return Intl.message(
      'Reviews',
      name: 'reviews',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Live Tracking`
  String get liveTracking {
    return Intl.message(
      'Live Tracking',
      name: 'liveTracking',
      desc: '',
      args: [],
    );
  }

  /// `Order info`
  String get orderInfo {
    return Intl.message(
      'Order info',
      name: 'orderInfo',
      desc: '',
      args: [],
    );
  }

  /// `Swipe to Deliver`
  String get swipeToDeliver {
    return Intl.message(
      'Swipe to Deliver',
      name: 'swipeToDeliver',
      desc: '',
      args: [],
    );
  }

  /// `Accepted`
  String get accepted {
    return Intl.message(
      'Accepted',
      name: 'accepted',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Your Friends`
  String get yourFriends {
    return Intl.message(
      'Your Friends',
      name: 'yourFriends',
      desc: '',
      args: [],
    );
  }

  /// `Refer a Friend`
  String get referAFriend {
    return Intl.message(
      'Refer a Friend',
      name: 'referAFriend',
      desc: '',
      args: [],
    );
  }

  /// `Referral Lists`
  String get referralLists {
    return Intl.message(
      'Referral Lists',
      name: 'referralLists',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Transaction`
  String get transaction {
    return Intl.message(
      'Transaction',
      name: 'transaction',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `My Profile`
  String get myProfile {
    return Intl.message(
      'My Profile',
      name: 'myProfile',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Select Location`
  String get selectLocation {
    return Intl.message(
      'Select Location',
      name: 'selectLocation',
      desc: '',
      args: [],
    );
  }

  /// `Submit`
  String get submit {
    return Intl.message(
      'Submit',
      name: 'submit',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get getStarted {
    return Intl.message(
      'Get Started',
      name: 'getStarted',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Have an account already?`
  String get haveAccount {
    return Intl.message(
      'Have an account already?',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get signIn {
    return Intl.message(
      'Sign In',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Continue with Phone`
  String get continueWithPhone {
    return Intl.message(
      'Continue with Phone',
      name: 'continueWithPhone',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter phone number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter Password`
  String get enterPassword {
    return Intl.message(
      'Enter Password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password`
  String get forgotPassword {
    return Intl.message(
      'Forgot password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Message`
  String get enterMessage {
    return Intl.message(
      'Enter Message',
      name: 'enterMessage',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get message {
    return Intl.message(
      'Message',
      name: 'message',
      desc: '',
      args: [],
    );
  }

  /// `Subject`
  String get subject {
    return Intl.message(
      'Subject',
      name: 'subject',
      desc: '',
      args: [],
    );
  }

  /// `Create Ticket`
  String get createTicket {
    return Intl.message(
      'Create Ticket',
      name: 'createTicket',
      desc: '',
      args: [],
    );
  }

  /// `Priority`
  String get priority {
    return Intl.message(
      'Priority',
      name: 'priority',
      desc: '',
      args: [],
    );
  }

  /// `Select Priority`
  String get selectPriority {
    return Intl.message(
      'Select Priority',
      name: 'selectPriority',
      desc: '',
      args: [],
    );
  }

  /// `Attachment`
  String get attachment {
    return Intl.message(
      'Attachment',
      name: 'attachment',
      desc: '',
      args: [],
    );
  }

  /// `Attached Files`
  String get attachedFiles {
    return Intl.message(
      'Attached Files',
      name: 'attachedFiles',
      desc: '',
      args: [],
    );
  }

  /// `Upload a file`
  String get uploadAFile {
    return Intl.message(
      'Upload a file',
      name: 'uploadAFile',
      desc: '',
      args: [],
    );
  }

  /// `Page Not Found`
  String get notFound {
    return Intl.message(
      'Page Not Found',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Assign Order`
  String get assignOrder {
    return Intl.message(
      'Assign Order',
      name: 'assignOrder',
      desc: '',
      args: [],
    );
  }

  /// `longitude`
  String get longitude {
    return Intl.message(
      'longitude',
      name: 'longitude',
      desc: '',
      args: [],
    );
  }

  /// `latitude`
  String get latitude {
    return Intl.message(
      'latitude',
      name: 'latitude',
      desc: '',
      args: [],
    );
  }

  /// `Enter Address`
  String get enterAddress {
    return Intl.message(
      'Enter Address',
      name: 'enterAddress',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Help & Support Ticket`
  String get helpSupportTicket {
    return Intl.message(
      'Help & Support Ticket',
      name: 'helpSupportTicket',
      desc: '',
      args: [],
    );
  }

  /// `Analytics`
  String get analytics {
    return Intl.message(
      'Analytics',
      name: 'analytics',
      desc: '',
      args: [],
    );
  }

  /// `Total Orders`
  String get totalOrders {
    return Intl.message(
      'Total Orders',
      name: 'totalOrders',
      desc: '',
      args: [],
    );
  }

  /// `Success rates`
  String get successRates {
    return Intl.message(
      'Success rates',
      name: 'successRates',
      desc: '',
      args: [],
    );
  }

  /// `Pending rates`
  String get pendingRates {
    return Intl.message(
      'Pending rates',
      name: 'pendingRates',
      desc: '',
      args: [],
    );
  }

  /// `Earnings History`
  String get earningsHistory {
    return Intl.message(
      'Earnings History',
      name: 'earningsHistory',
      desc: '',
      args: [],
    );
  }

  /// `Customer Chat`
  String get customerChat {
    return Intl.message(
      'Customer Chat',
      name: 'customerChat',
      desc: '',
      args: [],
    );
  }

  /// `Deliveryman Chat`
  String get deliverymanChat {
    return Intl.message(
      'Deliveryman Chat',
      name: 'deliverymanChat',
      desc: '',
      args: [],
    );
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `My Wallet`
  String get myWallet {
    return Intl.message(
      'My Wallet',
      name: 'myWallet',
      desc: '',
      args: [],
    );
  }

  /// `No`
  String get no {
    return Intl.message(
      'No',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Accept`
  String get accept {
    return Intl.message(
      'Accept',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Enter note`
  String get enterNote {
    return Intl.message(
      'Enter note',
      name: 'enterNote',
      desc: '',
      args: [],
    );
  }

  /// `Assign By me`
  String get assignByMe {
    return Intl.message(
      'Assign By me',
      name: 'assignByMe',
      desc: '',
      args: [],
    );
  }

  /// `User Name`
  String get userName {
    return Intl.message(
      'User Name',
      name: 'userName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Referral Configuration`
  String get referralConfiguration {
    return Intl.message(
      'Referral Configuration',
      name: 'referralConfiguration',
      desc: '',
      args: [],
    );
  }

  /// `KYC Log`
  String get kycLog {
    return Intl.message(
      'KYC Log',
      name: 'kycLog',
      desc: '',
      args: [],
    );
  }

  /// `Assign Time`
  String get assignTime {
    return Intl.message(
      'Assign Time',
      name: 'assignTime',
      desc: '',
      args: [],
    );
  }

  /// `All Order`
  String get allOrder {
    return Intl.message(
      'All Order',
      name: 'allOrder',
      desc: '',
      args: [],
    );
  }

  /// `Search by order number...`
  String get searchByOrderNumber {
    return Intl.message(
      'Search by order number...',
      name: 'searchByOrderNumber',
      desc: '',
      args: [],
    );
  }

  /// `Weekly`
  String get weekly {
    return Intl.message(
      'Weekly',
      name: 'weekly',
      desc: '',
      args: [],
    );
  }

  /// `Monthly`
  String get monthly {
    return Intl.message(
      'Monthly',
      name: 'monthly',
      desc: '',
      args: [],
    );
  }

  /// `Yearly`
  String get yearly {
    return Intl.message(
      'Yearly',
      name: 'yearly',
      desc: '',
      args: [],
    );
  }

  /// `Don’t hesitate to contact us whether you have a suggestion on our improvement, a complain to discuss or an issue to solve.`
  String get dontHesitateToContactUs {
    return Intl.message(
      'Don’t hesitate to contact us whether you have a suggestion on our improvement, a complain to discuss or an issue to solve.',
      name: 'dontHesitateToContactUs',
      desc: '',
      args: [],
    );
  }

  /// `Call us`
  String get callUs {
    return Intl.message(
      'Call us',
      name: 'callUs',
      desc: '',
      args: [],
    );
  }

  /// `Enter Current Password`
  String get enterCurrentPassword {
    return Intl.message(
      'Enter Current Password',
      name: 'enterCurrentPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter New Password`
  String get enterNewPassword {
    return Intl.message(
      'Enter New Password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter New Password`
  String get reenterNewPassword {
    return Intl.message(
      'Re-enter New Password',
      name: 'reenterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Not Match`
  String get notMatch {
    return Intl.message(
      'Not Match',
      name: 'notMatch',
      desc: '',
      args: [],
    );
  }

  /// `Become a Delivery Boy`
  String get becomeADeliveryBoy {
    return Intl.message(
      'Become a Delivery Boy',
      name: 'becomeADeliveryBoy',
      desc: '',
      args: [],
    );
  }

  /// `Update Password`
  String get updatePassword {
    return Intl.message(
      'Update Password',
      name: 'updatePassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Confirm Password`
  String get enterYourConfirmPassword {
    return Intl.message(
      'Enter Your Confirm Password',
      name: 'enterYourConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Become a Delivery Partner Today`
  String get becomeADeliveryPartnerToday {
    return Intl.message(
      'Become a Delivery Partner Today',
      name: 'becomeADeliveryPartnerToday',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get aboutUs {
    return Intl.message(
      'About Us',
      name: 'aboutUs',
      desc: '',
      args: [],
    );
  }

  /// `Success Delivered`
  String get successDelivered {
    return Intl.message(
      'Success Delivered',
      name: 'successDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Pending Delivered`
  String get pendingDelivered {
    return Intl.message(
      'Pending Delivered',
      name: 'pendingDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Enter first name`
  String get enterFirstName {
    return Intl.message(
      'Enter first name',
      name: 'enterFirstName',
      desc: '',
      args: [],
    );
  }

  /// `Enter last name`
  String get enterLastName {
    return Intl.message(
      'Enter last name',
      name: 'enterLastName',
      desc: '',
      args: [],
    );
  }

  /// `Enter user name`
  String get enterUserName {
    return Intl.message(
      'Enter user name',
      name: 'enterUserName',
      desc: '',
      args: [],
    );
  }

  /// `Enter email address`
  String get enterEmailAddress {
    return Intl.message(
      'Enter email address',
      name: 'enterEmailAddress',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Select Country`
  String get selectCountry {
    return Intl.message(
      'Select Country',
      name: 'selectCountry',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Enter Confirm password`
  String get enterConfirmPassword {
    return Intl.message(
      'Enter Confirm password',
      name: 'enterConfirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter referral code`
  String get enterReferralCode {
    return Intl.message(
      'Enter referral code',
      name: 'enterReferralCode',
      desc: '',
      args: [],
    );
  }

  /// `Referral Code`
  String get referralCode {
    return Intl.message(
      'Referral Code',
      name: 'referralCode',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP`
  String get enterOtp {
    return Intl.message(
      'Enter OTP',
      name: 'enterOtp',
      desc: '',
      args: [],
    );
  }

  /// `Enter OTP Code`
  String get enterOtpCode {
    return Intl.message(
      'Enter OTP Code',
      name: 'enterOtpCode',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get resetPassword {
    return Intl.message(
      'Reset Password',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enterYourPhoneNumber {
    return Intl.message(
      'Enter your phone number',
      name: 'enterYourPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Write your message`
  String get writeYourMessage {
    return Intl.message(
      'Write your message',
      name: 'writeYourMessage',
      desc: '',
      args: [],
    );
  }

  /// `Online`
  String get online {
    return Intl.message(
      'Online',
      name: 'online',
      desc: '',
      args: [],
    );
  }

  /// `Long time ago`
  String get longTimeAgo {
    return Intl.message(
      'Long time ago',
      name: 'longTimeAgo',
      desc: '',
      args: [],
    );
  }

  /// `Total Withdraw`
  String get totalWithdraw {
    return Intl.message(
      'Total Withdraw',
      name: 'totalWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Pending Withdraw`
  String get pendingWithdraw {
    return Intl.message(
      'Pending Withdraw',
      name: 'pendingWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Reject Withdraw`
  String get rejectWithdraw {
    return Intl.message(
      'Reject Withdraw',
      name: 'rejectWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Enter the track id...`
  String get enterTheTrackId {
    return Intl.message(
      'Enter the track id...',
      name: 'enterTheTrackId',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to Reject this order?`
  String get areYouSureToRejectThisOrder {
    return Intl.message(
      'Are you sure to Reject this order?',
      name: 'areYouSureToRejectThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `Reject`
  String get reject {
    return Intl.message(
      'Reject',
      name: 'reject',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Chart`
  String get withdrawChart {
    return Intl.message(
      'Withdraw Chart',
      name: 'withdrawChart',
      desc: '',
      args: [],
    );
  }

  /// `Earning Chart`
  String get earningChart {
    return Intl.message(
      'Earning Chart',
      name: 'earningChart',
      desc: '',
      args: [],
    );
  }

  /// `Request Order`
  String get requestOrder {
    return Intl.message(
      'Request Order',
      name: 'requestOrder',
      desc: '',
      args: [],
    );
  }

  /// `No Data Found`
  String get noDataFound {
    return Intl.message(
      'No Data Found',
      name: 'noDataFound',
      desc: '',
      args: [],
    );
  }

  /// `KYC Logs`
  String get kycLogs {
    return Intl.message(
      'KYC Logs',
      name: 'kycLogs',
      desc: '',
      args: [],
    );
  }

  /// `KYC Details`
  String get kycDetails {
    return Intl.message(
      'KYC Details',
      name: 'kycDetails',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get status {
    return Intl.message(
      'Status',
      name: 'status',
      desc: '',
      args: [],
    );
  }

  /// `FeedBack`
  String get feedback {
    return Intl.message(
      'FeedBack',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `Kyc not verified`
  String get kycNotVerified {
    return Intl.message(
      'Kyc not verified',
      name: 'kycNotVerified',
      desc: '',
      args: [],
    );
  }

  /// `Go to Home`
  String get goToHome {
    return Intl.message(
      'Go to Home',
      name: 'goToHome',
      desc: '',
      args: [],
    );
  }

  /// `Apply for KYC verification`
  String get applyForKycVerification {
    return Intl.message(
      'Apply for KYC verification',
      name: 'applyForKycVerification',
      desc: '',
      args: [],
    );
  }

  /// `Verify KYC`
  String get verifyKyc {
    return Intl.message(
      'Verify KYC',
      name: 'verifyKyc',
      desc: '',
      args: [],
    );
  }

  /// `Delete all notifications?`
  String get deleteAllNotifications {
    return Intl.message(
      'Delete all notifications?',
      name: 'deleteAllNotifications',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete all notifications? This action cannot be undone.`
  String get areYouSureYouWantToDeleteAllNotificationsThis {
    return Intl.message(
      'Are you sure you want to delete all notifications? This action cannot be undone.',
      name: 'areYouSureYouWantToDeleteAllNotificationsThis',
      desc: '',
      args: [],
    );
  }

  /// `Delete this notification?`
  String get deleteThisNotification {
    return Intl.message(
      'Delete this notification?',
      name: 'deleteThisNotification',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this notification?`
  String get areYouSureYouWantToDeleteThisNotification {
    return Intl.message(
      'Are you sure you want to delete this notification?',
      name: 'areYouSureYouWantToDeleteThisNotification',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Order id`
  String get orderId {
    return Intl.message(
      'Order id',
      name: 'orderId',
      desc: '',
      args: [],
    );
  }

  /// `Total Earning: `
  String get totalEarning {
    return Intl.message(
      'Total Earning: ',
      name: 'totalEarning',
      desc: '',
      args: [],
    );
  }

  /// `Assign Date`
  String get assignDate {
    return Intl.message(
      'Assign Date',
      name: 'assignDate',
      desc: '',
      args: [],
    );
  }

  /// `Order Date`
  String get orderDate {
    return Intl.message(
      'Order Date',
      name: 'orderDate',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Information`
  String get shippingInformation {
    return Intl.message(
      'Shipping Information',
      name: 'shippingInformation',
      desc: '',
      args: [],
    );
  }

  /// `Billing Address`
  String get billingAddress {
    return Intl.message(
      'Billing Address',
      name: 'billingAddress',
      desc: '',
      args: [],
    );
  }

  /// `Are you Want to Return this order?`
  String get areYouWantToReturnThisOrder {
    return Intl.message(
      'Are you Want to Return this order?',
      name: 'areYouWantToReturnThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `Are you Want to Delivery this order?`
  String get areYouWantToDeliveryThisOrder {
    return Intl.message(
      'Are you Want to Delivery this order?',
      name: 'areYouWantToDeliveryThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `Delivering...`
  String get delivering {
    return Intl.message(
      'Delivering...',
      name: 'delivering',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get delivered {
    return Intl.message(
      'Delivered',
      name: 'delivered',
      desc: '',
      args: [],
    );
  }

  /// `Return`
  String get returnProduct {
    return Intl.message(
      'Return',
      name: 'returnProduct',
      desc: '',
      args: [],
    );
  }

  /// `Enter pickup location`
  String get enterPickupLocation {
    return Intl.message(
      'Enter pickup location',
      name: 'enterPickupLocation',
      desc: '',
      args: [],
    );
  }

  /// `Earnings`
  String get earnings {
    return Intl.message(
      'Earnings',
      name: 'earnings',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to accept this order?`
  String get areYouSureToAcceptThisOrder {
    return Intl.message(
      'Are you sure to accept this order?',
      name: 'areYouSureToAcceptThisOrder',
      desc: '',
      args: [],
    );
  }

  /// `Accept Order`
  String get acceptOrder {
    return Intl.message(
      'Accept Order',
      name: 'acceptOrder',
      desc: '',
      args: [],
    );
  }

  /// `Order Amount`
  String get orderAmount {
    return Intl.message(
      'Order Amount',
      name: 'orderAmount',
      desc: '',
      args: [],
    );
  }

  /// `Point`
  String get point {
    return Intl.message(
      'Point',
      name: 'point',
      desc: '',
      args: [],
    );
  }

  /// `Order`
  String get order {
    return Intl.message(
      'Order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `Enter Fast Name`
  String get enterFastName {
    return Intl.message(
      'Enter Fast Name',
      name: 'enterFastName',
      desc: '',
      args: [],
    );
  }

  /// `Enter Email`
  String get enterEmail {
    return Intl.message(
      'Enter Email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Full Address`
  String get fullAddress {
    return Intl.message(
      'Full Address',
      name: 'fullAddress',
      desc: '',
      args: [],
    );
  }

  /// `No Reward`
  String get noReward {
    return Intl.message(
      'No Reward',
      name: 'noReward',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `You don\'t have any point`
  String get youDontHaveAnyPoint {
    return Intl.message(
      'You don\\\'t have any point',
      name: 'youDontHaveAnyPoint',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to get this reward?`
  String get doYouWantToGetThisReward {
    return Intl.message(
      'Do you want to get this reward?',
      name: 'doYouWantToGetThisReward',
      desc: '',
      args: [],
    );
  }

  /// `For use point click yes!`
  String get forUsePointClickYes {
    return Intl.message(
      'For use point click yes!',
      name: 'forUsePointClickYes',
      desc: '',
      args: [],
    );
  }

  /// `Yes`
  String get yes {
    return Intl.message(
      'Yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `My Point`
  String get myPoint {
    return Intl.message(
      'My Point',
      name: 'myPoint',
      desc: '',
      args: [],
    );
  }

  /// `100 Points`
  String get points {
    return Intl.message(
      '100 Points',
      name: 'points',
      desc: '',
      args: [],
    );
  }

  /// `Your need to more points to unlocked this reward level!`
  String get yourNeedToMorePointsToUnlockedThisRewardLevel {
    return Intl.message(
      'Your need to more points to unlocked this reward level!',
      name: 'yourNeedToMorePointsToUnlockedThisRewardLevel',
      desc: '',
      args: [],
    );
  }

  /// `You are not able to collect points`
  String get youAreNotAbleToCollectPoints {
    return Intl.message(
      'You are not able to collect points',
      name: 'youAreNotAbleToCollectPoints',
      desc: '',
      args: [],
    );
  }

  /// `Get`
  String get get {
    return Intl.message(
      'Get',
      name: 'get',
      desc: '',
      args: [],
    );
  }

  /// `Your points`
  String get yourPoints {
    return Intl.message(
      'Your points',
      name: 'yourPoints',
      desc: '',
      args: [],
    );
  }

  /// `Your Points Reward`
  String get yourPointsReward {
    return Intl.message(
      'Your Points Reward',
      name: 'yourPointsReward',
      desc: '',
      args: [],
    );
  }

  /// `Redeem Points`
  String get redeemPoints {
    return Intl.message(
      'Redeem Points',
      name: 'redeemPoints',
      desc: '',
      args: [],
    );
  }

  /// `Search by name`
  String get searchByName {
    return Intl.message(
      'Search by name',
      name: 'searchByName',
      desc: '',
      args: [],
    );
  }

  /// `Total Referred`
  String get totalReferred {
    return Intl.message(
      'Total Referred',
      name: 'totalReferred',
      desc: '',
      args: [],
    );
  }

  /// `Total Earn`
  String get totalEarn {
    return Intl.message(
      'Total Earn',
      name: 'totalEarn',
      desc: '',
      args: [],
    );
  }

  /// `Your unique referral link`
  String get yourUniqueReferralLink {
    return Intl.message(
      'Your unique referral link',
      name: 'yourUniqueReferralLink',
      desc: '',
      args: [],
    );
  }

  /// `Currency`
  String get currency {
    return Intl.message(
      'Currency',
      name: 'currency',
      desc: '',
      args: [],
    );
  }

  /// `Push Notification`
  String get pushNotification {
    return Intl.message(
      'Push Notification',
      name: 'pushNotification',
      desc: '',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light Theme`
  String get lightTheme {
    return Intl.message(
      'Light Theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Toggle between Light and Dark themes`
  String get toggleBetweenThemes {
    return Intl.message(
      'Toggle between Light and Dark themes',
      name: 'toggleBetweenThemes',
      desc: '',
      args: [],
    );
  }

  /// `Earning Statement`
  String get earningStatement {
    return Intl.message(
      'Earning Statement',
      name: 'earningStatement',
      desc: '',
      args: [],
    );
  }

  /// `Message your problem.`
  String get messageYourProblem {
    return Intl.message(
      'Message your problem.',
      name: 'messageYourProblem',
      desc: '',
      args: [],
    );
  }

  /// `Frequent Question`
  String get frequentQuestion {
    return Intl.message(
      'Frequent Question',
      name: 'frequentQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Enter Subject`
  String get enterSubject {
    return Intl.message(
      'Enter Subject',
      name: 'enterSubject',
      desc: '',
      args: [],
    );
  }

  /// `Ticket Closed`
  String get ticketClosed {
    return Intl.message(
      'Ticket Closed',
      name: 'ticketClosed',
      desc: '',
      args: [],
    );
  }

  /// `Tickets`
  String get tickets {
    return Intl.message(
      'Tickets',
      name: 'tickets',
      desc: '',
      args: [],
    );
  }

  /// `Search by ticket number`
  String get searchByTicketNumber {
    return Intl.message(
      'Search by ticket number',
      name: 'searchByTicketNumber',
      desc: '',
      args: [],
    );
  }

  /// `No Tickets Found`
  String get noTicketsFound {
    return Intl.message(
      'No Tickets Found',
      name: 'noTicketsFound',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report {
    return Intl.message(
      'Report',
      name: 'report',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw`
  String get withdraw {
    return Intl.message(
      'Withdraw',
      name: 'withdraw',
      desc: '',
      args: [],
    );
  }

  /// `Reword`
  String get reword {
    return Intl.message(
      'Reword',
      name: 'reword',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Balance`
  String get walletBalance {
    return Intl.message(
      'Wallet Balance',
      name: 'walletBalance',
      desc: '',
      args: [],
    );
  }

  /// `Rejected Withdraw`
  String get rejectedWithdraw {
    return Intl.message(
      'Rejected Withdraw',
      name: 'rejectedWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `Transaction History `
  String get transactionHistory {
    return Intl.message(
      'Transaction History ',
      name: 'transactionHistory',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw List`
  String get withdrawList {
    return Intl.message(
      'Withdraw List',
      name: 'withdrawList',
      desc: '',
      args: [],
    );
  }

  /// `Search by trx`
  String get searchByTrx {
    return Intl.message(
      'Search by trx',
      name: 'searchByTrx',
      desc: '',
      args: [],
    );
  }

  /// `Transaction ID`
  String get transactionId {
    return Intl.message(
      'Transaction ID',
      name: 'transactionId',
      desc: '',
      args: [],
    );
  }

  /// `Receivable`
  String get receivable {
    return Intl.message(
      'Receivable',
      name: 'receivable',
      desc: '',
      args: [],
    );
  }

  /// `Method:`
  String get method {
    return Intl.message(
      'Method:',
      name: 'method',
      desc: '',
      args: [],
    );
  }

  /// `Amount:`
  String get amount {
    return Intl.message(
      'Amount:',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Charge:`
  String get charge {
    return Intl.message(
      'Charge:',
      name: 'charge',
      desc: '',
      args: [],
    );
  }

  /// `Note:`
  String get note {
    return Intl.message(
      'Note:',
      name: 'note',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search {
    return Intl.message(
      'Search...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Post Point: `
  String get postPoint {
    return Intl.message(
      'Post Point: ',
      name: 'postPoint',
      desc: '',
      args: [],
    );
  }

  /// `Details: `
  String get details {
    return Intl.message(
      'Details: ',
      name: 'details',
      desc: '',
      args: [],
    );
  }

  /// `Filter by date...`
  String get filterByDate {
    return Intl.message(
      'Filter by date...',
      name: 'filterByDate',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Method`
  String get withdrawMethod {
    return Intl.message(
      'Withdraw Method',
      name: 'withdrawMethod',
      desc: '',
      args: [],
    );
  }

  /// `Post Balance: `
  String get postBalance {
    return Intl.message(
      'Post Balance: ',
      name: 'postBalance',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Request`
  String get withdrawRequest {
    return Intl.message(
      'Withdraw Request',
      name: 'withdrawRequest',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong while requesting withdraw`
  String get somethinWrongWithdraw {
    return Intl.message(
      'Something went wrong while requesting withdraw',
      name: 'somethinWrongWithdraw',
      desc: '',
      args: [],
    );
  }

  /// `WITHDRAW PREVIEW`
  String get withdrawPreview {
    return Intl.message(
      'WITHDRAW PREVIEW',
      name: 'withdrawPreview',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Amount`
  String get withdrawAmount {
    return Intl.message(
      'Withdraw Amount',
      name: 'withdrawAmount',
      desc: '',
      args: [],
    );
  }

  /// `Conversion rate`
  String get conversionRate {
    return Intl.message(
      'Conversion rate',
      name: 'conversionRate',
      desc: '',
      args: [],
    );
  }

  /// `Final Amount`
  String get finalAmount {
    return Intl.message(
      'Final Amount',
      name: 'finalAmount',
      desc: '',
      args: [],
    );
  }

  /// `Edit Info`
  String get editInfo {
    return Intl.message(
      'Edit Info',
      name: 'editInfo',
      desc: '',
      args: [],
    );
  }

  /// `Cardholder Name`
  String get cardholderName {
    return Intl.message(
      'Cardholder Name',
      name: 'cardholderName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name as written on card`
  String get enterYourNameAsWrittenOnCard {
    return Intl.message(
      'Enter your name as written on card',
      name: 'enterYourNameAsWrittenOnCard',
      desc: '',
      args: [],
    );
  }

  /// `Card Number`
  String get cardNumber {
    return Intl.message(
      'Card Number',
      name: 'cardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter card number`
  String get enterCardNumber {
    return Intl.message(
      'Enter card number',
      name: 'enterCardNumber',
      desc: '',
      args: [],
    );
  }

  /// `Expiry Date`
  String get expiryDate {
    return Intl.message(
      'Expiry Date',
      name: 'expiryDate',
      desc: '',
      args: [],
    );
  }

  /// `CVV/CVC`
  String get cvvcvc {
    return Intl.message(
      'CVV/CVC',
      name: 'cvvcvc',
      desc: '',
      args: [],
    );
  }

  /// `Bank Info`
  String get bankInfo {
    return Intl.message(
      'Bank Info',
      name: 'bankInfo',
      desc: '',
      args: [],
    );
  }

  /// `Standard Bank`
  String get standardBank {
    return Intl.message(
      'Standard Bank',
      name: 'standardBank',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw Success!`
  String get withdrawSuccess {
    return Intl.message(
      'Withdraw Success!',
      name: 'withdrawSuccess',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully withdrawn your balance.`
  String get youHaveSuccessfullyWithdrawnYourBalance {
    return Intl.message(
      'You have successfully withdrawn your balance.',
      name: 'youHaveSuccessfullyWithdrawnYourBalance',
      desc: '',
      args: [],
    );
  }

  /// `You have successfully withdrawn your balance.`
  String get youHaveSuccessfully {
    return Intl.message(
      'You have successfully withdrawn your balance.',
      name: 'youHaveSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Back to home`
  String get backToHome {
    return Intl.message(
      'Back to home',
      name: 'backToHome',
      desc: '',
      args: [],
    );
  }

  /// `Please select a method`
  String get pleaseSelectAMethod {
    return Intl.message(
      'Please select a method',
      name: 'pleaseSelectAMethod',
      desc: '',
      args: [],
    );
  }

  /// `Balance`
  String get balance {
    return Intl.message(
      'Balance',
      name: 'balance',
      desc: '',
      args: [],
    );
  }

  /// `Enter Amount`
  String get enterAmount {
    return Intl.message(
      'Enter Amount',
      name: 'enterAmount',
      desc: '',
      args: [],
    );
  }

  /// `Withdraw to`
  String get withdrawTo {
    return Intl.message(
      'Withdraw to',
      name: 'withdrawTo',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message(
      'Select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message(
      'Change',
      name: 'change',
      desc: '',
      args: [],
    );
  }

  /// `Range`
  String get range {
    return Intl.message(
      'Range',
      name: 'range',
      desc: '',
      args: [],
    );
  }

  /// `Duration: `
  String get duration {
    return Intl.message(
      'Duration: ',
      name: 'duration',
      desc: '',
      args: [],
    );
  }

  /// `Wallet`
  String get wallet {
    return Intl.message(
      'Wallet',
      name: 'wallet',
      desc: '',
      args: [],
    );
  }

  /// `Currency Switcher`
  String get currencySwitcher {
    return Intl.message(
      'Currency Switcher',
      name: 'currencySwitcher',
      desc: '',
      args: [],
    );
  }

  /// `Search by name or email`
  String get searchByNameOrEmail {
    return Intl.message(
      'Search by name or email',
      name: 'searchByNameOrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Delivery:`
  String get delivery {
    return Intl.message(
      'Delivery:',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `Pending:`
  String get pending {
    return Intl.message(
      'Pending:',
      name: 'pending',
      desc: '',
      args: [],
    );
  }

  /// `Collect`
  String get collect {
    return Intl.message(
      'Collect',
      name: 'collect',
      desc: '',
      args: [],
    );
  }

  /// `more points to get next level`
  String get morePointsToGetNextLevel {
    return Intl.message(
      'more points to get next level',
      name: 'morePointsToGetNextLevel',
      desc: '',
      args: [],
    );
  }

  /// `Delivery man not found`
  String get deliveryManNotFound {
    return Intl.message(
      'Delivery man not found',
      name: 'deliveryManNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Username:`
  String get username {
    return Intl.message(
      'Username:',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Order Balance:`
  String get orderBalance {
    return Intl.message(
      'Order Balance:',
      name: 'orderBalance',
      desc: '',
      args: [],
    );
  }

  /// `Referral By:`
  String get referralBy {
    return Intl.message(
      'Referral By:',
      name: 'referralBy',
      desc: '',
      args: [],
    );
  }

  /// `You will get:`
  String get youWillGet {
    return Intl.message(
      'You will get:',
      name: 'youWillGet',
      desc: '',
      args: [],
    );
  }

  /// `by redeeming`
  String get byRedeeming {
    return Intl.message(
      'by redeeming',
      name: 'byRedeeming',
      desc: '',
      args: [],
    );
  }

  /// `Total Delivery`
  String get totalDelivery {
    return Intl.message(
      'Total Delivery',
      name: 'totalDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Total Order`
  String get totalOrder {
    return Intl.message(
      'Total Order',
      name: 'totalOrder',
      desc: '',
      args: [],
    );
  }

  /// `Pending Order`
  String get pendingOrder {
    return Intl.message(
      'Pending Order',
      name: 'pendingOrder',
      desc: '',
      args: [],
    );
  }

  /// `Processing Order`
  String get processingOrder {
    return Intl.message(
      'Processing Order',
      name: 'processingOrder',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed Order`
  String get confirmedOrder {
    return Intl.message(
      'Confirmed Order',
      name: 'confirmedOrder',
      desc: '',
      args: [],
    );
  }

  /// `Shipped Order`
  String get shippedOrder {
    return Intl.message(
      'Shipped Order',
      name: 'shippedOrder',
      desc: '',
      args: [],
    );
  }

  /// `Cancel Order`
  String get cancelOrder {
    return Intl.message(
      'Cancel Order',
      name: 'cancelOrder',
      desc: '',
      args: [],
    );
  }

  /// `The page you are looking for could not be found.`
  String get NotFound {
    return Intl.message(
      'The page you are looking for could not be found.',
      name: 'NotFound',
      desc: '',
      args: [],
    );
  }

  /// `Go Home`
  String get goHome {
    return Intl.message(
      'Go Home',
      name: 'goHome',
      desc: '',
      args: [],
    );
  }

  /// `Server Maintenance`
  String get serverMaintenance {
    return Intl.message(
      'Server Maintenance',
      name: 'serverMaintenance',
      desc: '',
      args: [],
    );
  }

  /// `The server is currently under maintenance. Please try again later.`
  String get theServerIsCurrentlyUnderMaintenancePleaseTryAgainLater {
    return Intl.message(
      'The server is currently under maintenance. Please try again later.',
      name: 'theServerIsCurrentlyUnderMaintenancePleaseTryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `The server is currently under maintenance. Please try again later.`
  String get tryAgainLater {
    return Intl.message(
      'The server is currently under maintenance. Please try again later.',
      name: 'tryAgainLater',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Exit`
  String get exit {
    return Intl.message(
      'Exit',
      name: 'exit',
      desc: '',
      args: [],
    );
  }

  /// `Deliveryman Module Off`
  String get deliverymanModuleOff {
    return Intl.message(
      'Deliveryman Module Off',
      name: 'deliverymanModuleOff',
      desc: '',
      args: [],
    );
  }

  /// `Deliveryman Module is currently Off. Please try again later`
  String get msgDeliverymanModuleIs {
    return Intl.message(
      'Deliveryman Module is currently Off. Please try again later',
      name: 'msgDeliverymanModuleIs',
      desc: '',
      args: [],
    );
  }

  /// `Deliveryman Is Currently Inactive`
  String get deliverymanIsCurrentlyInactive {
    return Intl.message(
      'Deliveryman Is Currently Inactive',
      name: 'deliverymanIsCurrentlyInactive',
      desc: '',
      args: [],
    );
  }

  /// `Please contact your admin`
  String get pleaseContactYourAdmin {
    return Intl.message(
      'Please contact your admin',
      name: 'pleaseContactYourAdmin',
      desc: '',
      args: [],
    );
  }

  /// `Cart User Delivery`
  String get cartUserDelivery {
    return Intl.message(
      'Cart User Delivery',
      name: 'cartUserDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Your software is not installed yet`
  String get yourSoftwareIsNotInstalledYet {
    return Intl.message(
      'Your software is not installed yet',
      name: 'yourSoftwareIsNotInstalledYet',
      desc: '',
      args: [],
    );
  }

  /// `Search by trx id...`
  String get searchByTrxId {
    return Intl.message(
      'Search by trx id...',
      name: 'searchByTrxId',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<TR> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'az'),
      Locale.fromSubtags(languageCode: 'bn'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'hi'),
      Locale.fromSubtags(languageCode: 'id'),
      Locale.fromSubtags(languageCode: 'ja'),
      Locale.fromSubtags(languageCode: 'ur'),
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<TR> load(Locale locale) => TR.load(locale);
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
