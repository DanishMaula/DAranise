import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/theme.dart';
import '../../model/group_member.dart';
import 'live_photo_widget.dart';

class MemberPhotoHeader extends StatelessWidget {
  final GroupMember member;
  final VoidCallback onShowFullPhoto;

  const MemberPhotoHeader({
    super.key,
    required this.member,
    required this.onShowFullPhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 290,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(color: AppColors.backgroundWarm),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 1. Ambient Blurred Backdrop
          Positioned.fill(
            child: member.image != null && member.image!.isNotEmpty
                ? ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
                    child: Transform.scale(
                      scale: 1.25,
                      child: Image.asset(
                        member.image!,
                        fit: BoxFit.cover,
                        cacheWidth: 300,
                        gaplessPlayback: true,
                        errorBuilder: (context, error, stackTrace) =>
                            const SizedBox.shrink(),
                      ),
                    ),
                  )
                : Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFFDECEF),
                          AppColors.silkBeach,
                          AppColors.backgroundWarm,
                        ],
                      ),
                    ),
                  ),
          ),

          // 2. Soft Gradient Tint & Seamless Bottom Blend
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.45, 1.0],
                  colors: [
                    Colors.black.withValues(alpha: 0.15),
                    AppColors.backgroundWarm.withValues(alpha: 0.45),
                    AppColors.backgroundWarm,
                  ],
                ),
              ),
            ),
          ),

          // 3. Foreground Portrait Showcase Card with Leopard Accent Ring INSIDE Hero
          // Background leopard dibungkus di dalam Hero agar ikut bergerak saat animasi navigasi
          Hero(
            tag: 'member-avatar-${member.id}',
            createRectTween: (begin, end) {
              return MaterialRectArcTween(begin: begin, end: end);
            },
            flightShuttleBuilder: (
              flightContext,
              animation,
              flightDirection,
              fromHeroContext,
              toHeroContext,
            ) {
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
              child: SizedBox(
                width: 192,
                height: 244,
                child: Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    // Background Leopard Accent Ring & Ambient Glow (Ikut bergerak di dalam Hero)
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.deepBlush.withValues(alpha: 0.22),
                              blurRadius: 32,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(28),
                          child: Opacity(
                            opacity: 0.42,
                            child: Image.asset(
                              'assets/images/leopard.PNG',
                              fit: BoxFit.cover,
                              cacheWidth: 400,
                              gaplessPlayback: true,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Foreground Portrait Showcase Card
                    Container(
                      width: 180,
                      height: 232,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: Colors.white, width: 3.5),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.richWood.withValues(alpha: 0.16),
                            blurRadius: 22,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22.5),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            LivePhotoWidget(
                              imagePath: member.image,
                              videoPath: member.video,
                              alignment: const Alignment(0, -0.2),
                              fit: BoxFit.cover,
                              placeholder: MemberInitialsPlaceholder(member: member),
                              onTap: onShowFullPhoto,
                            ),

                            // Subtle bottom gradient vignette for depth
                            if (member.image != null && member.image!.isNotEmpty)
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                height: 52,
                                child: IgnorePointer(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withValues(alpha: 0.35),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            // Fullscreen / Zoom Hint Button
                            if (member.image != null && member.image!.isNotEmpty)
                              Positioned(
                                right: 8,
                                bottom: 8,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: onShowFullPhoto,
                                    borderRadius: BorderRadius.circular(16),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.45),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(
                                          color: Colors.white.withValues(alpha: 0.4),
                                          width: 1,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.fullscreen_rounded,
                                        color: Colors.white,
                                        size: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MemberInitialsPlaceholder extends StatelessWidget {
  final GroupMember member;

  const MemberInitialsPlaceholder({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.silkBeach, Color(0xFFF2D3D8)],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.cashmere, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 12,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  member.displayInitials,
                  style: const TextStyle(
                    color: AppColors.deepBlush,
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                member.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
