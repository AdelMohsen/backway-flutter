import 'package:flutter/material.dart';
import 'package:greenhub/features/offers/ui/widgets/offer_action_buttons.dart';
import 'package:greenhub/features/offers/ui/widgets/offer_carrier_avatar.dart';
import 'package:greenhub/features/offers/ui/widgets/offer_carrier_details.dart';
import 'package:greenhub/features/offers/ui/widgets/offer_rating_badge.dart';
import 'package:greenhub/features/offers/data/models/negotiation_model.dart';
import 'package:greenhub/features/offers/logic/cubit/negotiations_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OfferCard extends StatefulWidget {
  final NegotiationModel negotiation;

  const OfferCard({super.key, required this.negotiation});

  @override
  State<OfferCard> createState() => _OfferCardState();
}

class _OfferCardState extends State<OfferCard> {
  bool isApproved = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          start: 16,
          end: 16,
          bottom: 20,
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OfferCarrierAvatar(
                  imageUrl: widget.negotiation.driver?.faceImage,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OfferCarrierDetails(
                    name: widget.negotiation.driver?.name ?? '',
                    orderNumber: 'SH${widget.negotiation.orderId ?? ""} #',
                    price: widget.negotiation.offeredPrice ?? '',
                  ),
                ),
                const SizedBox(width: 12),
                OfferRatingBadge(
                  rating:
                      double.tryParse(
                        widget.negotiation.driver?.rateing ?? '0',
                      ) ??
                      0.0,
                ),
              ],
            ),
            const SizedBox(height: 20),
            OfferActionButtons(
              onApprove: () {
                if (widget.negotiation.orderId != null &&
                    widget.negotiation.id != null) {
                  context.read<NegotiationsCubit>().acceptNegotiation(
                    orderId: widget.negotiation.orderId!,
                    negotiationId: widget.negotiation.id!,
                  );
                }
              },

              onReject: () {
                if (widget.negotiation.orderId != null &&
                    widget.negotiation.id != null) {
                  context.read<NegotiationsCubit>().rejectNegotiation(
                    orderId: widget.negotiation.orderId!,
                    negotiationId: widget.negotiation.id!,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
