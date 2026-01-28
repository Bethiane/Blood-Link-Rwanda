import 'package:flutter/material.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> faqs = [
      {
        'question': 'What is BloodLink Rwanda?',
        'answer': 'BloodLink Rwanda is a digital platform that connects '
            'voluntary blood donors with registered donation centers. '
            'It helps in managing blood donations and ensuring timely '
            'availability of blood when needed.',
      },
      {
        'question': 'Who manages BloodLink?',
        'answer': 'BloodLink is managed in collaboration with the Rwanda '
            'Biomedical Centre (RBC) and other healthcare partners to '
            'ensure safe and efficient blood donation services.',
      },
      {
        'question': 'Is BloodLink a free service?',
        'answer': 'Yes, BloodLink is completely free for both donors and '
            'healthcare institutions. There are no charges for using '
            'the platform.',
      },
      {
        'question': 'How do I sign up?',
        'answer': 'You can sign up by downloading the app and following '
            'the registration process. You\'ll need to verify your '
            'donor record with RBC if you have donated before.',
      },
      {
        'question': 'What is "deferral status"?',
        'answer': 'Deferral status indicates if you are temporarily or '
            'permanently unable to donate blood due to health reasons, '
            'recent travel, or other factors.',
      },
      {
        'question': 'How will I know when I can donate again?',
        'answer': 'The app tracks your last donation date and notifies '
            'you when you become eligible to donate again (typically '
            'after 3 months for whole blood donations).',
      },
      {
        'question': 'How do I find a nearby donation center?',
        'answer': 'Use the "Nearby Donation Centers" feature in the app '
            'to find the closest donation centers with their working '
            'hours and contact information.',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return _buildFAQCard(faqs[index]);
        },
      ),
    );
  }

  Widget _buildFAQCard(Map<String, String> faq) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          faq['question']!,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              faq['answer']!,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}