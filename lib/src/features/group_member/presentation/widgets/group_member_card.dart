import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../model/group_member.dart';

class GroupMemberCard extends StatelessWidget {
  final GroupMember member;
  final VoidCallback onTap;

  const GroupMemberCard({
    super.key,
    required this.member,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: Container(
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
          child: InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  _buildAvatar(),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          member.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.activeTabBackground,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                member.role,
                                style: const TextStyle(
                                  color: AppColors.deepBlush,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'NIM: ${member.id}',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.backgroundWarm,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.border,
                        width: 1,
                      ),
                    ),
                    child: const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.deepBlush,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Hero(
      tag: 'member-avatar-${member.id}',
      createRectTween: (begin, end) {
        return MaterialRectArcTween(begin: begin, end: end);
      },
      flightShuttleBuilder:
          (flightContext, animation, flightDirection, fromHeroContext, toHeroContext) {
        final Hero hero = (flightDirection == HeroFlightDirection.push
            ? toHeroContext.widget
            : fromHeroContext.widget) as Hero;
        return Material(
          type: MaterialType.transparency,
          child: hero.child,
        );
      },
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.silkBeach,
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.cashmere,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: member.image != null && member.image!.isNotEmpty
                ? Image.asset(
                    member.image!,
                    width: 52,
                    height: 52,
                    cacheWidth: 200,
                    gaplessPlayback: true,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return _buildInitials();
                    },
                  )
                : _buildInitials(),
          ),
        ),
      ),
    );
  }

  Widget _buildInitials() {
    return Center(
      child: Text(
        member.displayInitials,
        style: const TextStyle(
          color: AppColors.deepBlush,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}
