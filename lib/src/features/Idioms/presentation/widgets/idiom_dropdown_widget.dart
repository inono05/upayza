import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upayza/generated/assets.gen.dart';
import 'package:upayza/src/features/Idioms/presentation/controllers/idiom_controller.dart';
import 'package:upayza/src/shared/components/app_title.dart';
import 'package:upayza/src/shared/components/forms/app_dropdown_field.dart';
import 'package:upayza/src/shared/components/forms/app_form_prefix_icon.dart';
import 'package:upayza/src/shared/states/locale/app_locale_state.dart';

class IdiomDropdownWidget extends ConsumerStatefulWidget {
  const IdiomDropdownWidget({super.key});

  @override
  ConsumerState createState() => _IdiomDropdownWidgetState();
}

class _IdiomDropdownWidgetState extends ConsumerState<IdiomDropdownWidget> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> data = [
      'fr',
      'en',
      'es',
    ];

    final locale = ref.watch(appLocaleStateProvider).languageCode;

    /*final idiomValue = data.firstWhere((e) {
      return e.title == ref.watch(idiomControllerProvider);
    });*/

    /*String selectedValue = AppHelpers.chosenIdiom(
      context: context,
      idiomCode: ref.watch(idiomControllerProvider),
    );*/
    return AppDropdownField(
      hintText: 'Choose Your Idiom',
      icon: AppFormIcon(icon: Assets.icons.translateLanguage.svg()),
      items: data.map((e) {
        return DropdownMenuItem<String>(
          value: e,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTitle(title: e.capitalizeFirst),
              (locale.contains(e.toLowerCase()))
                  ? const Icon(Icons.check_circle_outline_outlined)
                  : const SizedBox.shrink()
            ],
          ),
        );
      }).toList(),
      value: ref.watch(idiomControllerProvider),
      searchDropdownController: searchController,
      onChanged: (value) {
        final String idiom = value as String;
        final localeState = appLocaleStateProvider;
        ref.read(localeState.notifier).setLocale(localeCode: idiom);
        ref.read(idiomControllerProvider.notifier).setIdiom(value);
      },
      searchMatchFn: (item, searchValue) {
        return item.value.toLowerCase().contains(
              searchValue.toLowerCase(),
            );
      },
    );
  }
}
