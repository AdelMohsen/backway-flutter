import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greenhub/core/shared/blocs/main_app_bloc.dart';
import 'package:greenhub/core/utils/widgets/misc/custom_scaffold_widget.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/services/pusher/pusher_cubit.dart';
import '../../../../core/services/pusher/pusher_state.dart';
import '../../logic/cubit/negotiation_offers_cubit.dart';
import '../../logic/state/negotiation_offers_state.dart';
import '../widgets/negotiation_app_bar.dart';
import '../widgets/negotiation_input_area.dart';
import '../widgets/negotiation_message_bubble.dart';
import '../widgets/negotiation_static_service_bubble.dart';
import 'dart:convert';

class NegotiationOffersScreen extends StatelessWidget {
  final int orderId;
  const NegotiationOffersScreen({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => PusherCubit()),
        BlocProvider(
          create: (context) =>
              NegotiationOffersCubit(pusherCubit: context.read<PusherCubit>())
                ..fetchNegotiations(orderId: orderId, refresh: true),
        ),
      ],
      child: _NegotiationOffersView(orderId: orderId),
    );
  }
}

class _NegotiationOffersView extends StatefulWidget {
  final int orderId;
  const _NegotiationOffersView({super.key, required this.orderId});

  @override
  State<_NegotiationOffersView> createState() => _NegotiationOffersViewState();
}

