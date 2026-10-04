import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../model/group_member.dart';

class MemberTitleHeader extends StatelessWidget {
  final GroupMember member;
  final VoidCallback onCopyNim;

  const MemberTitleHeader({
    super.key,
    required this.member,
    required this.onCopyNim,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Member Name
        Text(
          member.name,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.4,
              ),
        ),

        const SizedBox(height: 6),

        // Role Badge
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: AppColors.activeTabBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.cashmere.withValues(alpha: 0.6),
              width: 1,
            ),
          ),
          child: Text(
            member.role,
            style: const TextStyle(
              color: AppColors.deepBlush,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ),

        const SizedBox(height: 10),

        // Interactive NIM Badge (Tap to copy)
        InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onCopyNim,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.numbers_rounded,
                  size: 15,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 6),
                Text(
                  'NIM: ${member.id}',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(width: 6),
                const Icon(
                  Icons.copy_rounded,
                  size: 14,
                  color: AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
