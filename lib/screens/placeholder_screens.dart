import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/top_bar_widget.dart';
import '../controllers/home_controller.dart';
import '../core/routes/app_routes.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: const TopBarWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.m),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search Oriflame products...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: isDark ? Colors.white10 : Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: 0.8,
              ),
              itemCount: controller.posts.length * 4, // Just for visual demo
              itemBuilder: (context, index) {
                final postIndex = index % controller.posts.length;
                final post = controller.posts[postIndex];
                return GestureDetector(
                  onTap: () {
                    controller.scrollToPost(postIndex);
                    Get.toNamed(AppRoutes.home);
                  },
                  child: Image.network(
                    post.imageUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const TopBarWidget(),
      body: ListView(
        padding: const EdgeInsets.all(AppSizes.m),
        children: [
          _buildCategory(context, "Best Sellers", [
            'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&q=80&w=300',
            'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&q=80&w=300',
            'https://images.unsplash.com/photo-1594465919760-441fe5908ab0?auto=format&fit=crop&q=80&w=300',
          ]),
          const SizedBox(height: 24),
          _buildCategory(context, "New Arrivals", [
            'https://images.unsplash.com/photo-1512496015851-a90fb38ba796?auto=format&fit=crop&q=80&w=300',
            'https://images.unsplash.com/photo-1556227702-d1e4e7b5c232?auto=format&fit=crop&q=80&w=300',
            'https://images.unsplash.com/photo-1541643600914-78b084683601?auto=format&fit=crop&q=80&w=300',
          ]),
          const SizedBox(height: 24),
          _buildListOption(context, "Saved Assets", Icons.bookmark_outline),
          _buildListOption(context, "Download History", Icons.download_done_outlined),
          _buildListOption(context, "Asset Packages", Icons.inventory_2_outlined),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }

  Widget _buildCategory(BuildContext context, String title, List<String> images) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.black)),
        const SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(images[index], width: 120, fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListOption(BuildContext context, String title, IconData icon) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Icon(icon, color: AppColors.accent),
      title: Text(title, style: TextStyle(color: isDark ? Colors.white : AppColors.black)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: const TopBarWidget(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSizes.m),
            color: isDark ? Colors.white10 : Colors.blue[50],
            child: Row(
              children: [
                const Icon(Icons.groups, color: AppColors.accent, size: 40),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Join the Beauty Circle", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("Connect with 5k+ brand partners", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent, foregroundColor: Colors.black),
                  child: const Text("Join"),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) => ListTile(
                leading: CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=$index')),
                title: Text("Beauty Tips Group #$index"),
                subtitle: const Text("Recent activity: 2 mins ago"),
                trailing: const Icon(Icons.chat_bubble_outline),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: AppColors.accent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
                    ),
                    const SizedBox(height: 8),
                    const Text("Amanda Roberts", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black)),
                    Text("Oriflame Brand Partner", style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat("Posts", "128"),
                    _buildStat("Earnings", "\$1,240"),
                    _buildStat("Points", "3.4k"),
                  ],
                ),
                const SizedBox(height: 32),
                _buildOption(context, Icons.settings, "Account Settings"),
                _buildOption(context, Icons.account_balance_wallet, "My Wallet"),
                _buildOption(context, Icons.help_outline, "Help & Support"),
                _buildOption(context, Icons.logout, "Logout", color: Colors.red),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: AppColors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildOption(BuildContext context, IconData icon, String title, {Color? color}) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color ?? (isDark ? Colors.white : AppColors.black))),
      trailing: const Icon(Icons.chevron_right, size: 16),
      onTap: () {},
    );
  }
}
