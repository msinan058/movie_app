import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const _localizedValues = {
    'en': {
      // Register Screen
      'welcome': 'Welcome',
      'fullName': 'Full Name',
      'email': 'Email',
      'password': 'Password',
      'confirmPassword': 'Confirm Password',
      'termsPrefix': 'I have read and accept the ',
      'termsAccept': 'terms of service.',
      'termsReadRequest': ' Please read this agreement to continue.',
      'registerNow': 'Register Now',
      'alreadyHaveAccount': 'Already have an account?',
      'login': 'Login!',

      // Login Screen
      'welcomeBack': 'Welcome Back',
      'forgotPassword': 'Forgot Password?',
      'dontHaveAccount': 'Don\'t have an account?',
      'register': 'Register!',
      'rememberMe': 'Remember Me',

      // Home Screen
      'movies': 'Movies',
      'series': 'TV Series',
      'popular': 'Popular',
      'topRated': 'Top Rated',
      'upcoming': 'Coming Soon',
      'nowPlaying': 'Now Playing',
      'seeAll': 'See All',
      'search': 'Search',
      'searchHint': 'Search for movies, series or artists...',

      // Profile Screen
      'profile': 'Profile',
      'editProfile': 'Edit Profile',
      'settings': 'Settings',
      'language': 'Language',
      'theme': 'Theme',
      'notifications': 'Notifications',
      'privacyPolicy': 'Privacy Policy',
      'termsOfService': 'Terms of Service',
      'logout': 'Logout',
      'deleteAccount': 'Delete Account',
      'myLists': 'My Lists',
      'watchlist': 'Watchlist',
      'favorites': 'Favorites',
      'watched': 'Watched',
      'noFavorites': 'You don\'t have any favorite movies yet.',
      'untitled': 'Untitled',

      // Add Profile Photo Screen
      'addProfilePhoto': 'Add Profile Photo',
      'skipForNow': 'Skip for Now',
      'takePhoto': 'Take Photo',
      'chooseFromGallery': 'Choose from Gallery',
      'photoGuide': 'For best results, choose a photo where your face is clearly visible',

      // Premium Offer Sheet
      'premiumOffer': 'Go Premium',
      'premiumFeatures': 'Get more with premium features!',
      'noAds': 'Watch\nAd-Free',
      'downloadContent': 'Download\nContent',
      'hdQuality': 'HD\nQuality',
      'multipleDevices': 'Multiple\nDevices',
      'monthlyPrice': 'Monthly',
      'yearlyPrice': 'Yearly',
      'subscribe': 'Subscribe',
      'pricePerMonth': 'month',
      'savePercent': 'Save %{percent}',
      'limitedOffer': 'Limited Offer',
      'bonusesYouWillGet': 'Bonuses You Will Get',
      'selectTokenPackage': 'Select a token package to unlock',
      'premiumAccount': 'Premium\nAccount',
      'moreMatches': 'More\nMatches',
      'promotion': 'Promotion',
      'moreLikes': 'More\nLikes',
      'token': 'Token',
      'perWeek': 'Per week',
      'seeAllTokens': 'See All Tokens',
      'earnBonusAndUnlock': 'Choose a token package to earn bonus and unlock new episodes!',

      // Shell Navigation
      'home': 'Home',
      'discover': 'Discover',
      'myList': 'My List',
      'downloads': 'Downloads',

      // Validation Messages
      'fullNameRequired': 'Full name is required',
      'emailRequired': 'Email is required',
      'invalidEmail': 'Please enter a valid email address',
      'passwordRequired': 'Password is required',
      'passwordMinLength': 'Password must be at least 6 characters',
      'confirmPasswordRequired': 'Please confirm your password',
      'passwordsDoNotMatch': 'Passwords do not match',

      // General
      'error': 'Error',
      'success': 'Success',
      'loading': 'Loading...',
      'retry': 'Retry',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'ok': 'OK',
      'continue': 'Continue',
      'logoutConfirmation': 'Logout Confirmation',
      'logoutConfirmationMessage': 'Are you sure you want to logout?',

      'photoUploadSuccess': 'Photo uploaded successfully!',
    },
    'tr': {
      // Register Screen
      'welcome': 'Hoşgeldiniz',
      'fullName': 'Ad Soyad',
      'email': 'E-Posta',
      'password': 'Şifre',
      'confirmPassword': 'Şifre Tekrar',
      'termsPrefix': 'Kullanıcı sözleşmesini ',
      'termsAccept': 'okudum ve kabul ediyorum.',
      'termsReadRequest': ' Bu sözleşmeyi okuyarak devam ediniz lütfen.',
      'registerNow': 'Şimdi Kaydol',
      'alreadyHaveAccount': 'Zaten bir hesabın var mı?',
      'login': 'Giriş Yap!',

      // Login Screen
      'welcomeBack': 'Tekrar Hoşgeldiniz',
      'forgotPassword': 'Şifreni mi unuttun?',
      'dontHaveAccount': 'Hesabın yok mu?',
      'register': 'Kayıt Ol!',
      'rememberMe': 'Beni Hatırla',

      // Home Screen
      'movies': 'Filmler',
      'series': 'Diziler',
      'popular': 'Popüler',
      'topRated': 'En İyi',
      'upcoming': 'Yakında',
      'nowPlaying': 'Vizyonda',
      'seeAll': 'Tümünü Gör',
      'search': 'Ara',
      'searchHint': 'Film, dizi veya sanatçı ara...',

      // Profile Screen
      'profile': 'Profil',
      'editProfile': 'Profili Düzenle',
      'settings': 'Ayarlar',
      'language': 'Dil',
      'theme': 'Tema',
      'notifications': 'Bildirimler',
      'privacyPolicy': 'Gizlilik Politikası',
      'termsOfService': 'Kullanım Koşulları',
      'logout': 'Çıkış Yap',
      'deleteAccount': 'Hesabı Sil',
      'myLists': 'Listelerim',
      'watchlist': 'İzleme Listesi',
      'favorites': 'Favoriler',
      'watched': 'İzlenenler',
      'noFavorites': 'Henüz favori filminiz bulunmuyor.',
      'untitled': 'İsimsiz',

      // Add Profile Photo Screen
      'addProfilePhoto': 'Profil Fotoğrafı Ekle',
      'skipForNow': 'Şimdilik Geç',
      'takePhoto': 'Fotoğraf Çek',
      'chooseFromGallery': 'Galeriden Seç',
      'photoGuide': 'En iyi sonuç için yüzünüzün net göründüğü bir fotoğraf seçin',

      // Premium Offer Sheet
      'premiumOffer': 'Premium\'a Geç',
      'premiumFeatures': 'Premium özellikleri ile daha fazlasına erişin!',
      'noAds': 'Reklamsız\nİzle',
      'downloadContent': 'İçerikleri\nİndir',
      'hdQuality': 'HD\nKalite',
      'multipleDevices': 'Çoklu\nCihaz',
      'monthlyPrice': 'Aylık',
      'yearlyPrice': 'Yıllık',
      'subscribe': 'Abone Ol',
      'pricePerMonth': 'ay',
      'savePercent': '%{percent} Tasarruf',
      'limitedOffer': 'Sınırlı Teklif',
      'bonusesYouWillGet': 'Alacağınız Bonuslar',
      'selectTokenPackage': 'Kilidi açmak için bir jeton paketi seçin',
      'premiumAccount': 'Premium\nHesap',
      'moreMatches': 'Daha\nFazla Eşleşme',
      'promotion': 'Öne\nÇıkarma',
      'moreLikes': 'Daha\nFazla Beğeni',
      'token': 'Jeton',
      'perWeek': 'Başına haftalık',
      'seeAllTokens': 'Tüm Jetonları Gör',
      'earnBonusAndUnlock': 'Jeton paketini seçerek bonus kazanın ve yeni bölümlerin kilidini açın!',

      // Shell Navigation
      'home': 'Ana Sayfa',
      'discover': 'Keşfet',
      'myList': 'Listem',
      'downloads': 'İndirilenler',

      // Validation Messages
      'fullNameRequired': 'Ad Soyad gerekli',
      'emailRequired': 'E-posta adresi gerekli',
      'invalidEmail': 'Geçerli bir e-posta adresi girin',
      'passwordRequired': 'Şifre gerekli',
      'passwordMinLength': 'Şifre en az 6 karakter olmalı',
      'confirmPasswordRequired': 'Şifre tekrarı gerekli',
      'passwordsDoNotMatch': 'Şifreler eşleşmiyor',

      // General
      'error': 'Hata',
      'success': 'Başarılı',
      'loading': 'Yükleniyor...',
      'retry': 'Tekrar Dene',
      'cancel': 'İptal',
      'save': 'Kaydet',
      'delete': 'Sil',
      'edit': 'Düzenle',
      'ok': 'Tamam',
      'continue': 'Devam Et',
      'logoutConfirmation': 'Çıkış Onayı',
      'logoutConfirmationMessage': 'Çıkış yapmak istediğinize emin misiniz?',

      'photoUploadSuccess': 'Fotoğraf başarıyla yüklendi!',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 