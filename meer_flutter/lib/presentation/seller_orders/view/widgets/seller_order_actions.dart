import 'package:flutter/material.dart';

class SellerOrderActions extends StatelessWidget {
  const SellerOrderActions({
    super.key,
    required this.status,
    required this.isUpdating,
    required this.onAccept,
    required this.onReject,
    required this.onMarkReady,
    required this.onMarkCompleted,
  });

  final String status;
  final bool isUpdating;

  final VoidCallback onAccept;
  final VoidCallback onReject;
  final VoidCallback onMarkReady;
  final VoidCallback onMarkCompleted;

  Future<void> _confirmReject(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('رفض الطلب'),
        content: const Text('هل أنت متأكد من رفض هذا الطلب؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('رفض الطلب'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      onReject();
    }
  }

  Future<void> _confirmMarkCompleted(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('تأكيد تسليم الطلب'),
        content: const Text('هل تم تسليم الطلب للمشتري بالفعل؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('رجوع'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('نعم، تم التسليم'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      onMarkCompleted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return switch (status) {
      'pending' => _buildPendingActions(context),
      'preparing' => _buildPreparingAction(),
      'ready' => _buildReadyAction(context),
      _ => const SizedBox.shrink(),
    };
  }

  Widget _buildPendingActions(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Expanded(
          child: FilledButton(
            onPressed: isUpdating ? null : onAccept,
            child: const Text('قبول الطلب'),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton(
            onPressed: isUpdating ? null : () => _confirmReject(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: colors.error,
            ),
            child: const Text('رفض الطلب'),
          ),
        ),
      ],
    );
  }

  Widget _buildPreparingAction() {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: isUpdating ? null : onMarkReady,
        icon: const Icon(Icons.check_circle_outline),
        label: const Text('الطلب جاهز للتسليم'),
      ),
    );
  }

  Widget _buildReadyAction(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: isUpdating ? null : () => _confirmMarkCompleted(context),
        icon: const Icon(Icons.check_circle_outline),
        label: const Text('تأكيد تسليم الطلب'),
      ),
    );
  }
}
