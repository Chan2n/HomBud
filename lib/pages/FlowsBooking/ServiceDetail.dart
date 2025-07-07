import 'package:flutter/material.dart';

class ServiceDetailsPage extends StatelessWidget {
  final String serviceTitle;
  final String desc1;
  final String desc2;
  final String serviceDescription;
  final String price;

  const ServiceDetailsPage({
    super.key,
    required this.serviceTitle,
    required this.desc1,
    required this.desc2,
    required this.serviceDescription,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(serviceTitle),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    '4.8 (2.5k Bookings)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Check for Available Offers',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.grey,
                    height: 30,
                  ),
                  Row(
                    children: [
                      Text(
                        price,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      const Icon(Icons.access_time, size: 20),
                      const SizedBox(width: 10),
                      const Text(
                        '1 hr',
                        style: TextStyle(fontSize: 12),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF003B5F), // Background color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 5),
                        ),
                        child: const Text(
                          'Add',
                          style: TextStyle(color: Colors.white), // Text color
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras vitae ligula non leo egestas fermentum.',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildInfoContainer(
              context,
              title: 'Service Details',
              icon: Icons.notes,
              details: [
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoContainer(
              context,
              title: 'Inclusions',
              icon: Icons.error_outline,
              details: [
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ],
            ),
            const SizedBox(height: 20),
            _buildInfoContainer(
              context,
              title: 'Note',
              icon: Icons.error_outline,
              details: [
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras vitae ligula non leo egestas fermentum. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras vitae ligula non leo egestas fermentum.',
              ],
              detailsTextAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Center(
              child: Container(
                height: 120,
                width: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What we need from you',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildCircle(),
                        _buildCircle(),
                        _buildCircle(),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Lorem ipsum', style: TextStyle(fontSize: 12)),
                        Text('Lorem ipsum', style: TextStyle(fontSize: 12)),
                        Text('Lorem ipsum', style: TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildFAQSection(),
            const SizedBox(height: 20),
            _buildCustomerReviews(),
            const SizedBox(height: 20),
            _buildImageRow(),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoContainer(BuildContext context,
      {required String title,
      required IconData icon,
      required List<String> details,
      TextAlign detailsTextAlign = TextAlign.left}) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 5),
            ...details.map((detail) => Padding(
                  padding: const EdgeInsets.only(left: 20, top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.circle, size: 8),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          detail,
                          style: const TextStyle(fontSize: 10),
                          textAlign: detailsTextAlign,
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle() {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Icon(Icons.help_outline, color: Colors.blue),
              SizedBox(width: 5),
              Text('Frequently Asked Questions'),
            ],
          ),
        ),
        _buildFAQItem('1. Lorem ipsum dolor sit amet?'),
        _buildFAQItem('2. Lorem ipsum dolor sit amet?'),
        _buildFAQItem('3. Lorem ipsum dolor sit amet?'),
        _buildFAQItem('4. Lorem ipsum dolor sit amet?'),
        _buildFAQItem('5. Lorem ipsum dolor sit amet?'),
      ],
    );
  }

  Widget _buildFAQItem(String question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Expanded(child: Text(question)),
          const Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
    );
  }

  Widget _buildCustomerReviews() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: Text(
            'Customer Reviews',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 30),
          child: Row(
            children: [
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.amber),
              Icon(Icons.star, color: Colors.grey),
              SizedBox(width: 10),
              Text('4.80', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 5),
              Text('(2.5k bookings)', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildImageRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildImageContainer(),
          const SizedBox(width: 10),
          _buildImageContainer(),
          const SizedBox(width: 10),
          _buildImageContainer(),
        ],
      ),
    );
  }

  Widget _buildImageContainer() {
    return Container(
      width: 150,
      height: 150,
      color: Colors.grey[200],
    );
  }
}
