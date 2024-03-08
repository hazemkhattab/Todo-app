import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../settings_provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  List<String> languageList = [
    "English",
    "عربى",
  ];

  List<String> themeList = [
    "light",
    "dark",
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    var vm = Provider.of<SettingsProvider>(context);
    var mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: theme.primaryColor,
            width: mediaQuery.width,
            height: mediaQuery.height * .22,
            padding: const EdgeInsets.symmetric(
              horizontal: 51,
              vertical: 60,
            ),
            child: Text(
              'Settings',
              style: theme.textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  local.language,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: vm.isDark() ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: CustomDropdown<String>(
                    items: languageList,
                    initialItem:
                        vm.currentLanguage == "en" ? "English" : "عربى",
                    decoration: CustomDropdownDecoration(
                      headerStyle: theme.textTheme.bodySmall!.copyWith(
                        color: vm.isDark() ? Colors.white : theme.primaryColor,
                      ),
                      listItemStyle: theme.textTheme.bodySmall!.copyWith(
                        color: vm.isDark() ? Colors.white : theme.primaryColor,
                      ),
                      expandedSuffixIcon: Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: theme.primaryColor,
                      ),
                      closedSuffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: theme.primaryColor,
                      ),
                      expandedFillColor:
                          vm.isDark() ? const Color(0xff141A2E) : Colors.white,
                      closedFillColor:
                          vm.isDark() ? const Color(0xff141A2E) : Colors.white,
                      closedBorderRadius: BorderRadius.zero,
                      closedBorder: Border.all(
                        color: theme.primaryColor,
                      ),
                      expandedBorderRadius: BorderRadius.zero,
                      expandedBorder: Border.all(
                        color: theme.primaryColor,
                      ),
                    ),
                    onChanged: (value) {
                      if (value == "English") {
                        vm.changeLanguage("en");
                      } else if (value == "عربى") {
                        vm.changeLanguage("ar");
                      }
                    },
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  local.theme,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: vm.isDark() ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: CustomDropdown<String>(
                    items: themeList,
                    initialItem: vm.isDark() ? "dark" : "light",
                    decoration: CustomDropdownDecoration(
                      headerStyle: theme.textTheme.bodySmall!.copyWith(
                        color: vm.isDark() ? Colors.white : theme.primaryColor,
                      ),
                      listItemStyle: theme.textTheme.bodySmall!.copyWith(
                        color: vm.isDark() ? Colors.white : theme.primaryColor,
                      ),
                      expandedSuffixIcon: Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: theme.primaryColor,
                      ),
                      closedSuffixIcon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: theme.primaryColor,
                      ),
                      expandedFillColor:
                          vm.isDark() ? const Color(0xff141A2E) : Colors.white,
                      closedFillColor:
                          vm.isDark() ? const Color(0xff141A2E) : Colors.white,
                      closedBorder: Border.all(
                        color: theme.primaryColor,
                      ),
                      expandedBorder: Border.all(
                        color: theme.primaryColor,
                      ),
                      closedBorderRadius: BorderRadius.zero,
                      expandedBorderRadius: BorderRadius.zero,
                    ),
                    onChanged: (value) {
                      if (value == "dark") {
                        vm.changeTheme(ThemeMode.dark);
                      } else if (value == "light") {
                        vm.changeTheme(ThemeMode.light);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
