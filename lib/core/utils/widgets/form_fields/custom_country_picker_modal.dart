import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart' as cp;
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/colors/styles.dart';

import '../../../shared/blocs/main_app_bloc.dart';
import '../../models/country.dart';

class CustomCountryPickerModal extends StatefulWidget {
  final String? selectedCountryCode;
  final ValueChanged<Country> onSelect;

  const CustomCountryPickerModal({
    super.key,
    this.selectedCountryCode,
    required this.onSelect,
  });

  static void show(
    BuildContext context, {
    String? selectedCountryCode,
    required ValueChanged<Country> onSelect,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CustomCountryPickerModal(
        selectedCountryCode: selectedCountryCode,
        onSelect: onSelect,
      ),
    );
  }

  @override
  State<CustomCountryPickerModal> createState() => _CustomCountryPickerModalState();
}

class _CustomCountryPickerModalState extends State<CustomCountryPickerModal> {
  final List<cp.Country> _allCountries = cp.CountryService().getAll();
  List<cp.Country> _filteredCountries = [];
  final TextEditingController _searchController = TextEditingController();

  final List<String> _favorites = [
    'SA', 'AE', 'KW', 'QA', 'OM', 'BH', 'EG', 'JO', 
    'IQ', 'LB', 'SY', 'YE', 'PS', 'LY', 'SD', 'DZ', 'MA', 'TN'
  ];

  @override
  void initState() {
    super.initState();
    _filteredCountries = _allCountries;
  }

  void _onSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = _allCountries;
      } else {
        _filteredCountries = _allCountries.where((country) {
          final localizedName = cp.CountryLocalizations.of(context)
              ?.countryName(countryCode: country.countryCode)
              ?.toLowerCase() ??
              country.name.toLowerCase();
          return localizedName.contains(query.toLowerCase()) ||
              country.phoneCode.contains(query);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = mainAppBloc.isArabic;
    final countryLocalizations = cp.CountryLocalizations.of(context);

    // Filtered lists
    final favoriteCountries = _filteredCountries
        .where((c) => _favorites.contains(c.countryCode))
        .toList();
    
    // Sort favorites to ensure SA is first, then rest
    favoriteCountries.sort((a, b) {
      if (a.countryCode == 'SA') return -1;
      if (b.countryCode == 'SA') return 1;
      return 0;
    });

    final otherCountries = _filteredCountries
        .where((c) => !_favorites.contains(c.countryCode))
        .toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isArabic ? 'اختر الدولة' : 'Select Country',
                  style: GoogleFonts.ibmPlexSansArabic(fontSize: 18, fontWeight: FontWeight.w600).copyWith(
                    color: ColorsApp.kPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearch,
              decoration: InputDecoration(
                hintText: isArabic ? 'ابحث عن دولتك' : 'Search your country',
                hintStyle: GoogleFonts.ibmPlexSansArabic(fontSize: 14, fontWeight: FontWeight.w400),
                prefixIcon: const Icon(Icons.search, color: ColorsApp.KorangePrimary),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: ColorsApp.KorangePrimary, width: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              children: [
                if (favoriteCountries.isNotEmpty) ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      isArabic ? 'الدول المقترحة' : 'Suggested Countries',
                      style: GoogleFonts.ibmPlexSansArabic(fontSize: 12, fontWeight: FontWeight.w400).copyWith(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ...favoriteCountries.map((c) => _buildCountryTile(c, countryLocalizations)),
                  const Divider(indent: 16, endIndent: 16),
                ],
                ...otherCountries.map((c) => _buildCountryTile(c, countryLocalizations)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountryTile(cp.Country cpCountry, cp.CountryLocalizations? localizations) {
    final countryName = localizations?.countryName(countryCode: cpCountry.countryCode) ?? cpCountry.name;
    final isSelected = widget.selectedCountryCode == cpCountry.countryCode;

    final countryModel = Country(
      code: cpCountry.countryCode,
      dialCode: '+${cpCountry.phoneCode}',
      name: cpCountry.name,
    );

    return ListTile(
      onTap: () {
        widget.onSelect(countryModel);
        Navigator.pop(context);
      },
      leading: Text(
        countryModel.flagEmoji,
        style: const TextStyle(fontSize: 24),
      ),
      title: Text(
        countryName,
        style: GoogleFonts.ibmPlexSansArabic(fontSize: 14, fontWeight: FontWeight.w500).copyWith(
          color: isSelected ? ColorsApp.KorangePrimary : ColorsApp.kPrimary,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '+${cpCountry.phoneCode}',
            style: GoogleFonts.ibmPlexSansArabic(fontSize: 12, fontWeight: FontWeight.w400).copyWith(
              color: Colors.grey[600],
            ),
          ),
          if (isSelected) ...[
            const SizedBox(width: 8),
            const Icon(Icons.check_circle, color: ColorsApp.KorangePrimary, size: 20),
          ],
        ],
      ),
    );
  }
}

