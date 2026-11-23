import 'package:material_ui/material_ui.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grab UI Homework',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final ScrollController _homeScrollController = ScrollController();
  bool _showHeader = true;
  bool _showFooter = true;
  @override
  void initState() {
    super.initState();
    _homeScrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (!_homeScrollController.hasClients) return;
    if (_selectedIndex != 0) return;
    final direction = _homeScrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      if (_showHeader || !_showFooter) {
        setState(() {
          _showHeader = false;
          _showFooter = true;
        });
      }
    } else if (direction == ScrollDirection.forward) {
      if (!_showHeader || _showFooter) {
        setState(() {
          _showHeader = true;
          _showFooter = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _homeScrollController.dispose();
    super.dispose();
  }

  // final List<String> _tabTitles = const [
  //   'Home',
  //   'Moments',
  //   'Payment',
  //   'Activity',
  //   'Messages',
  // ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _selectedIndex == 0
          ? Column(
              children: [
                Visibility(
                  visible: _showHeader,
                  maintainState: true,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFF006B4F), Color(0xFF003D34)],
                      ),
                    ),
                    child: SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.qr_code_scanner,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 52,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: const TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Search places',
                                    prefixIcon: Icon(Icons.search, size: 27),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xFFFFC400),
                              child: Text(
                                'G',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.white,
                              backgroundImage: const AssetImage(
                                'assets/images/my_image.png',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ), // Green header Container
                ), // Close Visibility
                Expanded(
                  child: SingleChildScrollView(
                    controller: _homeScrollController,
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        const ServiceMenu(),
                        const SizedBox(height: 10),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       width: 28,
                        //       height: 5,
                        //       decoration: BoxDecoration(
                        //         color: const Color(0xFF222222),
                        //         borderRadius: BorderRadius.circular(10),
                        //       ),
                        //     ),
                        //     const SizedBox(width: 5),
                        //     Container(
                        //       width: 5,
                        //       height: 5,
                        //       decoration: const BoxDecoration(
                        //         color: Color(0xFFC9C9C9),
                        //         shape: BoxShape.circle,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        const SizedBox(height: 24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: QuickActionCard(
                                  label: 'View',
                                  title: 'ACLEDA PAY',
                                  icon: Icons.account_balance_wallet_rounded,
                                  iconColor: const Color(0xFF007A8A),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: QuickActionCard(
                                  label: 'Schedule',
                                  title: 'Ride to airport',
                                  icon: Icons.calendar_month_rounded,
                                  iconColor: const Color(0xFF007A8A),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        const RequestNowSection(),
                        const SizedBox(height: 30),
                        const AdvertisementSection(),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : AppTabPage(tabIndex: _selectedIndex),
      bottomNavigationBar: (_selectedIndex == 0 && !_showFooter)
          ? null
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                  _showHeader = true;
                  _showFooter = true;
                });
              },
              selectedItemColor: const Color(0xFF00B14F),
              unselectedItemColor: Colors.grey,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedFontSize: 11,
              unselectedFontSize: 11,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  activeIcon: Icon(Icons.home_rounded),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.explore_outlined),
                      Positioned(
                        top: -2,
                        right: -3,
                        child: Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: 'Moments',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet_outlined),
                  activeIcon: Icon(Icons.account_balance_wallet),
                  label: 'Payment',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined),
                  activeIcon: Icon(Icons.receipt_long),
                  label: 'Activity',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(Icons.chat_bubble_outline),
                      Positioned(
                        top: -7,
                        right: -8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            '2',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  label: 'Messages',
                ),
              ],
            ),
    );
  }
}

class ServiceMenu extends StatefulWidget {
  const ServiceMenu({super.key});
  @override
  State<ServiceMenu> createState() => _ServiceMenuState();
}

