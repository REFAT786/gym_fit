import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gym_fit/Core/routes/routes.dart';
import 'package:gym_fit/Core/routes/routes_name.dart';
import '../../../../Common/widgets/custom_back_button.dart';
import '../../../../Utils/app_string.dart';
import '../../../../Utils/styles.dart';
import '../controller/history_controller.dart';
import '../widget/custom_history_widget.dart';

class HistoryScreen extends StatelessWidget {
  HistoryScreen({Key? key}) : super(key: key);

  final HistoryController controller = Get.put(HistoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const CustomBackButton(),
        ),
        title: Text(
          AppString.history,
          style: styleForText.copyWith(fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchHistory();
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(
                child: Text(
                  controller.errorMessage.value,
                  style: styleForText.copyWith(color: Colors.white, fontSize: 14),
                ));
          }
          if (controller.historyList.isEmpty) {
            return Center(
                child: Text(
                  AppString.noHistoryFound,
                  style: styleForText.copyWith(color: Colors.white),
                ));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(14),
            itemCount: controller.historyList.length,
            itemBuilder: (context, index) {
              final history = controller.historyList[index];
              return InkWell(
                  onTap: (){
                    Get.toNamed(RoutesName.historyDetail, arguments: {'data': history});
                  },
                  child: CustomHistoryWidget(history: history, isButton: false));
            },
          );
        }),
      ),
    );
  }
}
