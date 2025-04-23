import 'package:flutter/material.dart';

class ShopListPage extends StatefulWidget {
  @override
  _ShopListPageState createState() => _ShopListPageState();
}

class _ShopListPageState extends State<ShopListPage> {
  final List<Map<String, String>> shops = [
    {
      'name': 'QuickPrint Center',
      'location': 'Downtown',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Copy & Print Express',
      'location': 'City Mall',
      'image': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Tarpa Pro Studio',
      'location': 'Uptown Avenue',
      'image': 'https://via.placeholder.com/150'
    },
  ];

  String searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    List<Map<String, String>> filteredShops = shops.where((shop) {
      return shop['name']!
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFf5effe),
      appBar: AppBar(
        backgroundColor: const Color(0xFFf5effe),
        title: const Text('Nearby Printing Shops'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: const [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Account'),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search printing shops...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Suggested Printing Businesses',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: filteredShops.isEmpty
                  ? const Center(child: Text('No shops found.'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      itemCount: filteredShops.length,
                      itemBuilder: (context, index) {
                        final shop = filteredShops[index];
                        return Card(
                                color: const Color(0xFFf471f1),

                          margin: const EdgeInsets.only(bottom: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Image.network(
                                shop['image'] ?? '',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image),
                              ),
                            ),
                            title: Text(
                              shop['name'] ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(shop['location'] ?? ''),
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ShopDetailsPage(shop: shop),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class ShopDetailsPage extends StatelessWidget {
  final Map<String, String> shop;

  const ShopDetailsPage({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(shop['name'] ?? 'Shop Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: screenWidth > 600 ? 3 / 1 : 1.5 / 1,
                child: Image.network(
                  shop['image'] ?? '',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                shop['name'] ?? '',
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Location: ${shop['location'] ?? 'Unknown'}"),
            ],
          ),
        ),
      ),
    );
  }
}
