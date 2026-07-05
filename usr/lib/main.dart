import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'data/profile.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dipongkar Barmon | Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF38BDF8),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF38BDF8),
          secondary: Color(0xFF818CF8),
          surface: Color(0xFF1E293B),
        ),
        textTheme: ThemeData.dark().textTheme.apply(
          fontFamily: 'Roboto', // Fallback font
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PortfolioHome(),
      },
    );
  }
}

class PortfolioHome extends StatelessWidget {
  const PortfolioHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHero(context),
            _buildAbout(context),
            _buildSkills(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 800;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: isMobile ? 0 : 1,
              child: Column(
                crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hello, I'm",
                    style: TextStyle(fontSize: 24, color: Color(0xFF38BDF8)),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Profile.name,
                    style: TextStyle(
                      fontSize: isMobile ? 40 : 64,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    Profile.role,
                    style: TextStyle(
                      fontSize: isMobile ? 24 : 32,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    Profile.heroDescription,
                    style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFFCBD5E1)),
                    textAlign: isMobile ? TextAlign.center : TextAlign.left,
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF38BDF8),
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text("Hire Me", style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Color(0xFF38BDF8)),
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        ),
                        child: const Text("Download Resume"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!isMobile) const SizedBox(width: 80),
            if (isMobile) const SizedBox(height: 60),
            Container(
              width: isMobile ? 250 : 400,
              height: isMobile ? 250 : 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF38BDF8), width: 4),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF38BDF8).withOpacity(0.3),
                    blurRadius: 50,
                    spreadRadius: 10,
                  )
                ],
                image: const DecorationImage(
                  image: NetworkImage(Profile.profileImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      child: Column(
        children: [
          const Text("About Me", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Text(
              "I am a passionate Software Engineering student and Full Stack Developer. My primary interest lies in building robust web applications and integrating Machine Learning models into software solutions. I thrive in environments where I can learn new technologies and apply them to solve real-world problems.",
              style: const TextStyle(fontSize: 18, height: 1.6, color: Color(0xFFCBD5E1)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkills(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
      color: const Color(0xFF1E293B),
      width: double.infinity,
      child: Column(
        children: [
          const Text("Skills", style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(height: 60),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            children: Profile.programmingSkills.map((skill) => _buildSkillChip(skill)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0xFF38BDF8).withOpacity(0.3)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 16, color: Color(0xFF38BDF8))),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(Icons.code, Profile.github),
              const SizedBox(width: 16),
              _buildSocialIcon(Icons.business, Profile.linkedin),
              const SizedBox(width: 16),
              _buildSocialIcon(Icons.email, "mailto:${Profile.email}"),
            ],
          ),
          const SizedBox(height: 24),
          const Text("© 2026 Dipongkar Barmon. All rights reserved.", style: TextStyle(color: Color(0xFF94A3B8))),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF38BDF8).withOpacity(0.5)),
        ),
        child: Icon(icon, color: const Color(0xFF38BDF8)),
      ),
    );
  }
}
