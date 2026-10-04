import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/theme.dart';
import '../../model/group_member.dart';
import '../widgets/group_member_card.dart';
import '../widgets/group_member_header.dart';

class GroupMemberScreen extends StatelessWidget {
  const GroupMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Group Member')),
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
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              GroupMemberHeader(memberCount: memberList.length),
              ...memberList.map(
                (member) => GroupMemberCard(
                  member: member,
                  onTap: () =>
                      context.push('/group-member-detail', extra: member),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