class _ServiceMenuState extends State<ServiceMenu> {
  final ScrollController _scrollController = ScrollController();
  bool _isSecondPosition = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.maxScrollExtent <= 0) return;
    final isSecond = position.pixels >= position.maxScrollExtent / 2;
    if (isSecond != _isSecondPosition) {
      setState(() {
        _isSecondPosition = isSecond;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const topServices = [
      ['🍳', 'Food'],
      ['📦', 'Express'],
      ['🛒', 'Mart'],
      ['🟢', 'Nham24'],
      ['🚗', 'Car'],
      ['🏍️', 'Bike'],
    ];
    const bottomServices = [
      ['🛺', 'Transport'],
      ['🛍️', 'Mall'],
      ['📍', 'GoNow'],
      ['🚕', 'Ride later'],
      ['🛺', 'TukTuk'],
      ['🎁', 'Gifts'],
    ];
    return Column(
      children: [
        SizedBox(
          height: 215,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemCount: topServices.length,
            itemBuilder: (context, index) {
              return SizedBox(
                width: (MediaQuery.sizeOf(context).width - 20) / 5.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildServiceItem(
                      topServices[index][0],
                      topServices[index][1],
                    ),
                    buildServiceItem(
                      bottomServices[index][0],
                      bottomServices[index][1],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _isSecondPosition ? 5 : 28,
              height: 5,
              decoration: BoxDecoration(
                color: _isSecondPosition
                    ? const Color(0xFFC9C9C9)
                    : const Color(0xFF222222),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(width: 5),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: _isSecondPosition ? 28 : 5,
              height: 5,
              decoration: BoxDecoration(
                color: _isSecondPosition
                    ? const Color(0xFF222222)
                    : const Color(0xFFC9C9C9),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildServiceItem(String emoji, String name) {
    return SizedBox(
      height: 95,
      child: Column(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 43)),
          const SizedBox(height: 4),
          Text(
            name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class QuickActionCard extends StatelessWidget {
  final String label;
  final String title;
  final IconData icon;
  final Color iconColor;
  const QuickActionCard({
    super.key,
    required this.label,
    required this.title,
    required this.icon,
    required this.iconColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 5),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Icon(icon, color: iconColor, size: 25),
        ],
      ),
    );
  }
}

class RequestNowSection extends StatefulWidget {
  const RequestNowSection({super.key});
  @override
  State<RequestNowSection> createState() => _RequestNowSectionState();
}

class _RequestNowSectionState extends State<RequestNowSection> {
  final ScrollController _promoController = ScrollController();
  void _nextPromotion() {
    if (!_promoController.hasClients) return;
    _promoController.animateTo(
      _promoController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _previousPromotion() {
    if (!_promoController.hasClients) return;
    _promoController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double bannerWidth = MediaQuery.sizeOf(context).width * 0.82;
    return SizedBox(
      height: bannerWidth / 2 + 110,
      child: ListView(
        controller: _promoController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          SizedBox(
            width: bannerWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Request Now',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _nextPromotion,
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFFDADADA),
                        child: Icon(
                          Icons.chevron_right,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 2 / 1,
                    child: Image.asset(
                      'assets/images/grab_promo_locker.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Get a free GrabFood Locker at your building',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          SizedBox(
            width: bannerWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Order Now',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _previousPromotion,
                      child: const CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFFDADADA),
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: bannerWidth / 2,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF05A66A), Color(0xFFB6F5D3)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.local_offer_rounded,
                      size: 55,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Discover more offers and promotions',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AdvertisementSection extends StatelessWidget {
  const AdvertisementSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(
            child: AdvertisementCard(
              imagePath: 'assets/images/ad_seafood.png',
              title: 'Best Seafood in Town',
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: AdvertisementCard(
              imagePath: 'assets/images/ad_green_drink.png',
              title: 'Fresh Green Drink',
            ),
          ),
        ],
      ),
    );
  }
}

class AdvertisementCard extends StatelessWidget {
  final String imagePath;
  final String title;
  const AdvertisementCard({
    super.key,
    required this.imagePath,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('You selected $title')));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: AspectRatio(
                  aspectRatio: 266 / 233,
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              if (imagePath == 'assets/images/ad_seafood.png')
                Positioned(
                  top: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF444444),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Ad',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

class AppTabPage extends StatelessWidget {
  final int tabIndex;
  const AppTabPage({super.key, required this.tabIndex});
  @override
  Widget build(BuildContext context) {
    const titles = ['Home', 'Moments', 'Payment', 'Activity', 'Messages'];
    const descriptions = [
      'Home',
      'Explore and discover',
      'ACLEDA PAY - Demo',
      'Your activities',
      'Your inbox',
    ];
    const icons = [
      Icons.home_rounded,
      Icons.explore_outlined,
      Icons.account_balance_wallet_rounded,
      Icons.receipt_long_outlined,
      Icons.chat_bubble_outline,
    ];
    const features = [
      <String>[],
      ['Explore moments', 'Your moments', 'Saved moments'],
      ['Scan QR', 'Payment methods', 'Transaction history'],
      ['Recent activities', 'Saved trips', 'Upcoming schedules'],
      ['Customer support', 'Promotions', 'Ride updates'],
    ];
    final Color mainColor = tabIndex == 2
        ? const Color(0xFF173A73)
        : const Color(0xFF00B14F);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Icon(icons[tabIndex], size: 32, color: mainColor),
              const SizedBox(width: 12),
              Text(
                titles[tabIndex],
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            descriptions[tabIndex],
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          ),
          const SizedBox(height: 25),
          for (final feature in features[tabIndex])
            Card(
              color: Colors.white,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                contentPadding: const EdgeInsets.all(12),
                leading: Icon(icons[tabIndex], color: mainColor),
                title: Text(
                  feature,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$feature - Demo only'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
