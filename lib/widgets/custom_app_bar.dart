import 'package:flutter/material.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../design_system/app_theme.dart';
import '../utils/navigation_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton;
  final bool showDrawerButton;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final int notificationCount;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBackButton = false,
    this.showDrawerButton = false,
    this.scaffoldKey,
    this.notificationCount = 0,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: AppTheme.text,
                size: 24,
              ),
              onPressed: () => handleBackPress(context),
            )
          : showDrawerButton
              ? IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: AppTheme.text,
                    size: 24,
                  ),
                  onPressed: () {
                    if (scaffoldKey?.currentState != null) {
                      scaffoldKey!.currentState!.openDrawer();
                    }
                  },
                )
              : null,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      actions: actions ?? [
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                color: AppTheme.text,
                size: 24,
              ),
              onPressed: () {
                context.pushNamed('notifications');
              },
            ),
            if (notificationCount > 0)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: AppTheme.primary,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: Text(
                    notificationCount > 99 ? '99+' : notificationCount.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () {
              context.pushNamed('profile');
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primary,
                  width: 2,
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/avatar.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }
}
