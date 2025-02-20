import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../widgets/custom_app_bar.dart';

class ShopWidget extends StatefulWidget {
  const ShopWidget({Key? key}) : super(key: key);

  @override
  _ShopWidgetState createState() => _ShopWidgetState();
}

class _ShopWidgetState extends State<ShopWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Sample shop items - you can move this to a separate data file later
  final List<Map<String, dynamic>> shopItems = [
    {
      'title': 'Daily Devotional',
      'price': '1,599',
      'image': 'assets/images/book1.jpg',
      'author': 'John Doe',
      'category': 'Books',
      'description': 'A daily guide to help you grow in your spiritual journey.',
    },
    {
      'title': 'Prayer Journal',
      'price': '999',
      'image': 'assets/images/book2.jpg',
      'author': 'Jane Doe',
      'category': 'Books',
      'description': 'Record your prayers and see how God answers them.',
    },
    {
      'title': 'Bible Study Guide',
      'price': '1,299',
      'image': 'assets/images/book3.jpg',
      'author': 'Bob Smith',
      'category': 'Books',
      'description': 'An in-depth study guide for serious Bible students.',
    },
    {
      'title': 'Worship CD',
      'price': '799',
      'image': 'assets/images/cd1.jpg',
      'author': 'Church Choir',
      'category': 'Music',
      'description': 'A collection of worship songs to lift your spirit.',
    },
    {
      'title': 'Christian Living',
      'price': '1,499',
      'image': 'assets/images/book4.jpg',
      'author': 'Alice Johnson',
      'category': 'Books',
      'description': 'Learn to live a life that reflects Christ.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar(
        title: 'Shop',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Categories
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildCategoryChip('All', true),
                _buildCategoryChip('Books', false),
                _buildCategoryChip('Music', false),
                _buildCategoryChip('Merchandise', false),
              ],
            ),
          ),
          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: shopItems.length,
              itemBuilder: (context, index) {
                final item = shopItems[index];
                return _buildProductCard(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (bool selected) {
          // Implement category filtering
        },
        backgroundColor: Colors.grey[200],
        selectedColor: Color(0xFFE31E24),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Image.asset(
              item['image'] as String,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String,
                  style: FlutterFlowTheme.of(context).titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  'By ${item['author']}',
                  style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                        color: Colors.grey[600],
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 8),
                Text(
                  'Ksh ${item['price']}',
                  style: FlutterFlowTheme.of(context).titleSmall.copyWith(
                        color: Color(0xFFE31E24),
                        fontWeight: FontWeight.w600,
                      ),
                ),
                SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add to cart
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFE31E24),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Text('Add to Cart'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
