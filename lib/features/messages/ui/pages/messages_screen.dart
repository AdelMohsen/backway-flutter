import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/assets/app_images.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/theme/text_styles/text_styles.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../../core/theme/colors/styles.dart';
import '../../../../core/utils/widgets/misc/custom_scaffold_widget.dart';
import '../../../../core/utils/widgets/misc/graident_heaader_layout.dart';
import '../../../../core/navigation/custom_navigation.dart';
import '../../../../core/navigation/routes.dart';
import '../widgets/message_item_widget.dart';
import '../../logic/cubit/messages_cubit.dart';
import '../../logic/state/messages_state.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagesCubit(),
      child: const _MessagesView(),
    );
  }
}

class _MessagesView extends StatelessWidget {
  const _MessagesView({Key? key}) : super(key: key);

  String _formatTime(String? dateString) {
    if (dateString == null) return '';
    try {
      if (dateString.endsWith('Z')) {
        dateString = dateString.substring(0, dateString.length - 1);
      }
      final dateTime = DateTime.parse(dateString);
      return timeago.format(dateTime, locale: mainAppBloc.globalLang);
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffoldWidget(
      needAppbar: false,
      backgroundColor: AppColors.kWhite,
      child: GradientHeaderLayout(
        title: mainAppBloc.isArabic ? 'الرسائل' : 'Messages',
        child: BlocBuilder<MessagesCubit, MessagesState>(
          builder: (context, state) {
            final cubit = context.read<MessagesCubit>();

            if (state is MessagesLoading && cubit.chats.isEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.only(top: 16, bottom: 20),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  );
                },
              );
            }

            if (state is MessagesError && cubit.chats.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.error.message ?? 'حدث خطأ ما'),
                    TextButton(
                      onPressed: () {
                        cubit.fetchMessages(refresh: true);
                      },
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (cubit.chats.isEmpty) {
              return _buildEmptyWidget();
            }

            return RefreshIndicator(
              onRefresh: () async {
                await cubit.fetchMessages(refresh: true);
              },
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                      scrollInfo.metrics.maxScrollExtent) {
                    cubit.fetchMessages();
                  }
                  return false;
                },
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 16, bottom: 20),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount:
                      cubit.chats.length +
                      (state is MessagesPaginationLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == cubit.chats.length) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    final chat = cubit.chats[index];
                    final name =
                        chat.driver?.name ?? chat.customer?.name ?? 'بدون اسم';
                    final message =
                        chat.messages != null && chat.messages!.isNotEmpty
                        ? chat.messages!.last.message ?? ''
                        : '';
                    final time = _formatTime(
                      chat.messages != null && chat.messages!.isNotEmpty
                          ? chat.messages!.last.createdAt
                          : (chat.lastMessageAt ?? chat.createdAt),
                    );
                    final unreadCount = chat.unreadCount ?? 0;
                    final showStatus = chat.driver != null;
                    final avatarUrl =
                        chat.driver?.faceImageUrl ??
                        chat.customer?.faceImageUrl;

                    return MessageItemWidget(
                      onTap: () {
                        if (chat.orderId != null) {
                          CustomNavigator.push(
                            Routes.NEGOTIATION_OFFERS,
                            extra: chat.orderId,
                          );
                        }
                      },
                      name: name,
                      message: message,
                      time: time,
                      unreadCount: unreadCount,
                      showStatus: showStatus,
                      avatarUrl: avatarUrl,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildEmptyWidget() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
    child: Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.ordersEmpty), 
            const SizedBox(height: 24),
            Text(
              textAlign: TextAlign.center,
              mainAppBloc.isArabic
                  ? "ليس لديك رسائل حاليا"
                  : "You have no messages currently",
              style: AppTextStyles.ibmPlexSansSize18w600White.copyWith(
                color: AppColors.primaryGreenHub,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    ),
  );
}
