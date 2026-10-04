import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../model/group_member.dart';

class MemberInfoCard extends StatelessWidget {
  final GroupMember member;
  final void Function(String text, String label) onCopy;

  const MemberInfoCard({super.key, required this.member, required this.onCopy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Akademik & Peran',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 16),
          MemberInfoRow(
            icon: Icons.person_outline_rounded,
            label: 'Nama Lengkap',
            value: member.name,
          ),
          const Divider(height: 24),
          MemberInfoRow(
            icon: Icons.badge_outlined,
            label: 'Peran Proyek',
            value: member.role,
          ),
          const Divider(height: 24),
          MemberInfoRow(
            icon: Icons.group_work_outlined,
            label: 'Tim Proyek',
            value: 'D’Aranise Team',
          ),
          if (member.email != null) ...[
            const Divider(height: 24),
            MemberInfoRow(
              icon: Icons.mail_outline_rounded,
              label: 'Email',
              value: member.email!,
              onTap: () => onCopy(member.email!, 'Email'),
            ),
          ],
          if (member.instagram != null) ...[
            const Divider(height: 24),
            MemberInfoRow(
              icon: Icons.camera_alt_outlined,
              label: 'Instagram',
              value: member.instagram!,
              onTap: () => onCopy(member.instagram!, 'Instagram'),
            ),
          ],
          if (member.github != null) ...[
            const Divider(height: 24),
            MemberInfoRow(
              icon: Icons.code_rounded,
              label: 'GitHub',
              value: member.github!,
              onTap: () => onCopy(member.github!, 'Username GitHub'),
            ),
          ],
        ],
      ),
    );
  }
}

class MemberInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;
  final Widget? trailing;

  const MemberInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final rowContent = Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: AppColors.backgroundWarm,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.deepBlush, size: 20),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.textMuted),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        ?trailing,
        if (onTap != null) ...[
          if (trailing != null) const SizedBox(width: 8),
          const Icon(Icons.copy_rounded, size: 16, color: AppColors.textMuted),
        ],
      ],
    );

    if (onTap != null) {
      return InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: rowContent,
        ),
      );
    }

    return rowContent;
  }
}
