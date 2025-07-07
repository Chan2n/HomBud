import 'package:flutter/material.dart';

class TermsAndConditionLog extends StatefulWidget {
  const TermsAndConditionLog({super.key});

  @override
  _TermsAndConditionLogState createState() => _TermsAndConditionLogState();
}

class _TermsAndConditionLogState extends State<TermsAndConditionLog> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolledToBottom = false;
  bool _isPressedFacebook = false;
  bool _isPressedInsta = false;
  bool _isPressedTwitter = false;
  bool _isPressedTikTok = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _isScrolledToBottom = true;
      });
    } else if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _isScrolledToBottom = false;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _toggleAnimation(String socialMedia) {
    setState(() {
      switch (socialMedia) {
        case 'facebook':
          _isPressedFacebook = !_isPressedFacebook;
          break;
        case 'instagram':
          _isPressedInsta = !_isPressedInsta;
          break;
        case 'twitter':
          _isPressedTwitter = !_isPressedTwitter;
          break;
        case 'tiktok':
          _isPressedTikTok = !_isPressedTikTok;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Image.asset(
              'lib/assets/images/Terms.png', // Replace with your image asset
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height *
                  0.1, // Adjust the height as needed
              colorBlendMode: BlendMode.srcOver, // Add this line
            ),
          ),
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const Text(
                      'Terms and Privacy Policy',
                      style: TextStyle(
                        fontSize: 22.0, // Reduced font size
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0067A5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  _buildJustifiedContentSection(
                      'These Terms and Agreement ("Terms") govern your use of the HomBuddy platform ("Platform") provided by HomBuddy, Inc. ("HomBuddy," "we," "us," or "our"). By accessing or using the Platform, you agree to be bound by these Terms.\n\nLast updated on [Date]'),
                  _buildSectionTitle(context, '1. Use of the Platform'),
                  _buildJustifiedContentSection(
                      '1.1 Eligibility: You must be at least 18 years old or the age of legal majority in your jurisdiction to use the Platform. By accessing or using the Platform, you represent and warrant that you meet this requirement.\n\n1.2 License: HomBuddy grants you a limited, non-exclusive, non-transferable, and revocable license to use the Platform for personal, non-commercial purposes, subject to these Terms.'),
                  _buildSectionTitle(context, '2. User Accounts'),
                  _buildJustifiedContentSection(
                      '2.1 Registration: To access certain features of the Platform, you may be required to create a user account ("Account"). You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete.\n\n2.2 Account Security: You are responsible for maintaining the confidentiality of your Account login credentials and for all activities that occur under your Account. You agree to notify HomBuddy immediately of any unauthorized access to or use of your Account.'),
                  _buildSectionTitle(context, '3. Content'),
                  _buildJustifiedContentSection(
                      '3.1 User Content: You retain ownership of any content you post or upload to the Platform ("User Content"). By posting or uploading User Content, you grant HomBuddy a worldwide, non-exclusive, royalty-free, sublicensable, and transferable license to use, reproduce, distribute, prepare derivative works of, display, and perform such User Content in connection with the Platform.\n\n3.2 Prohibited Content: You agree not to post or upload any User Content that is unlawful, harmful, threatening, abusive, harassing, defamatory, obscene, or otherwise objectionable.'),
                  _buildSectionTitle(context, '4. Intellectual Property'),
                  _buildJustifiedContentSection(
                      '4.1 Ownership: The Platform and all content, features, and functionality thereof are owned by HomBuddy or its licensors and are protected by copyright, trademark, and other intellectual property laws.\n\n4.2 Trademarks: The HomBuddy name and logo are trademarks of HomBuddy, Inc. You agree not to use or display these trademarks in any manner without our prior written consent.'),
                  _buildSectionTitle(context, '5. Limitation of Liability'),
                  _buildJustifiedContentSection(
                      '5.1 Disclaimer: TO THE FULLEST EXTENT PERMITTED BY APPLICABLE LAW, THE PLATFORM IS PROVIDED "AS IS" AND HOMBuddy MAKES NO WARRANTIES, EXPRESS OR IMPLIED, REGARDING THE PLATFORM OR ITS OPERATION.\n\n5.2 Limitation of Liability: IN NO EVENT SHALL HOMBUDDY BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL, OR PUNITIVE DAMAGES ARISING OUT OF OR IN CONNECTION WITH YOUR USE OF THE PLATFORM.'),
                  _buildSectionTitle(context, '6. Governing Law'),
                  _buildJustifiedContentSection(
                      '6.1 These Terms shall be governed by and construed in accordance with the laws of [Jurisdiction], without regard to its conflict of law principles.'),
                  _buildSectionTitle(context, '7. Miscellaneous'),
                  _buildJustifiedContentSection(
                      '7.1 Entire Agreement: These Terms constitute the entire agreement between you and HomBuddy regarding your use of the Platform and supersede all prior or contemporaneous agreements or understandings, whether oral or written.\n\n7.2 Modifications: HomBuddy reserves the right to modify or revise these Terms at any time. We will notify you of any material changes to these Terms by posting the revised Terms on the Platform.'),
                  _buildSectionTitle(context, 'Privacy Policy for HomBuddy'),
                  _buildJustifiedContentSection(
                      'Effective Date: [insert effective date]\n\nHomBuddy is dedicated to safeguarding the privacy of our users. This Privacy Policy outlines how we collect, utilize, and share your personal data.\n\nWhat Personal Data Do We Collect?\n- Name\n- Mobile number\n- Address\n- Email address (for HB Experts)\n- Government IDs (for HB Experts)\n- NBI Clearance (for HB Experts)\n\nHow Do We Use Your Personal Data?\n- We utilize your personal data to provide you with our home services, enhance our services, and send you marketing communications (with your consent).\n\nDo We Share Your Personal Data With Third Parties?\n- We will only share your personal data with third parties with your explicit consent. For instance, we may share your personal data with third parties if you link your HomBuddy account to other platforms like Facebook or banks. Additionally, we may share your personal data with third-party service providers who assist us in operating our service, such as cloud hosting providers and payment processors.\n\nHow Do We Protect Your Personal Data?\n- We employ a range of security measures to safeguard your personal data, including data encryption, access control, and firewalls. We routinely assess our security measures to ensure they are current and effective.\n\nHow Long Do We Retain Your Personal Data?\n- We retain your personal data for as long as necessary to deliver our services and comply with our legal obligations. We may also retain your personal data for an extended period if we reasonably believe it is necessary to protect our interests or the interests of others.\n\nYour Rights\n- You possess the following rights over your personal data: the right to access your personal data, the right to rectify your personal data, the right to erase your personal data, the right to restrict the processing of your personal data, and the right to object to the processing of your personal data. You can exercise your rights by contacting us at [email protected]'),
                  Image.asset(
                    'lib/assets/images/service.png', // Replace with your image asset
                    height: 80, // Adjust the height as needed
                    width: 80,
                  ),
                  const SizedBox(height: 20.0),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Home Solution at your Doorstep',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          'Level 8F HomBuddy Tower',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Text(
                          'Lot 1A Sample Road Corner Mandaue Street',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        Text(
                          'Sample Street, Cebu City, Philippines',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        SizedBox(height: 20.0),
                        Text(
                          'Follow Us and Keep Updated!',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        _buildSocialIcon(
                            'lib/assets/images/facebook.png', 'facebook'),
                        _buildSocialIcon(
                            'lib/assets/images/insta.png', 'instagram'),
                        _buildSocialIcon('lib/assets/images/x.png', 'twitter'),
                        _buildSocialIcon(
                            'lib/assets/images/tiktok.png', 'tiktok'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 200.0),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _isScrolledToBottom
          ? Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pop(context); // Go back to the previous page
                      },
                      label: const Text('Accept & Continue'),
                      backgroundColor: const Color(0xFF003B5F),
                      foregroundColor: Colors.white,
                    ),
                    const SizedBox(height: 15),
                    FloatingActionButton.extended(
                      onPressed: _scrollToTop,
                      label: const Text('Scroll to Top'),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                  ],
                ),
              ),
            )
          : FloatingActionButton.extended(
              onPressed: _scrollToBottom,
              label: const Text('Scroll to Bottom'),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0067A5),
        ),
      ),
    );
  }

  Widget _buildJustifiedContentSection(String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        content,
        style: const TextStyle(fontSize: 14.0), // Reduced font size
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _buildSocialIcon(String assetPath, String socialMedia) {
    return GestureDetector(
      onTap: () {
        _toggleAnimation(socialMedia);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        transform: Matrix4.diagonal3Values(
          _isPressed(socialMedia) ? 1.2 : 1.0,
          _isPressed(socialMedia) ? 1.2 : 1.0,
          1.0,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: CircleAvatar(
            radius: 15,
            backgroundColor: const Color(0xFF0067A5),
            child: Image.asset(
              assetPath, // Replace with your icon image asset
              width: 15,
              height: 15,
            ),
          ),
        ),
      ),
    );
  }

  bool _isPressed(String socialMedia) {
    switch (socialMedia) {
      case 'facebook':
        return _isPressedFacebook;
      case 'instagram':
        return _isPressedInsta;
      case 'twitter':
        return _isPressedTwitter;
      case 'tiktok':
        return _isPressedTikTok;
      default:
        return false;
    }
  }
}
