// import 'package:flutter/material.dart';

// import 'package:get/get.dart';
// import 'package:gold/app/core/app_color.dart';

// import '../controllers/star_line_bid_history_controller.dart';

// class StarLineBidHistoryView extends GetView<StarLineBidHistoryController> {
//   const StarLineBidHistoryView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Star Line Bid History'),
//         centerTitle: true,
//       ),
//       body:  GetBuilder(
//         init: controller,
//         builder: (context) {
//           return Visibility(
//             replacement: Center(
//                 child: CircularProgressIndicator(
//               color: AppColors.primary,
//             )),
//             visible: !controller.isLoading,
//             child: Visibility(
//                 replacement: const Center(
//                   child: Text("No Bid found"),
//                 ),
//                 visible: controller.bets.isNotEmpty,
//                 child: ListView.builder(
//                   itemCount: controller.bets.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     var bet = controller.bets[index];
//                     return Card(
//                       shape: BeveledRectangleBorder(
//                         // borderRadius: BorderRadius.all(Radius.circular(5)),
//                         side: BorderSide(
//                             color: AppColors.primary, width: 2.5),
//                       ),
//                       child: SizedBox(
//                         height: 140,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Card(
//                                 color: AppColors.primary,
//                                 shape: ContinuousRectangleBorder(
//                                     borderRadius: BorderRadius.circular(25)),
//                                 child: SizedBox(
//                                   width: MediaQuery.sizeOf(context).width,
//                                   height: 40,
//                                   child: Center(
//                                     child: Text(
//                                       "${bet.gameName}",
//                                       style: const TextStyle(
//                                           fontSize: 20, color: Colors.white),
//                                       textAlign: TextAlign.center,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20),
//                                 child: Table(
//                                   children: [
//                                     TableRow(children: [
//                                       Text(
//                                         bet.betType ?? '',
//                                         style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                       const Text(
//                                         "Points",
//                                         style: TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ]),
//                                     TableRow(children: [
//                                       Text(
//                                         bet.betNumber.toString(),
//                                         style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                       Text(
//                                         bet.betAmount.toString() ?? '',
//                                         style: const TextStyle(
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ]),
//                                   ],
//                                 ),
//                               ),
//                               Text(
//                                 "Bid Time: ${bet.timestamp.toString().split(".").first}",
//                                 style: const TextStyle(
//                                     fontSize: 15, fontWeight: FontWeight.w600),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 )),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:intl/intl.dart';


import '../controllers/star_line_bid_history_controller.dart';

class StarLineBidHistoryView extends GetView<StarLineBidHistoryController> {
  const StarLineBidHistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primary,
              AppColors.primaryDark,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom App Bar
              _buildAppBar(),
              
              // Content
              Expanded(
                child: GetBuilder(
                  init: controller,
                  builder: (context) {
                    if (controller.isLoading) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              color: AppColors.secondary,
                              strokeWidth: 3,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Loading your bids...",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    
                    if (controller.bets.isEmpty) {
                      return _buildEmptyState();
                    }
                    
                    return _buildBidList();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  // Custom App Bar
  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
          
          // Title
          Column(
            children: [
              // Gold Kalyan Logo Text
              Row(
                children: [
                  Text(
                    "K",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  Text(
                    "M",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
              
              // Page Title
              const Text(
                "Bid History",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          
          // Filter Button (Optional - just for balance)
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () {
                // Filter action can be added here if needed
              },
              icon: Icon(
                Icons.filter_list,
                color: AppColors.secondary,
                size: 22,
              ),
              tooltip: "Filter bids",
            ),
          ),
        ],
      ),
    );
  }
  
  // Empty State
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(0.1),
            ),
            child: Icon(
              Icons.history,
              size: 80,
              color: AppColors.secondary.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            "No Bid History Found",
            style: TextStyle(
              color: AppColors.secondary,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Place a bet to see your history here",
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: AppColors.secondaryGradient,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                "Go to Games",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  // Bid List
  Widget _buildBidList() {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: controller.bets.length,
      itemBuilder: (BuildContext context, int index) {
        var bet = controller.bets[index];
        
        // Format the timestamp
        String formattedDate = "";
        try {
          if (bet.timestamp != null) {
            final timestamp = bet.timestamp.toString().split(".").first;
            final DateTime dateTime = DateTime.parse(timestamp);
            formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
          }
        } catch (e) {
          formattedDate = bet.timestamp?.toString().split(".").first ?? "N/A";
        }
        
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowMedium,
                blurRadius: 8,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.9),
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bet.gameName ?? "Game",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: AppColors.secondary,
                                size: 14,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                   
                  ],
                ),
              ),
              
              // Content
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    // Bet Type & Amount
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoItem(
                            label: "BET TYPE",
                            value: bet.betType ?? "N/A",
                            valueStyle: TextStyle(
                              color: AppColors.primary,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          child: _buildInfoItem(
                            label: "AMOUNT",
                            value: "₹${bet.betAmount ?? 0}",
                            valueStyle: TextStyle(
                              color: AppColors.secondary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 15),
                    
                    // Bet Numbers
                    _buildInfoItem(
                      label: "BET NUMBER",
                      value: bet.betNumber.toString(),
                      valueStyle: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      isFullWidth: true,
                      showBackground: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  
  // Helper method for info items
  Widget _buildInfoItem({
    required String label,
    required String value,
    required TextStyle valueStyle,
    bool isFullWidth = false,
    bool showBackground = false,
  }) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      padding: showBackground 
          ? const EdgeInsets.symmetric(vertical: 10, horizontal: 15)
          : EdgeInsets.zero,
      decoration: showBackground
          ? BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.secondary.withOpacity(0.3),
                width: 1,
              ),
            )
          : null,
      child: Column(
        crossAxisAlignment: isFullWidth 
            ? CrossAxisAlignment.center 
            : CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: valueStyle,
            textAlign: isFullWidth ? TextAlign.center : TextAlign.start,
          ),
        ],
      ),
    );
  }
}