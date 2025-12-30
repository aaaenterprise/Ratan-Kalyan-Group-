import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/data/constant/assets_constant.dart';
import 'package:gold/app/data/constant/color_constant.dart';
import 'package:gold/app/modules/home/controllers/home_controller.dart';
import 'package:gold/app/routes/app_pages.dart';

class CustomeDrawerWidget extends GetView<HomeController> {
  const CustomeDrawerWidget({super.key});

  @override
  Drawer build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Drawer(
      width: size.width * 0.75,
      backgroundColor: Colors.white,
      elevation: 0,
      child: Column(
        children: [
          // Header with Profile
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            color: Colors.white,
            child: Row(
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.grey[300],
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image(
                      image: AssetImage(AssetsConstant.logo),
                      fit: BoxFit.cover,
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                
                // User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userController.userModel?.name ?? "User",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        controller.userController.userModel?.phone ?? "",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // // Language Button
                // Container(
                //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey[400]!),
                //     borderRadius: BorderRadius.circular(20),
                //   ),
                //   child: const Text(
                //     "Language",
                //     style: TextStyle(
                //       fontSize: 12,
                //       color: Colors.black87,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          
          // Divider
          Divider(
            height: 1,
            thickness: 1,
            color: Colors.grey[300],
          ),
          
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  icon: Icons.person_outline,
                  title: "My Profile",
                  onTap: () => Get.toNamed(Routes.PROFILE),
                ),
                
                _buildMenuItem(
                  icon: Icons.account_balance_wallet_outlined,
                  title: "My Wallet",
                  onTap: () => Get.toNamed(Routes.ADD_POINT),
                ),
                
                _buildMenuItem(
                  icon: Icons.history,
                  title: "Game History",
                  onTap: () => Get.toNamed(Routes.BID_HISTORY),
                ),
                
                if (controller.userController.userModel!.verify!) ...[
                  _buildMenuItem(
                    icon: Icons.star_outline,
                    title: "Game Rate",
                    onTap: () => Get.toNamed(Routes.GAME_RATE),
                  ),
                  
                  _buildMenuItem(
                    icon: Icons.add_circle_outline,
                    title: "Add Funds",
                    onTap: () => Get.toNamed(Routes.ADD_POINT),
                  ),
                  
                  _buildMenuItem(
                    icon: Icons.remove_circle_outline,
                    title: "Withdraw Funds",
                    onTap: () => Get.toNamed(Routes.WITHDRAW_POINT),
                  ),
                ],
                
                _buildMenuItem(
                  icon: Icons.play_circle_outline,
                  title: "How To Play",
                  onTap: () => Get.toNamed(Routes.HOW_TO_PLAY),
                ),
                
                _buildMenuItem(
                  icon: Icons.phone_outlined,
                  title: "Contact us",
                  onTap: () {
                    // Add contact functionality
                  },
                ),
                
                _buildMenuItem(
                  icon: Icons.share_outlined,
                  title: "Share Now",
                  onTap: () {
                    // Add share functionality
                  },
                ),
                
                _buildMenuItem(
                  icon: Icons.star_outline,
                  title: "Rate us",
                  onTap: () {
                    // Add rate functionality
                  },
                ),
                
                _buildMenuItem(
                  icon: Icons.logout,
                  title: "Logout Account",
                  onTap: () => _showLogoutDialog(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  // Helper method to build menu items
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.black87,
            ),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // Helper method to show logout dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                controller.userController.logout();
              },
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}