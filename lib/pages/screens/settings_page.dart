import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:splashh/utils/color.dart';

class SettingsPage extends StatefulWidget {
  final String username;

  SettingsPage({Key? key, required this.username}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  User? _user;
  bool _showSetPasswordFields = false;
  String _newPassword = '';
  String _confirmPassword = '';
  String _currentPassword = '';
  final GlobalKey<FormState> _currentPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _newPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmPasswordFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    setState(() {
      _user = auth.currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable the back button
        title: Text('Settings'),
        actions: [
          IconButton(
            onPressed: () {
              _logout();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              _buildSettingCard(
                title: 'Username',
                value: widget.username,
                // ivdunn loading... maatiyaarnn
              ),
              _buildSettingCard(
                title: 'Email',
                value: _user?.email ?? 'Loading...',
              ),
              
              _buildChangePasswordButton(),
              SizedBox(height: 10.0),
              if (_showSetPasswordFields) ...[
  _buildPasswordFormField(
    formKey: _currentPasswordFormKey,
    title: 'Enter Current Password',
    
    onChanged: (value) => _currentPassword = value,
  ),
  SizedBox(height: 10.0),
  _buildPasswordFormField(
    formKey: _newPasswordFormKey,
    title: 'Set Password',
    onChanged: (value) => _newPassword = value,
  ),
  SizedBox(height: 10.0),
  _buildPasswordFormField(
    formKey: _confirmPasswordFormKey,
    title: 'Confirm Password',
    onChanged: (value) => _confirmPassword = value,
  ),
  SizedBox(height: 16),
  SizedBox(
    width: 300,
    height: 40.0,
    child: ElevatedButton(
      onPressed: () {
        _resetPassword();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
        
      ),
      child: Text('Reset Password', style: TextStyle(color: AppColors.backgroundColor),),
    ),
  ),
],

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingCard({required String title, required String value}) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChangePasswordButton() {
    return SizedBox(
      width: 300.0,
      height: 40.0,
      
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            _showSetPasswordFields = !_showSetPasswordFields;
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
          
          // color: Colors.white,
        ),
        child: Text('Change Password', style: TextStyle(color: AppColors.backgroundColor),),
      ),
    );
  }

  Widget _buildPasswordFormField({
    required GlobalKey<FormState> formKey,
    required String title,
    required ValueChanged<String> onChanged,
  }) {
    return Form(
      key: formKey,
      child: TextFormField(
        onChanged: onChanged,
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter $title',
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $title';
          }
          return null;
        },
      ),
    );
  }

  void _resetPassword() async {
    if (_currentPasswordFormKey.currentState!.validate() &&
        _newPasswordFormKey.currentState!.validate() &&
        _confirmPasswordFormKey.currentState!.validate()) {
      if (_newPassword == _confirmPassword) {
        try {
          AuthCredential credential = EmailAuthProvider.credential(email: _user!.email!, password: _currentPassword);
          await _user!.reauthenticateWithCredential(credential);
          await FirebaseAuth.instance.currentUser!.updatePassword(_newPassword);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password updated successfully'),
              duration: Duration(seconds: 2),
            ),
          );
          setState(() {
            _showSetPasswordFields = false;
            _currentPassword = '';
            _newPassword = '';
            _confirmPassword = '';
          });
        } catch (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error updating password. Please try again.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }
}

// void main() {
//   runApp(MaterialApp(
//     home: SettingsPage(),
//   ));
// }
