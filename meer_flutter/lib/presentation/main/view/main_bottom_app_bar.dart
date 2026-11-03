import 'package:flutter/material.dart';
import 'package:meer_flutter/presentation/main/components/navigation_item.dart';

class MainBottomAppBar extends StatelessWidget {
  final int currentPage;
  final ValueChanged<int> onTap;

  const MainBottomAppBar({
    super.key,
    required this.currentPage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BottomAppBar(
      color: colors.secondaryContainer,
      surfaceTintColor: Colors.transparent,
      elevation: 3,
      shape: const CircularNotchedRectangle(),
      notchMargin: 8,
      child: SizedBox(
        height: 64,
        child: Row(
          children: [
            NavigationItem(
              label: 'الرئيسية',
              icon: Icons.home_outlined,
              activeIcon: Icons.home_rounded,
              selected: currentPage == 0,
              onTap: () => onTap(0),
            ),
            NavigationItem(
              label: 'المفضلة',
              icon: Icons.favorite_border,
              activeIcon: Icons.favorite,
              selected: currentPage == 1,
              onTap: () => onTap(1),
            ),

            // مساحة مخصصة للزر العائم في المنتصف.
            const Spacer(),

            NavigationItem(
              label: 'طلباتي',
              icon: Icons.receipt_long_outlined,
              activeIcon: Icons.receipt_long,
              selected: currentPage == 2,
              onTap: () => onTap(2),
            ),
            NavigationItem(
              label: 'حسابي',
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              selected: currentPage == 3,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}
