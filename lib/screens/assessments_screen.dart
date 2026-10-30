import 'package:flutter/material.dart';
import '../theme/colors.dart';

class _AssessmentTrack {
  final String badgeText;
  final Color badgeColor;
  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> details;
  final String buttonLabel;
  final VoidCallback onTap;

  const _AssessmentTrack({
    required this.badgeText,
    required this.badgeColor,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.details,
    required this.buttonLabel,
    required this.onTap,
  });
}

class AssessmentsScreen extends StatelessWidget {
  const AssessmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tracks = [
      _AssessmentTrack(
        badgeText: 'Guidance & Discovery',
        badgeColor: Colors.deepPurple,
        title: 'Career & Skills Guidance Assistant',
        subtitle:
            'Personalized evaluation to analyze your strengths, identify skill gaps, and map out your ideal career track.',
        icon: Icons.explore_outlined,
        details: const [
          'Strengths & Gaps',
          'Career Roadmap',
          'Personalized Feedback'
        ],
        buttonLabel: 'Start Guidance Assessment',
        onTap: () => _showGuidanceModal(context),
      ),
      _AssessmentTrack(
        badgeText: 'Jisr Verified',
        badgeColor: Colors.green,
        title: 'Skill Assessment & Certification',
        subtitle:
            'Comprehensive 20-question test to evaluate your competency and grant an official completion certificate.',
        icon: Icons.verified_outlined,
        details: const [
          '20 Questions',
          'Earn Certificate',
          'Profile Verified Badge'
        ],
        buttonLabel: 'Take Assessment',
        onTap: () => _showSkillTestModal(context),
      ),
      _AssessmentTrack(
        badgeText: 'Paid Partner Exams',
        badgeColor: Colors.orange.shade800,
        title: 'Institute & Partner Certification',
        subtitle:
            'Formal credentials hosted with accredited universities and institutes. Fill out registration; confirmation arrives via email within 24h.',
        icon: Icons.business_center_outlined,
        details: const [
          'Official Partners',
          'From \$20 - \$50',
          'Email Confirmation'
        ],
        buttonLabel: 'Browse Institutes & Register',
        onTap: () => _showInstituteRegistrationModal(context),
      ),
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: brandColor.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: brandColor.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: brandColor,
                  radius: 24,
                  child: const Icon(
                    Icons.school_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Skills Evaluation & Testing',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Discover your strengths, earn verified skill badges, or register for accredited institute credentials.',
                        style: TextStyle(
                          fontSize: 12,
                          color: subtextColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Testing Tracks',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 12),
          ...tracks.map((track) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: _buildTrackCard(track),
              )),
        ],
      ),
    );
  }

  Widget _buildTrackCard(_AssessmentTrack track) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: track.badgeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  track.badgeText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: track.badgeColor,
                  ),
                ),
              ),
              Icon(track.icon, color: brandColor, size: 22),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            track.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            track.subtitle,
            style: TextStyle(fontSize: 13, color: subtextColor, height: 1.3),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: track.details.map((d) {
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  d,
                  style: TextStyle(fontSize: 11, color: subtextColor),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: ElevatedButton(
              onPressed: track.onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: brandColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                track.buttonLabel,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showGuidanceModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills & Career Guidance Track',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select a diagnostic track to discover your strongest skills and receive a curated action plan.',
              style: TextStyle(fontSize: 13, color: subtextColor),
            ),
            const SizedBox(height: 14),
            ListTile(
              leading: const Icon(Icons.psychology_outlined,
                  color: Colors.deepPurple),
              title: Text('Career Readiness & Soft Skills Discovery',
                  style: TextStyle(color: textColor)),
              subtitle: Text(
                  'Find your workplace strengths & areas to improve',
                  style: TextStyle(color: subtextColor)),
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 16, color: subtextColor),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading:
                  const Icon(Icons.hub_outlined, color: Colors.deepPurple),
              title: Text('Role & Path Compatibility Test',
                  style: TextStyle(color: textColor)),
              subtitle: Text(
                  'Discover which roles best match your current skillset',
                  style: TextStyle(color: subtextColor)),
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 16, color: subtextColor),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }

  void _showSkillTestModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Skill to Certify (20 Questions)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.workspace_premium_outlined,
                  color: Colors.green),
              title: Text('Professional Communication & Presentation',
                  style: TextStyle(color: textColor)),
              subtitle: Text('20 Questions • Passing Score: 75%',
                  style: TextStyle(color: subtextColor)),
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 16, color: subtextColor),
              onTap: () => Navigator.pop(ctx),
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium_outlined,
                  color: Colors.green),
              title: Text('Teamwork & Leadership Dynamics',
                  style: TextStyle(color: textColor)),
              subtitle: Text('20 Questions • Passing Score: 75%',
                  style: TextStyle(color: subtextColor)),
              trailing: Icon(Icons.arrow_forward_ios_rounded,
                  size: 16, color: subtextColor),
              onTap: () => Navigator.pop(ctx),
            ),
          ],
        ),
      ),
    );
  }

  void _showInstituteRegistrationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Partner Institutes & Exam Booking',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 12),
            _buildPartnerTile(
              ctx,
              institute: 'Global Career Academy',
              examName: 'Certified Project Management Associate',
              fee: '\$45',
            ),
            _buildPartnerTile(
              ctx,
              institute: 'National Technical Training Institute',
              examName: 'Professional Soft Skills & Leadership',
              fee: '\$30',
            ),
            _buildPartnerTile(
              ctx,
              institute: 'University Continuing Education Center',
              examName: 'Workplace Readiness & Ethics',
              fee: '\$20',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartnerTile(
    BuildContext ctx, {
    required String institute,
    required String examName,
    required String fee,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 0,
      color: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          examName,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        subtitle: Text(
          '$institute • Fee: $fee',
          style: TextStyle(fontSize: 12, color: subtextColor),
        ),
        trailing: ElevatedButton(
          onPressed: () {
            Navigator.pop(ctx);
            ScaffoldMessenger.of(ctx).showSnackBar(
               SnackBar(
                content: Text(
                  'Application submitted! You will receive the exam schedule and details via email within 24 hours.',
                ),
                backgroundColor: brandColorLight,
                duration: Duration(seconds: 4),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: brandColor,
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 10),
          ),
          child: const Text('Apply', style: TextStyle(fontSize: 12)),
        ),
      ),
    );
  }
}