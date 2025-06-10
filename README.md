📌 Proje Hakkında Kısa Notlar

Merhaba 👋
Bu proje, tarafıma gönderilen Flutter işe alım case'ine ait. Tüm temel gereksinimler MVVM + BLoC yapısı kullanılarak yerine getirildi.

Navigasyon için GoRouter tercih ettim. Özellikle nested navigation ve deeplink desteği açısından ileride kolaylık sağlaması nedeniyle.

Tema yapısı tamamen özelleştirildi, dark/light mode desteği mevcut.

Lokalizasyon için flutter_localizations entegre edildi. Türkçe/İngilizce dilleri arasında uygulama çalışırken geçiş yapılabiliyor.

Firebase entegrasyonu tamamlandı. Kendi projemi bağladım; Crashlytics ve Analytics aktif. İstenirse Firebase projemi paylaşabilirim.

Lottie animasyonları, özellikle profil fotoğrafı yükleme sonrası görsel bir akış sağlamak amacıyla eklendi.

Login ve profil ekranlarına tema ve dil değiştirme özelliklerini koydum, böylece test eden kişi bu özellikleri kolayca görebilir.

Login ekranında "beni hatırla" seçeneği mevcut. Eğer token hâlâ geçerliyse, kullanıcı doğrudan ana sayfaya yönlendirilir.
Token geçersiz veya süresi dolmuşsa, kullanıcı login ekranına yönlendirilir. Token yönetimi için flutter_secure_storage kullanıldı.

Splash screen ve uygulama ikonu eklendi.

HTTP istekleri için Dio kullandım; interceptor ve logger ile tüm trafiği izleyebilir hale getirdim.

UI'daki ikonlar için boyut optimizasyonu açısından flutter_svg kullanıldı.

Görsellerde performans için cached_network_image tercih edildi. Caching sınırı 1000 resim ile sınırlanarak cihaz hafızası kontrol altında tutuldu.

Uygulamanın performanslı çalışması için mümkün olan her yerde const ve StatelessWidget tercih edildi.

ℹ️ Ek Notlar

Zaman zaman verilen API çalışmadığı için veriler mock data üzerinden sağlanmıştır. Şu andada API çalışmı fixlenirse daha rahat test edilebilir

Bonus özellikleri (tema, lokalizasyon, animasyon vs.) daha görünür kılmak için bazı küçük UI eklemeleri yaptım.

**⚠️ ÖNEMLİ NOT: ŞU AN MACBOOK'UM ARIZALI OLDUĞU İÇİN iOS TARAFINI TEST EDEMEDİM. BU SEBEPLE iOS BUILD'İ EKSİK. ANDROID TARAFINDA HER ŞEY STABİL ÇALIŞIYOR. FIREBASE'İN iOS AYARLARINI XCODE ERİŞİMİ OLMADIĞI İÇİN TAMAMLAYAMADIM.**
