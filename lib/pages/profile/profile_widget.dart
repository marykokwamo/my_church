import 'package:flutter/material.dart';
import '../../design_system/app_theme.dart';
import '../../flutter_flow/flutter_flow_util.dart';
import '../../widgets/custom_app_bar.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  String? photoUrl;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.background,
      appBar: CustomAppBar(
        title: 'Profile',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                color: AppTheme.primary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    bottom: -50,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 4,
                            ),
                            image: DecorationImage(
                              image: photoUrl != null
                                  ? NetworkImage(photoUrl!)
                                  : AssetImage('assets/images/avatar.jpg') as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -16,
                          child: Material(
                            color: Colors.transparent,
                            child: PopupMenuButton<String>(
                              icon: Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppTheme.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              onSelected: (String choice) {
                                // Handle photo options
                                switch (choice) {
                                  case 'take':
                                    // Handle take photo
                                    break;
                                  case 'choose':
                                    // Handle choose photo
                                    break;
                                  case 'delete':
                                    // Handle delete photo
                                    break;
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem<String>(
                                    value: 'take',
                                    child: Row(
                                      children: [
                                        Icon(Icons.camera_alt, color: AppTheme.text),
                                        SizedBox(width: 8),
                                        Text('Take a new Photo'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'choose',
                                    child: Row(
                                      children: [
                                        Icon(Icons.photo_library, color: AppTheme.text),
                                        SizedBox(width: 8),
                                        Text('Choose existing'),
                                      ],
                                    ),
                                  ),
                                  if (photoUrl != null)
                                    PopupMenuItem<String>(
                                      value: 'delete',
                                      child: Row(
                                        children: [
                                          Icon(Icons.delete, color: AppTheme.primary),
                                          SizedBox(width: 8),
                                          Text('Delete photo'),
                                        ],
                                      ),
                                    ),
                                ];
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Raphael kimani',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    'jambowebsolutions@gmail.com',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                  ),
                  SizedBox(height: 24),
                  _buildProfileItem(
                    context,
                    Icons.person_outline,
                    'Personal Info',
                    () => context.pushNamed('personal-info'),
                  ),
                  _buildProfileItem(
                    context,
                    Icons.people_outline,
                    'Spouse',
                    () => context.pushNamed('spouse'),
                  ),
                  _buildProfileItem(
                    context,
                    Icons.child_care,
                    'Children',
                    () => context.pushNamed('children'),
                  ),
                  _buildProfileItem(
                    context,
                    Icons.business,
                    'Department',
                    () => context.pushNamed('department'),
                  ),
                  _buildProfileItem(
                    context,
                    Icons.group_work,
                    'Cell Groups',
                    () => context.pushNamed('cell-groups'),
                  ),
                  _buildProfileItem(
                    context,
                    Icons.work,
                    'Profession',
                    () => context.pushNamed('profession'),
                  ),
                  _buildProfileItem(
                    context,
                    Icons.local_parking,
                    'Parking',
                    () => context.pushNamed('parking'),
                  ),
                  _buildProfileItem(
                    context,
                    Icons.feedback,
                    'FeedBack',
                    () => context.pushNamed('feedback'),
                  ),
                  _buildProfileItem(
                    context,
                    Icons.contact_support,
                    'Contact Us',
                    () => context.pushNamed('contact'),
                  ),
                  _buildProfileItem(
                    context,
                    Icons.logout,
                    'Close your account',
                    () => context.pushNamed('close-account'),
                    isDestructive: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDestructive ? AppTheme.primary.withOpacity(0.1) : AppTheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isDestructive ? AppTheme.primary : Colors.white,
                size: 20,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isDestructive ? AppTheme.primary : AppTheme.text,
                    ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: AppTheme.textSecondary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
