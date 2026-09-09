// ============================================================
// SAMPLE DATA
// Static fixture data used by all sample screens.
// No backend, no APIs, no real authentication.
// ============================================================

abstract final class SampleData {
  // ----------------------------------------------------------
  // User / Profile
  // ----------------------------------------------------------
  static const String userName = 'Alexandra Chen';
  static const String userHandle = '@alexchen';
  static const String userEmail = 'alex.chen@company.com';
  static const String userTitle = 'Senior Product Designer';
  static const String userDepartment = 'Design & UX';
  static const String userLocation = 'San Francisco, CA';
  static const String userPhone = '+1 (415) 555-0182';
  static const String userBio =
      'Passionate about building products that are both beautiful and accessible. '
      '7+ years crafting user experiences for enterprise software.';
  static const String userInitials = 'AC';
  static const String userJoinDate = 'March 2020';

  // ----------------------------------------------------------
  // Dashboard Stats
  // ----------------------------------------------------------
  static const List<DashboardStat> stats = [
    DashboardStat(label: 'Projects', value: '24', delta: '+3', isPositive: true),
    DashboardStat(label: 'Tasks Done', value: '142', delta: '+18', isPositive: true),
    DashboardStat(label: 'In Review', value: '7', delta: '-2', isPositive: false),
    DashboardStat(label: 'Team Members', value: '12', delta: '+1', isPositive: true),
  ];

  // ----------------------------------------------------------
  // Recent Activity
  // ----------------------------------------------------------
  static const List<ActivityItem> activities = [
    ActivityItem(
      id: '1',
      title: 'Design System v2.0 released',
      subtitle: 'Component library updated with 16 new widgets',
      timeAgo: '2h ago',
      icon: ActivityIcon.design,
      badgeVariant: ActivityBadge.success,
      badgeLabel: 'Completed',
    ),
    ActivityItem(
      id: '2',
      title: 'Q4 roadmap review',
      subtitle: 'Scheduled meeting with stakeholders',
      timeAgo: '4h ago',
      icon: ActivityIcon.calendar,
      badgeVariant: ActivityBadge.warning,
      badgeLabel: 'Pending',
    ),
    ActivityItem(
      id: '3',
      title: 'Accessibility audit passed',
      subtitle: 'All 47 screens meet WCAG AA requirements',
      timeAgo: '1d ago',
      icon: ActivityIcon.check,
      badgeVariant: ActivityBadge.success,
      badgeLabel: 'Passed',
    ),
    ActivityItem(
      id: '4',
      title: 'Mobile onboarding flow',
      subtitle: 'In progress — 6 of 8 screens complete',
      timeAgo: '1d ago',
      icon: ActivityIcon.mobile,
      badgeVariant: ActivityBadge.primary,
      badgeLabel: 'In Progress',
    ),
    ActivityItem(
      id: '5',
      title: 'User research synthesis',
      subtitle: '15 interviews condensed into 4 key insights',
      timeAgo: '2d ago',
      icon: ActivityIcon.research,
      badgeVariant: ActivityBadge.primary,
      badgeLabel: 'In Progress',
    ),
    ActivityItem(
      id: '6',
      title: 'Sprint 12 planning',
      subtitle: '22 story points committed for next sprint',
      timeAgo: '3d ago',
      icon: ActivityIcon.sprint,
      badgeVariant: ActivityBadge.secondary,
      badgeLabel: 'Archived',
    ),
  ];

  // ----------------------------------------------------------
  // Projects / Quick links
  // ----------------------------------------------------------
  static const List<ProjectItem> projects = [
    ProjectItem(
      name: 'Mobile App Redesign',
      progress: 0.72,
      members: 4,
      dueDate: 'Dec 15',
      colorHex: 0xFF0066CC,
    ),
    ProjectItem(
      name: 'Design System Docs',
      progress: 0.90,
      members: 2,
      dueDate: 'Nov 30',
      colorHex: 0xFF059669,
    ),
    ProjectItem(
      name: 'Onboarding Flow',
      progress: 0.45,
      members: 3,
      dueDate: 'Jan 10',
      colorHex: 0xFFD97706,
    ),
  ];

  // ----------------------------------------------------------
  // Team members
  // ----------------------------------------------------------
  static const List<TeamMember> team = [
    TeamMember(name: 'Marcus Rivera', initials: 'MR', role: 'Frontend Engineer', isOnline: true),
    TeamMember(name: 'Priya Nair', initials: 'PN', role: 'Product Manager', isOnline: true),
    TeamMember(name: 'James O\'Brien', initials: 'JO', role: 'UX Researcher', isOnline: false),
    TeamMember(name: 'Sofia Liu', initials: 'SL', role: 'Backend Engineer', isOnline: true),
    TeamMember(name: 'Daniel Kim', initials: 'DK', role: 'Data Analyst', isOnline: false),
  ];

