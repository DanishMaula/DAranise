class GroupMember {
  final String name;
  final String id;
  final String role;
  final String? bio;
  final List<String> skills;
  final String? email;
  final String? github;
  final String? instagram;
  final String? image;
  final String? video;
  final String? initials;

  const GroupMember({
    required this.name,
    required this.id,
    this.role = 'Anggota Kelompok',
    this.bio,
    this.skills = const [],
    this.email,
    this.github,
    this.instagram,
    this.image,
    this.video,
    this.initials,
  });

  String get displayInitials {
    if (initials != null && initials!.trim().isNotEmpty) {
      return initials!;
    }
    final words = name.trim().split(RegExp(r'\s+'));
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty && words[0].isNotEmpty) {
      return words[0].substring(0, words[0].length >= 2 ? 2 : 1).toUpperCase();
    }
    return '';
  }
}

const List<GroupMember> memberList = [
  GroupMember(
    name: 'Danish Maula Hasbi',
    id: '0102524010',
    role: 'Lead Developer & UI/UX',
    bio: 'what?',
    skills: ['Flutter', 'Figma', 'Clean Architecture'],
    initials: 'DM',
    image: 'assets/images/danish.png',
    email: 'danishmaulahasbi@gmail.com',
    instagram: '@danish_maula',
    video: 'assets/videos/danish_vid.mp4',
  ),
  GroupMember(
    name: 'Arofah Laila Irsyahtini',
    id: '0102524007',
    role: 'Project Manager & Analyst',
    bio: 'Organizing ideas into structured, impactful workflows.',
    skills: ['Project Management', 'System Analysis', 'Documentation', 'Scrum'],
    initials: 'AL',
    image: 'assets/images/arofah.png',
    email: 'arofah0806@gmail.com',
    instagram: '@aarofahh',
    video: 'assets/videos/arofah_vid.mp4',
  ),
  GroupMember(
    name: 'Nasywa Putri',
    id: '0102524032',
    role: 'UI/UX & Frontend Developer',
    bio: 'Designing warm, human-centered interfaces with attention to detail.',
    skills: ['UI/UX Design', 'Flutter UI', 'Design System', 'Prototyping'],
    initials: 'NP',
    image: 'assets/images/nasywa.png',
    email: 'nasywa.syahira@icloud.com',
    instagram: '@nsyaahira',
    video: 'assets/videos/nasywa_vid.mp4',
  ),
  GroupMember(
    name: 'Rifana R',
    id: '0102524041',
    role: 'QA & Mobile Developer',
    bio: 'Ensuring high reliability and seamless user journeys.',
    skills: ['Flutter', 'Quality Assurance', 'Testing', 'Usability'],
    initials: 'RR',
    image: 'assets/images/rifa.png',
    email: 'rifana.r@student.ac.id',
    instagram: '@rifarchma',
    video: "assets/videos/rifa_vid.mp4",
  ),
];
