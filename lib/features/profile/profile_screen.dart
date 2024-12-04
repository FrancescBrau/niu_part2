import 'package:flutter/material.dart';
import 'package:niu_part2/features/profile/models/user_model.dart';
import 'package:niu_part2/features/profile/repositories/profile_repository.dart';
import 'package:niu_part2/features/profile/repositories/profile_shared_preferences.dart';
import 'package:niu_part2/features/profile/widgets/save_button';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _addressController;
  late ProfileRepository _profileRepository;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _addressController = TextEditingController();
    _initializeRepository();
  }

  Future<void> _initializeRepository() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _profileRepository = ProfileSharedPreferences(prefs);
    await _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userProfile = await _profileRepository.loadUserProfile();
    if (userProfile != null) {
      _emailController.text = userProfile.email;
      _phoneController.text = userProfile.phone;
      _addressController.text = userProfile.address;
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveUserData() async {
    final userProfile = UserProfile(
      email: _emailController.text,
      phone: _phoneController.text,
      address: _addressController.text,
    );
    await _profileRepository.saveUserProfile(userProfile);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile updated!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/images/pep.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      _emailController.text,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Contact Info',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: 'Phone',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      prefixIcon: Icon(Icons.location_on),
                    ),
                    keyboardType: TextInputType.streetAddress,
                  ),
                  const SizedBox(height: 50),
                  SaveChanges(onPressed: _saveUserData),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }
}