  // ----------------------------------------------------------
  // Profile links / achievements
  // ----------------------------------------------------------
  static const List<ProfileLink> profileLinks = [
    ProfileLink(label: 'My Projects', icon: 0xe559, count: 24),   // folder
    ProfileLink(label: 'Completed Tasks', icon: 0xe876, count: 142), // check_circle
    ProfileLink(label: 'Saved Templates', icon: 0xe145, count: 8),  // bookmark_add
    ProfileLink(label: 'Mentions', icon: 0xe7f4, count: 5),         // alternate_email
  ];

  // ----------------------------------------------------------
  // Settings
  // ----------------------------------------------------------
  static const List<SettingsSection> settingsSections = [
    SettingsSection(title: 'Appearance', items: [
      SettingsItem(label: 'Dark Mode', subtitle: 'Switch to dark theme', type: SettingsItemType.toggle, isEnabled: false, icon: 0xe51c),
      SettingsItem(label: 'Compact Layout', subtitle: 'Reduce spacing in lists', type: SettingsItemType.toggle, isEnabled: true, icon: 0xe8fe),
      SettingsItem(label: 'Accent Color', subtitle: 'Blue (default)', type: SettingsItemType.navigate, icon: 0xe40a),
      SettingsItem(label: 'Font Size', subtitle: 'Follow system setting', type: SettingsItemType.navigate, icon: 0xe245),
    ]),
    SettingsSection(title: 'Notifications', items: [
      SettingsItem(label: 'Push Notifications', subtitle: 'Receive alerts on your device', type: SettingsItemType.toggle, isEnabled: true, icon: 0xe7f4),
      SettingsItem(label: 'Email Digest', subtitle: 'Daily summary at 9am', type: SettingsItemType.toggle, isEnabled: true, icon: 0xe158),
      SettingsItem(label: 'Mention Alerts', subtitle: 'Notify when mentioned', type: SettingsItemType.toggle, isEnabled: true, icon: 0xe255),
      SettingsItem(label: 'Sound & Haptics', subtitle: 'Notification sounds', type: SettingsItemType.navigate, icon: 0xe050),
    ]),
    SettingsSection(title: 'Privacy & Security', items: [
      SettingsItem(label: 'Two-Factor Authentication', subtitle: 'Enabled via authenticator app', type: SettingsItemType.navigate, icon: 0xe897, badgeLabel: 'On', badgeVariant: SettingsBadge.success),
      SettingsItem(label: 'Login Activity', subtitle: 'View recent sign-ins', type: SettingsItemType.navigate, icon: 0xe8b8),
      SettingsItem(label: 'Data & Privacy', subtitle: 'Manage your data', type: SettingsItemType.navigate, icon: 0xe88e),
    ]),
    SettingsSection(title: 'About', items: [
      SettingsItem(label: 'Version', subtitle: '2.4.1 (build 1042)', type: SettingsItemType.info, icon: 0xe88e),
      SettingsItem(label: 'Terms of Service', subtitle: null, type: SettingsItemType.navigate, icon: 0xe873),
      SettingsItem(label: 'Privacy Policy', subtitle: null, type: SettingsItemType.navigate, icon: 0xe88e),
      SettingsItem(label: 'Open Source Licenses', subtitle: null, type: SettingsItemType.navigate, icon: 0xe86f),
    ]),
  ];
}

// ----------------------------------------------------------
// Data models
// ----------------------------------------------------------

class DashboardStat {
  const DashboardStat({
    required this.label,
    required this.value,
    required this.delta,
    required this.isPositive,
  });
  final String label;
  final String value;
  final String delta;
  final bool isPositive;
}

enum ActivityIcon { design, calendar, check, mobile, research, sprint }
enum ActivityBadge { success, warning, primary, secondary }

class ActivityItem {
  const ActivityItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timeAgo,
    required this.icon,
    required this.badgeVariant,
    required this.badgeLabel,
  });
  final String id;
  final String title;
  final String subtitle;
  final String timeAgo;
  final ActivityIcon icon;
  final ActivityBadge badgeVariant;
  final String badgeLabel;
}

class ProjectItem {
  const ProjectItem({
    required this.name,
    required this.progress,
    required this.members,
    required this.dueDate,
    required this.colorHex,
  });
  final String name;
  final double progress;
  final int members;
  final String dueDate;
  final int colorHex;
}

class TeamMember {
  const TeamMember({
    required this.name,
    required this.initials,
    required this.role,
    required this.isOnline,
  });
  final String name;
  final String initials;
  final String role;
  final bool isOnline;
}

class ProfileLink {
  const ProfileLink({
    required this.label,
    required this.icon,
    required this.count,
  });
  final String label;
  final int icon; // codePoint for IconData
  final int count;
}

enum SettingsItemType { toggle, navigate, info }
enum SettingsBadge { success, warning, error, primary }

class SettingsItem {
  const SettingsItem({
    required this.label,
    this.subtitle,
    required this.type,
    required this.icon,
    this.isEnabled,
    this.badgeLabel,
    this.badgeVariant,
  });
  final String label;
  final String? subtitle;
  final SettingsItemType type;
  final int icon;
  final bool? isEnabled;
  final String? badgeLabel;
  final SettingsBadge? badgeVariant;
}

class SettingsSection {
  const SettingsSection({
    required this.title,
    required this.items,
  });
  final String title;
  final List<SettingsItem> items;
}
