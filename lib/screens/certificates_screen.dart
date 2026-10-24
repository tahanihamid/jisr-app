import 'package:flutter/material.dart';
import '../theme/colors.dart';

enum CertCategory { all, experience, skills, academic, volunteering }
enum CertStatus { earned, pending }

class CertificateModel {
  final String title;
  final String organization;
  final String issueDate;
  final String credentialId;
  final CertCategory category;
  final CertStatus status;
  final bool isInternalApp;
  final String roleOrContext;

  const CertificateModel({
    required this.title,
    required this.organization,
    required this.issueDate,
    required this.credentialId,
    required this.category,
    required this.status,
    required this.isInternalApp,
    required this.roleOrContext,
  });
}

class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({super.key});

  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  CertCategory _selectedCategory = CertCategory.all;

  // Sample data for testing the UI
  final List<CertificateModel> _allCertificates = const [
    CertificateModel(
      title: 'Software Engineering Internship Certificate',
      organization: 'TechVision Solutions',
      issueDate: 'August 2026',
      credentialId: 'EXP-CORP-40192',
      category: CertCategory.experience,
      status: CertStatus.earned,
      isInternalApp: false,
      roleOrContext: '3-Month Full-Stack Engineering Internship',
    ),
    CertificateModel(
      title: 'IT Support & Systems Training',
      organization: 'University Engineering Lab',
      issueDate: 'Applied 3 days ago',
      credentialId: 'PENDING-EXP-1102',
      category: CertCategory.experience,
      status: CertStatus.pending,
      isInternalApp: false,
      roleOrContext: 'Part-time Technical Assistance Track',
    ),
    CertificateModel(
      title: 'Workplace Communication & Pitching',
      organization: 'Jisr Verified Competency Track',
      issueDate: 'October 2026',
      credentialId: 'JISR-SKL-84920',
      category: CertCategory.skills,
      status: CertStatus.earned,
      isInternalApp: true,
      roleOrContext: '20-Scenario Mastery Examination',
    ),
    CertificateModel(
      title: 'UI/UX Visual Prototyping & Design',
      organization: 'Creative Design Studio',
      issueDate: 'Under Verification',
      credentialId: 'PENDING-SKL-3391',
      category: CertCategory.skills,
      status: CertStatus.pending,
      isInternalApp: false,
      roleOrContext: 'Talent & Interface Architecture',
    ),
    CertificateModel(
      title: 'Advanced Web Applications & Architecture',
      organization: 'Istanbul Nişantaşı University',
      issueDate: 'June 2026',
      credentialId: 'UNI-CS-30219',
      category: CertCategory.academic,
      status: CertStatus.earned,
      isInternalApp: false,
      roleOrContext: 'Academic Coursework with High Distinction',
    ),
    CertificateModel(
      title: 'Youth Technology Summit Volunteer Lead',
      organization: 'Community Tech Foundation',
      issueDate: 'July 2026',
      credentialId: 'VOL-TR-99412',
      category: CertCategory.volunteering,
      status: CertStatus.earned,
      isInternalApp: false,
      roleOrContext: 'Event Coordination & Speaker Management',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Filtering logic for tabs and chips
  List<CertificateModel> _getFilteredList(CertStatus status) {
    return _allCertificates.where((cert) {
      final matchesStatus = cert.status == status;
      final matchesCategory = _selectedCategory == CertCategory.all ||
          cert.category == _selectedCategory;
      return matchesStatus && matchesCategory;
    }).toList();
  }

  String _getCategoryTitle(CertCategory category) {
    switch (category) {
      case CertCategory.all:
        return 'All Types';
      case CertCategory.experience:
        return 'Work & Experience';
      case CertCategory.skills:
        return 'Skills & Talents';
      case CertCategory.academic:
        return 'Academic & Courses';
      case CertCategory.volunteering:
        return 'Volunteering';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: TabBar(
              controller: _tabController,
              labelColor: brandColor,
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: brandColor,
              indicatorWeight: 3,
              tabs: const [
                Tab(
                  icon: Icon(Icons.verified_rounded, size: 20),
                  text: 'Earned & Verified',
                ),
                Tab(
                  icon: Icon(Icons.pending_actions_rounded, size: 20),
                  text: 'Applied & In Review',
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: CertCategory.values.map((cat) {
                  final isSelected = _selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(
                        _getCategoryTitle(cat),
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: brandColor,
                      backgroundColor: Colors.grey[100],
                      showCheckmark: false,
                      side: BorderSide(
                        color: isSelected ? brandColor : Colors.grey.shade300,
                      ),
                      onSelected: (val) {
                        setState(() {
                          _selectedCategory = cat;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCertListView(CertStatus.earned),
                _buildCertListView(CertStatus.pending),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Building the list for each tab
  Widget _buildCertListView(CertStatus status) {
    final list = _getFilteredList(status);

    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              status == CertStatus.earned
                  ? Icons.workspace_premium_outlined
                  : Icons.pending_outlined,
              size: 50,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 10),
            Text(
              status == CertStatus.earned
                  ? 'No earned certificates in this section.'
                  : 'No applications under review in this section.',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final item = list[index];
        return _buildCertificateCard(item);
      },
    );
  }

  // The card widget for each certificate
  Widget _buildCertificateCard(CertificateModel item) {
    final isEarned = item.status == CertStatus.earned;

    IconData getLeadingIcon() {
      switch (item.category) {
        case CertCategory.experience:
          return Icons.business_center_rounded;
        case CertCategory.skills:
          return Icons.lightbulb_rounded;
        case CertCategory.academic:
          return Icons.school_rounded;
        case CertCategory.volunteering:
          return Icons.volunteer_activism_rounded;
        case CertCategory.all:
          return Icons.card_membership_rounded;
      }
    }

    // Using ListTile here because it saves time and looks good
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: isEarned
              ? (item.isInternalApp
                  ? brandColor.withOpacity(0.1)
                  : Colors.blueGrey.withOpacity(0.1))
              : Colors.orange.withOpacity(0.1),
          radius: 24,
          child: Icon(
            getLeadingIcon(),
            color: isEarned
                ? (item.isInternalApp ? brandColor : Colors.blueGrey)
                : Colors.orange.shade800,
            size: 24,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${item.organization} • ${item.issueDate}',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isEarned
                          ? Colors.green.withOpacity(0.1)
                          : Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isEarned ? 'Verified Credential' : 'Pending Verification',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isEarned
                            ? Colors.green.shade800
                            : Colors.orange.shade900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.isInternalApp ? 'In-App' : 'External Org',
                      style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded,
            size: 16, color: Colors.grey),
        onTap: () {
          // Check status before opening details
          if (isEarned) {
            _showFormalCertificateModal(item);
          } else {
            _showPendingDetailsModal(item);
          }
        },
      ),
    );
  }

  // Modal for pending certificates
  void _showPendingDetailsModal(CertificateModel item) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.hourglass_bottom_rounded,
                    color: Colors.orange.shade800, size: 28),
                const SizedBox(width: 10),
                const Text(
                  'Credential Review In Progress',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Your document submission for "${item.title}" from ${item.organization} is under evaluation.',
              style: TextStyle(fontSize: 13, color: Colors.grey[700], height: 1.3),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Submission ID:',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(item.credentialId,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Role / Context:',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text(item.roleOrContext,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Expected Review Time:',
                          style: TextStyle(fontSize: 12, color: Colors.grey)),
                      Text('24 - 48 Hours',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 42,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(ctx),
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('Close'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Modal to show the full certificate design
  void _showFormalCertificateModal(CertificateModel item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber.shade400, width: 2),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.verified_outlined,
                            color: brandColor, size: 28),
                        Text(
                          item.category == CertCategory.experience
                              ? 'CERTIFICATE OF EXPERIENCE'
                              : 'OFFICIAL CREDENTIAL',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                            color: Colors.black87,
                          ),
                        ),
                        const Icon(Icons.workspace_premium,
                            color: Colors.amber, size: 28),
                      ],
                    ),
                    const Divider(height: 24),
                    const Text('This official record certifies that',
                        style: TextStyle(fontSize: 12, color: Colors.black54)),
                    const SizedBox(height: 6),
                    const Text(
                      'Tahani Hamid',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: brandColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'has successfully completed\n"${item.title}"',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 13, height: 1.35, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Role: ${item.roleOrContext}',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800]),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Organization / Issuer: ${item.organization}\nDate Issued: ${item.issueDate}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.amber.shade700, width: 2),
                              ),
                              child: Icon(Icons.verified_user,
                                  color: Colors.amber.shade700, size: 28),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'OFFICIAL SEAL',
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                color: Colors.amber.shade800,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(Icons.qr_code_2_rounded,
                                  size: 38, color: Colors.black87),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.credentialId,
                              style: const TextStyle(
                                  fontSize: 9, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.share_outlined, size: 18),
                      label: const Text('Share'),
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Credential link copied to clipboard!')),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Download PDF'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: brandColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(ctx);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Downloading formal certificate PDF...')),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}