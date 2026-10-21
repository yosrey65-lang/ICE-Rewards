import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const IceRewardsApp());

class IceRewardsApp extends StatefulWidget {
  const IceRewardsApp({super.key});

  @override
  State<IceRewardsApp> createState() => _IceRewardsAppState();
}

class _IceRewardsAppState extends State<IceRewardsApp> {
  Locale _locale = const Locale('en');

  void _setLocale(Locale locale) => setState(() => _locale = locale);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ICE Rewards',
      locale: _locale,
      supportedLocales: const [Locale('en'), Locale('ar')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF58C8F5),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF07111F),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF07111F),
          foregroundColor: Colors.white,
          centerTitle: false,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF10243A),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Color(0xFF1B3C58)),
          ),
        ),
      ),
      home: IceHomePage(locale: _locale, onLocaleChanged: _setLocale),
    );
  }
}

class IceHomePage extends StatefulWidget {
  const IceHomePage({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
  });

  final Locale locale;
  final ValueChanged<Locale> onLocaleChanged;

  @override
  State<IceHomePage> createState() => _IceHomePageState();
}

class _IceHomePageState extends State<IceHomePage> {
  int _selectedIndex = 0;

  bool get isArabic => widget.locale.languageCode == 'ar';

  String tr(String en, String ar) => isArabic ? ar : en;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _homeContent(),
      _offersContent(),
      _rewardsContent(),
      _accountContent(),
    ];

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Icon(Icons.ac_unit_rounded, color: Color(0xFF58C8F5)),
              const SizedBox(width: 9),
              const Text('ICE Rewards', style: TextStyle(fontWeight: FontWeight.w800)),
            ],
          ),
          actions: [
            PopupMenuButton<String>(
              tooltip: tr('Language', 'اللغة'),
              icon: const Icon(Icons.language_rounded),
              onSelected: (value) => widget.onLocaleChanged(Locale(value)),
              itemBuilder: (_) => const [
                PopupMenuItem(value: 'en', child: Text('English')),
                PopupMenuItem(value: 'ar', child: Text('العربية')),
              ],
            ),
            const SizedBox(width: 6),
          ],
        ),
        body: SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 220),
            child: SingleChildScrollView(
              key: ValueKey(_selectedIndex),
              padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
              child: pages[_selectedIndex],
            ),
          ),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) => setState(() => _selectedIndex = index),
          backgroundColor: const Color(0xFF0A1929),
          indicatorColor: const Color(0xFF174565),
          destinations: [
            NavigationDestination(icon: const Icon(Icons.home_rounded), label: tr('Home', 'الرئيسية')),
            NavigationDestination(icon: const Icon(Icons.sports_esports_rounded), label: tr('Offers', 'العروض')),
            NavigationDestination(icon: const Icon(Icons.card_giftcard_rounded), label: tr('Rewards', 'المكافآت')),
            NavigationDestination(icon: const Icon(Icons.person_rounded), label: tr('Account', 'حسابي')),
          ],
        ),
      ),
    );
  }

  Widget _homeContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr('Welcome to ICE Rewards', 'أهلاً بك في ICE Rewards'),
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
          const SizedBox(height: 7),
          Text(tr('Complete eligible offers and collect points.',
              'أكمل العروض المؤهلة واجمع النقاط.'),
              style: const TextStyle(color: Color(0xFF9FB5C9), fontSize: 14)),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: const LinearGradient(
                colors: [Color(0xFF164A70), Color(0xFF10243A), Color(0xFF0D1C2D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: const Color(0xFF2A6B91)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tr('CURRENT BALANCE', 'الرصيد الحالي'),
                    style: const TextStyle(letterSpacing: 1.4, color: Color(0xFFB8D8EA), fontSize: 12)),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Icon(Icons.ac_unit_rounded, size: 34, color: Color(0xFF58C8F5)),
                    const SizedBox(width: 10),
                    Text('0', style: const TextStyle(fontSize: 42, height: 1, fontWeight: FontWeight.w900)),
                    const SizedBox(width: 9),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(tr('points', 'نقطة'), style: const TextStyle(color: Color(0xFFB8D8EA))),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(tr('Demo balance — no real points have been credited.',
                    'رصيد تجريبي — لم تتم إضافة نقاط حقيقية.'),
                    style: const TextStyle(color: Color(0xFFB8D8EA), fontSize: 12)),
              ],
            ),
          ),
          const SizedBox(height: 22),
          Text(tr('Quick access', 'الوصول السريع'),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: _quickCard(Icons.sports_esports_rounded, tr('Earn Points', 'اجمع النقاط'), () => setState(() => _selectedIndex = 1))),
            const SizedBox(width: 12),
            Expanded(child: _quickCard(Icons.card_giftcard_rounded, tr('Rewards', 'المكافآت'), () => setState(() => _selectedIndex = 2))),
          ]),
          const SizedBox(height: 20),
          _noticeCard(
            tr('Offerwalls are not connected yet',
                'جدران العروض غير متصلة حتى الآن'),
            tr('Provider access will be enabled after official publisher setup and server-side verification.',
                'سيتم تفعيل المزوّدين بعد إعداد حسابات الناشرين والتحقق من المهام على الخادم.'),
            Icons.info_outline_rounded,
          ),
        ],
      );

  Widget _offersContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr('Earn Points', 'اجمع النقاط'),
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(tr('Choose a provider when integration is configured.',
              'اختر المزوّد بعد إعداد الربط.'),
              style: const TextStyle(color: Color(0xFF9FB5C9))),
          const SizedBox(height: 18),
          _providerCard('OGAds', tr('Offerwall integration pending', 'الربط قيد الإعداد'), Icons.bolt_rounded),
          _providerCard('AdGem', tr('Offerwall integration pending', 'الربط قيد الإعداد'), Icons.diamond_outlined),
          _providerCard('AdMaven', tr('Offerwall integration pending', 'الربط قيد الإعداد'), Icons.ads_click_rounded),
          const SizedBox(height: 10),
          _noticeCard(tr('Coming soon', 'قريبًا'),
              tr('These are placeholders. No provider offers are live in this build.',
                  'هذه عناصر تجريبية. لا توجد عروض فعلية في هذه النسخة.'),
              Icons.hourglass_top_rounded),
        ],
      );

  Widget _rewardsContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr('Rewards', 'المكافآت'), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
          const SizedBox(height: 14),
          _noticeCard(tr('Rewards are not available yet', 'المكافآت غير متاحة بعد'),
              tr('Redemption options and minimum thresholds will be added after the reward rules and payout provider are confirmed.',
                  'ستتم إضافة خيارات الاستبدال والحد الأدنى بعد تحديد قواعد المكافآت ومزوّد الدفع.'),
              Icons.card_giftcard_rounded),
        ],
      );

  Widget _accountContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tr('My Account', 'حسابي'), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800)),
          const SizedBox(height: 14),
          _noticeCard(tr('Guest preview', 'معاينة كضيف'),
              tr('Sign-in and secure account storage must be connected before public launch.',
                  'يجب إعداد تسجيل الدخول وحفظ بيانات الحساب بشكل آمن قبل الإطلاق العام.'),
              Icons.person_outline_rounded),
          const SizedBox(height: 12),
          Card(
            child: ListTile(
              leading: const Icon(Icons.language_rounded, color: Color(0xFF58C8F5)),
              title: Text(tr('App language', 'لغة التطبيق')),
              subtitle: Text(tr('English (default) / Arabic', 'الإنجليزية (أساسي) / العربية')),
              trailing: DropdownButton<String>(
                value: widget.locale.languageCode,
                underline: const SizedBox.shrink(),
                items: const [
                  DropdownMenuItem(value: 'en', child: Text('English')),
                  DropdownMenuItem(value: 'ar', child: Text('العربية')),
                ],
                onChanged: (value) {
                  if (value != null) widget.onLocaleChanged(Locale(value));
                },
              ),
            ),
          ),
        ],
      );

  Widget _quickCard(IconData icon, String label, VoidCallback onTap) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
            child: Column(
              children: [
                Icon(icon, size: 30, color: const Color(0xFF58C8F5)),
                const SizedBox(height: 10),
                Text(label, style: const TextStyle(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ),
      );

  Widget _providerCard(String name, String subtitle, IconData icon) => Card(
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: const Color(0xFF173B56),
            child: Icon(icon, color: const Color(0xFF58C8F5)),
          ),
          title: Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.lock_outline_rounded, color: Color(0xFF9FB5C9)),
        ),
      );

  Widget _noticeCard(String title, String body, IconData icon) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: const Color(0xFF58C8F5), size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Text(body, style: const TextStyle(color: Color(0xFF9FB5C9), height: 1.35)),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
