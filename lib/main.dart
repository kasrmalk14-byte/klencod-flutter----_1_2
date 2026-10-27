
import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(const KaserApp());
}

const Color gold = Color(0xFFFFC928);
const Color darkGold = Color(0xFF9B5700);
const Color background = Color(0xFF050608);

class KaserApp extends StatelessWidget {
  const KaserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'الكاسر APP',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
        ),
      ),
      home: const KaserHome(),
    );
  }
}

class KaserHome extends StatefulWidget {
  const KaserHome({super.key});

  @override
  State<KaserHome> createState() => _KaserHomeState();
}

class _KaserHomeState extends State<KaserHome>
    with TickerProviderStateMixin {
  late AnimationController _glow;
  late AnimationController _flames;
  late AnimationController _fade;

  int selected = 0;

  @override
  void initState() {
    super.initState();

    _glow = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    _flames = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _fade = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glow.dispose();
    _flames.dispose();
    _fade.dispose();
    super.dispose();
  }

  void openFeature(String name) {
    if (name == 'وضع الشبح') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const GhostScreen(),
        ),
      );
      return;
    }

    if (name == 'المحادثات') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const ChatsScreen(),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$name — الواجهة جاهزة للتطوير والربط بالخدمات',
          textDirection: TextDirection.rtl,
        ),
        backgroundColor: const Color(0xFF252016),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.65),
                    radius: 1.1,
                    colors: [
                      Color(0xFF33200A),
                      Color(0xFF11100D),
                      background,
                    ],
                  ),
                ),
              ),
            ),

            Positioned.fill(
              child: AnimatedBuilder(
                animation: _flames,
                builder: (context, child) {
                  return CustomPaint(
                    painter: EmberPainter(_flames.value),
                  );
                },
              ),
            ),

            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: gold.withValues(alpha: 0.65),
                            ),
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF3B2508),
                                Color(0xFF0C0B08),
                              ],
                            ),
                          ),
                          child: const Icon(
                            Icons.bolt,
                            color: gold,
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'الكاسر APP',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w900,
                                  color: gold,
                                ),
                              ),
                              Text(
                                'التواصل العالمي',
                                style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => openFeature('الإشعارات'),
                          icon: const Icon(
                            Icons.notifications_none_rounded,
                            color: gold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => openFeature('الإعدادات'),
                          icon: const Icon(
                            Icons.settings_outlined,
                            color: gold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(
                        20, 8, 20, 20,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 18),

                          AnimatedBuilder(
                            animation: Listenable.merge([
                              _glow,
                              _fade,
                            ]),
                            builder: (context, child) {
                              final pulse = 0.65 +
                                  (_glow.value * 0.35);

                              return Opacity(
                                opacity: 0.62 +
                                    (_fade.value * 0.38),
                                child: Transform.scale(
                                  scale: 0.985 +
                                      (_glow.value * 0.025),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 28,
                                      horizontal: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(28),
                                      border: Border.all(
                                        color: gold.withValues(
                                          alpha: 0.22,
                                        ),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: gold.withValues(
                                            alpha: 0.12 * pulse,
                                          ),
                                          blurRadius: 38,
                                          spreadRadius: 2,
                                        ),
                                      ],
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF201608),
                                          Color(0xFF0A0907),
                                          Color(0xFF08090C),
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        const Text(
                                          '🔥  ✦  🔥',
                                          style: TextStyle(
                                            fontSize: 22,
                                          ),
                                        ),
                                        const SizedBox(height: 12),

                                        ShaderMask(
                                          shaderCallback: (bounds) {
                                            return const LinearGradient(
                                              colors: [
                                                Color(0xFFFFF4BA),
                                                Color(0xFFFFD54A),
                                                Color(0xFFFF8C00),
                                                Color(0xFFFFE99A),
                                              ],
                                              stops: [
                                                0.0, 0.35, 0.7, 1.0,
                                              ],
                                            ).createShader(bounds);
                                          },
                                          child: Text(
                                            'الكاسر',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 58,
                                              fontWeight:
                                                  FontWeight.w900,
                                              height: 1.2,
                                              letterSpacing: 2,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  color: gold.withValues(
                                                    alpha: 0.8,
                                                  ),
                                                  blurRadius: 28,
                                                ),
                                                const Shadow(
                                                  color: Colors.orange,
                                                  blurRadius: 48,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 4),

                                        const Text(
                                          'A P P',
                                          style: TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: 9,
                                            color: gold,
                                          ),
                                        ),

                                        const SizedBox(height: 15),

                                        Container(
                                          width: 145,
                                          height: 1.5,
                                          decoration: const BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                gold,
                                                Colors.transparent,
                                              ],
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 15),

                                        const Text(
                                          'للتواصل العالمي',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 23,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),

                                        const SizedBox(height: 8),

                                        const Text(
                                          'عالمك الخاص .. تواصل بلا حدود',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFD6B977),
                                            fontSize: 13,
                                          ),
                                        ),

                                        const SizedBox(height: 17),

                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.shield_outlined,
                                              color: gold,
                                              size: 17,
                                            ),
                                            SizedBox(width: 6),
                                            Text(
                                              'خصوصيتك أولاً',
                                              style: TextStyle(
                                                color: gold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 25),

                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'عالمك بين يديك',
                                  style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF16271A),
                                  borderRadius:
                                      BorderRadius.circular(30),
                                  border: Border.all(
                                    color: Colors.green.shade800,
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 8,
                                      color: Colors.greenAccent,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'الكاسر',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 15),

                          GridView.count(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            physics:
                                const NeverScrollableScrollPhysics(),
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1.28,
                            children: [
                              featureCard(
                                Icons.chat_bubble_outline_rounded,
                                'المحادثات',
                                'رسائلك ومحادثاتك',
                                gold,
                              ),
                              featureCard(
                                Icons.call_outlined,
                                'المكالمات',
                                'تواصل صوتي ومرئي',
                                Colors.lightBlueAccent,
                              ),
                              featureCard(
                                Icons.people_alt_outlined,
                                'جهات الاتصال',
                                'الأشخاص المفضلون',
                                Colors.orangeAccent,
                              ),
                              featureCard(
                                Icons.visibility_off_outlined,
                                'وضع الشبح',
                                'تحكم بمن يستطيع مراسلتك',
                                Colors.purpleAccent,
                              ),
                              featureCard(
                                Icons.groups_2_outlined,
                                'المجموعات',
                                'تواصل مع الجميع',
                                Colors.cyanAccent,
                              ),
                              featureCard(
                                Icons.lock_outline_rounded,
                                'الخصوصية',
                                'تحكم بإعداداتك',
                                Colors.greenAccent,
                              ),
                            ],
                          ),

                          const SizedBox(height: 24),

                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(17),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: gold.withValues(alpha: 0.35),
                              ),
                              color: const Color(0xFF11100D),
                            ),
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.bolt,
                                  color: gold,
                                  size: 32,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'قوة التواصل في عالم واحد',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'صمّم تجربتك. تحكّم بخصوصيتك.',
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF0B0B0D),
                      border: Border(
                        top: BorderSide(
                          color: Color(0xFF35260E),
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.only(
                      top: 8, bottom: 8,
                    ),
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                      children: [
                        navItem(Icons.home_rounded, 'الرئيسية', 0),
                        navItem(Icons.chat_outlined, 'الدردشة', 1),
                        navItem(Icons.people_outline, 'الأصدقاء', 2),
                        navItem(Icons.person_outline, 'حسابي', 3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget featureCard(
    IconData icon,
    String title,
    String subtitle,
    Color color,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => openFeature(title),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF111216),
          border: Border.all(
            color: color.withValues(alpha: 0.32),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.04),
              blurRadius: 15,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 31, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              subtitle,
              maxLines: 2,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget navItem(IconData icon, String label, int index) {
    final active = selected == index;

    return InkWell(
      onTap: () {
        setState(() => selected = index);

        if (index != 0) {
          openFeature(label);
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 9, vertical: 5,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: active ? gold : Colors.white38,
              size: 23,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: active ? gold : Colors.white38,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EmberPainter extends CustomPainter {
  final double animation;

  EmberPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(17);

    for (int i = 0; i < 48; i++) {
      final x = random.nextDouble() * size.width;
      final baseY = random.nextDouble() * size.height;
      final drift = math.sin(
        animation * math.pi * 2 + i,
      ) * 15;
      final y = (baseY - animation * 24 * (i % 3 + 1))
          .remainder(size.height);

      final paint = Paint()
        ..color = (i % 3 == 0
            ? Colors.orange
            : gold).withValues(
          alpha: 0.12 + (0.2 * animation),
        );

      canvas.drawCircle(
        Offset(x + drift, y.abs()),
        1 + random.nextDouble() * 2,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant EmberPainter oldDelegate) {
    return oldDelegate.animation != animation;
  }
}

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('محادثات الكاسر'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'مرحباً بك في محادثات الكاسر\n\n'
            'هذه واجهة أولية. لإرسال الرسائل فعلياً '
            'يجب ربط التطبيق بخادم مراسلة.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              height: 2,
            ),
          ),
        ),
      ),
    );
  }
}

class GhostScreen extends StatefulWidget {
  const GhostScreen({super.key});

  @override
  State<GhostScreen> createState() => _GhostScreenState();
}

class _GhostScreenState extends State<GhostScreen> {
  bool ghostMode = false;
  bool allowContacts = true;
  bool hideOnline = true;
  bool muteOthers = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('وضع الشبح'),
          foregroundColor: gold,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Icon(
              Icons.visibility_off_rounded,
              size: 70,
              color: gold,
            ),
            const SizedBox(height: 16),
            const Text(
              'أنت من يختار من يصل إليك',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'واجهة إعدادات الخصوصية. تطبيق القواعد فعلياً '
              'على الرسائل يحتاج إلى خادم مراسلة.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white60,
                height: 1.7,
              ),
            ),
            const SizedBox(height: 25),
            SwitchListTile(
              value: ghostMode,
              activeThumbColor: gold,
              title: const Text('تفعيل وضع الشبح'),
              subtitle: const Text(
                'تشغيل إعدادات الخصوصية',
              ),
              onChanged: (value) {
                setState(() => ghostMode = value);
              },
            ),
            const Divider(color: Colors.white12),
            SwitchListTile(
              value: allowContacts,
              activeThumbColor: gold,
              title: const Text('السماح لجهات الاتصال'),
              onChanged: (value) {
                setState(() => allowContacts = value);
              },
            ),
            SwitchListTile(
              value: hideOnline,
              activeThumbColor: gold,
              title: const Text('إخفاء حالة الاتصال'),
              onChanged: (value) {
                setState(() => hideOnline = value);
              },
            ),
            SwitchListTile(
              value: muteOthers,
              activeThumbColor: gold,
              title: const Text('كتم إشعارات الآخرين'),
              onChanged: (value) {
                setState(() => muteOthers = value);
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'ملاحظة: هذه الخيارات تحفظ حالتها داخل الشاشة فقط '
              'في هذه النسخة، ولا تمنع الرسائل على خادم فعلي.',
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 12,
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
