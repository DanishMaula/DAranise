import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/theme.dart';
import '../../model/group_member.dart';
import '../widgets/member_bio_card.dart';
import '../widgets/member_full_photo_dialog.dart';
import '../widgets/member_info_card.dart';
import '../widgets/member_photo_header.dart';
import '../widgets/member_skills_card.dart';
import '../widgets/member_title_header.dart';

class GroupMemberDetailScreen extends StatelessWidget {
  final GroupMember member;

  const GroupMemberDetailScreen({super.key, required this.member});

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label berhasil disalin'),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
        backgroundColor: AppColors.richWood,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Detail Member')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.35, 1.0],
            colors: [
              Color(0xFFFDECEF),
              AppColors.backgroundWarm,
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              MemberPhotoHeader(
                member: member,
                onShowFullPhoto: () => MemberFullPhotoDialog.show(context, member),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: [
                    MemberTitleHeader(
                      member: member,
                      onCopyNim: () => _copyToClipboard(context, member.id, 'NIM'),
                    ),
                    const SizedBox(height: 24),
                    if (member.bio != null && member.bio!.isNotEmpty) ...[
                      MemberBioCard(bio: member.bio!),
                      const SizedBox(height: 16),
                    ],
                    if (member.skills.isNotEmpty) ...[
                      MemberSkillsCard(skills: member.skills),
                      const SizedBox(height: 16),
                    ],
                    MemberInfoCard(
                      member: member,
                      onCopy: (text, label) => _copyToClipboard(context, text, label),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
