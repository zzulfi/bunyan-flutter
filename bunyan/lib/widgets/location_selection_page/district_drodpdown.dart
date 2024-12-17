import 'package:flutter/material.dart';
import 'package:bunyan/main.dart';
import 'package:provider/provider.dart';

class DistrictDropdown extends StatefulWidget {
  const DistrictDropdown({super.key});

  @override
  _DistrictDropdownState createState() => _DistrictDropdownState();
}

class _DistrictDropdownState extends State<DistrictDropdown> {
  // List of Kerala districts
  final List<String> _districts = [
    'Alappuzha',
    'Ernakulam',
    'Idukki',
    'Kannur',
    'Kasaragod',
    'Kollam',
    'Kottayam',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Pathanamthitta',
    'Thiruvananthapuram',
    'Thrissur',
    'Wayanad',
  ];

  String? _selectedDistrict;
  bool _isDropdownOpen = false;
  late OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isDropdownOpen = !_isDropdownOpen;
          });
          if (_isDropdownOpen) {
            _showDropdownMenu();
          } else {
            _removeDropdownMenu();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // Changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (Provider.of<AppState>(context).getUserDetails['district'] ?? '') == ''
                    ? 'Select District'
                    : Provider.of<AppState>(context).getUserDetails['district'] ?? '',
                style: TextStyle(
                  color: _selectedDistrict == null
                      ? const Color(0xFFC8C8C8)
                      : const Color(0xFF0CAF60),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              const Icon(
                Icons.arrow_drop_down,
                color: Color(0xFF9C9A9A),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdownMenu() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox =
          context.findRenderObject() as RenderBox; // Safe cast to RenderBox
      final size = renderBox.size;
      final offset = renderBox.localToGlobal(Offset.zero);

      _overlayEntry = OverlayEntry(
        builder: (context) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _isDropdownOpen = false;
              });
              _removeDropdownMenu();
            },
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(color: Colors.transparent),
                ),
                Positioned(
                  width: size.width,
                  left: offset.dx,
                  top: offset.dy + size.height,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      height: 200, // Set a fixed height for the dropdown menu
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        children: _districts.map((district) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDistrict = district;
                                _isDropdownOpen = false;
                              });
                              // Set the district in setUserDetails
                              Provider.of<AppState>(context, listen: false)
                                  .setUserDetails(district: _selectedDistrict);
                              _removeDropdownMenu();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.withOpacity(0.2),
                                  ),
                                ),
                              ),
                              child: Text(
                                district,
                                style: TextStyle(
                                  color: _selectedDistrict == district
                                      ? const Color(0xFF0CAF60)
                                      : const Color(0xFF333333),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

      Overlay.of(context).insert(_overlayEntry);
    });
  }

  void _removeDropdownMenu() {
    if (_overlayEntry.mounted) {
      _overlayEntry.remove();
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Remove the dropdown menu when the widget is disposed
    if (_isDropdownOpen) {
      _removeDropdownMenu();
    }
  }
}