class _NegotiationOffersViewState extends State<_NegotiationOffersView> {
  final ScrollController _scrollController = ScrollController();
  late final NegotiationOffersCubit _cubit;
  String? _lastEventName;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<NegotiationOffersCubit>();
  }

  @override
  void dispose() {
    _cubit.disposePusher();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatTime(String? dateString) {
    if (dateString == null) return '';
    try {
      final dateTime = DateTime.parse(dateString).toLocal();
      final formatter = DateFormat(
        'EEEE, dd MMMM, hh:mm a',
        mainAppBloc.globalLang,
      );
      return formatter.format(dateTime);
    } catch (e) {
      return '';
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0.0, // reverse list: 0.0 is the bottom
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
      child: BlocBuilder<NegotiationOffersCubit, NegotiationOffersState>(
        builder: (context, state) {
          final cubit = context.read<NegotiationOffersCubit>();
          final chatDetails = cubit.chatDetails;
          final messages = cubit.messages;
          final targetUser = chatDetails?.driver ?? chatDetails?.customer;
          final targetName =
              chatDetails?.driver?.name ?? chatDetails?.customer?.name ?? '...';
          final targetAvatar =
              chatDetails?.driver?.faceImageUrl ??
              chatDetails?.customer?.faceImageUrl;
          final targetPhone =
              chatDetails?.driver?.phone ?? chatDetails?.customer?.phone;

          return CustomScaffoldWidget(
            backgroundColor: const Color.fromRGBO(249, 255, 254, 1),
            appbar: NegotiationAppBar(
              orderId: widget.orderId,
              name: targetName,
              avatarUrl: targetAvatar,
              phone: targetPhone,
            ),
            child: Column(
              children: [
                // ─── Pusher Status Banner ───
                BlocBuilder<PusherCubit, PusherState>(
                  builder: (context, pusherState) {
                    if (pusherState is PusherReconnecting) {
                      return _buildStatusBanner(
                        mainAppBloc.isArabic
                            ? 'جاري إعادة الاتصال...'
                            : 'Reconnecting...',
                        Colors.orange,
                        Icons.sync,
                      );
                    } else if (pusherState is PusherDisconnected) {
                      return _buildStatusBanner(
                        mainAppBloc.isArabic
                            ? 'تم قطع الاتصال'
                            : 'Disconnected',
                        Colors.red,
                        Icons.cloud_off,
                      );
                    } else if (pusherState is PusherError) {
                      return _buildStatusBanner(
                        mainAppBloc.isArabic
                            ? 'خطأ في الاتصال بالسيرفر'
                            : 'Connection error',
                        Colors.red.shade700,
                        Icons.error_outline,
                      );
                    } else if (pusherState is PusherSubscriptionError) {
                      return _buildStatusBanner(
                        mainAppBloc.isArabic
                            ? 'فشل تصريح القناة (Auth Failed)'
                            : 'Channel Auth Failed',
                        Colors.purple.shade600,
                        Icons.privacy_tip_outlined,
                      );
                    } else if (pusherState is PusherConnecting) {
                      return _buildStatusBanner(
                        mainAppBloc.isArabic
                            ? 'جاري الاتصال...'
                            : 'Connecting...',
                        Colors.blue,
                        Icons.wifi,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),

                if (kDebugMode) _buildDebugFlag(cubit),

                // ─── Messages Area ───
                Expanded(
                  child: MultiBlocListener(
                    listeners: [
                      BlocListener<
                        NegotiationOffersCubit,
                        NegotiationOffersState
                      >(
                        listener: (context, state) {
                          if (state is NegotiationOffersNewMessage) {
                            _scrollToBottom();
                          } else if (state
                              is NegotiationOffersSendMessageError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.error.message),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        },
                      ),
                      BlocListener<PusherCubit, PusherState>(
                        listener: (context, state) {
                          if (state is PusherEventReceived) {
                            setState(() {
                              _lastEventName = state.eventName;
                            });
                          }
                        },
                      ),
                    ],
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await cubit.fetchNegotiations(
                          orderId: widget.orderId,
                          refresh: true,
                        );
                      },
                      child: Builder(
                        builder: (context) {
                          if (state is NegotiationOffersLoading &&
                              messages.isEmpty) {
                            return ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              itemCount: 8,
                              itemBuilder: (context, index) {
                                final isMe = index % 2 == 0;
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      bottom: 24,
                                      left: isMe ? 40 : 0,
                                      right: isMe ? 0 : 40,
                                    ),
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                );
                              },
                            );
                          }

                          if (state is NegotiationOffersError &&
                              messages.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.error.message),
                                  TextButton(
                                    onPressed: () => cubit.fetchNegotiations(
                                      orderId: widget.orderId,
                                      refresh: true,
                                    ),
                                    child: Text(
                                      mainAppBloc.isArabic
                                          ? 'إعادة المحاولة'
                                          : 'Retry',
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }

                          if (messages.isEmpty) {
                            return Center(
                              child: Text(
                                mainAppBloc.isArabic
                                    ? 'لا توجد محادثات'
                                    : 'No messages',
                              ),
                            );
                          }

                          return NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              if (scrollInfo.metrics.pixels ==
                                  scrollInfo.metrics.maxScrollExtent) {
                                cubit.fetchNegotiations(
                                  orderId: widget.orderId,
                                );
                              }
                              return false;
                            },
                            child: ListView.builder(
                              controller: _scrollController,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 20,
                              ),
                              reverse: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount:
                                  messages.length +
                                  (state is NegotiationOffersPaginationLoading
                                      ? 1
                                      : 0),
                              itemBuilder: (context, index) {
                                if (index == messages.length) {
                                  return const Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }

                                final message = messages[index];
                                final isMe = message.senderId != targetUser?.id;

                                if (message.type == 'addService') {
                                  String serviceType = '';
                                  try {
                                    if (message.attachmentUrl != null) {
                                      final attachData = jsonDecode(
                                        message.attachmentUrl!,
                                      );
                                      serviceType =
                                          attachData['service_type'] ?? '';
                                    }
                                  } catch (e) {
                                    // ignore
                                  }
                                  return NegotiationStaticServiceBubble(
                                    avatarUrl: isMe ? null : targetAvatar,
                                    time: _formatTime(message.createdAt),
                                    isMe: isMe,
                                    serviceType: serviceType,
                                    message: message.message ?? '',
                                  );
                                }

                                return NegotiationMessageBubble(
                                  message: message.message ?? '',
                                  time: _formatTime(message.createdAt),
                                  isMe: isMe,
                                  avatarUrl: isMe ? null : targetAvatar,
                                  type: message.type,
                                  attachmentUrl: message.attachmentUrl,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

                // ─── Input Area ───
                NegotiationInputArea(orderId: widget.orderId),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusBanner(String text, Color color, IconData icon) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: color.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebugFlag(NegotiationOffersCubit cubit) {
    return Container(
      width: double.infinity,
      color: Colors.black.withOpacity(0.8),
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        children: [
          SelectableText(
            'DEBUG: private-chat.${cubit.chatDetails?.id ?? "..."} | my-channel',
            style: const TextStyle(
              color: Colors.greenAccent,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
            textAlign: TextAlign.center,
          ),
          if (_lastEventName != null) ...[
            const SizedBox(height: 2),
            Text(
              'LAST EVENT: "$_lastEventName"',
              style: const TextStyle(
                color: Colors.yellowAccent,
                fontSize: 9,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ],
      ),
    );
  }
}
