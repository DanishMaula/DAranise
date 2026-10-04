import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';

class GroupMemberHeader extends StatelessWidget {
  final int memberCount;

  const GroupMemberHeader({
    super.key,
    required this.memberCount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Anggota Kelompok',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
              ),
              const SizedBox(height: 2),
              Text(
                'D’Aranise Project Team',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: AppColors.silkBeach,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.cashmere.withValues(alpha: 0.6),
              ),
            ),
            child: Text(
              '$memberCount Anggota',
              style: const TextStyle(
                color: AppColors.deepBlush,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
