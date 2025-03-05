import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:signals/signals_flutter.dart';
import 'package:smart_rob/core/core.dart';
import 'package:sprung/sprung.dart';

import '../../../widgets/widgets.dart';
import 'sign_up.dart';

class CountryView extends StatefulWidget {
  const CountryView({super.key});
  @override
  State<CountryView> createState() => _CountryViewState();
}

class _CountryViewState extends State<CountryView> {
  final _searchController = TextEditingController();
  final node = FocusNode();

  @override
  initState() {
    super.initState();
    node.addListener(() {
      if (node.hasFocus) {
        showCountries.value = true;
        return;
      }
      showCountries.value = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        24.vSpace,
        AppTextField(
          controller: _searchController,
          focusNode: node,
          onTapOutside: (p0) {},
          tapAction: () {
            showCountries.value = true;
            selectedCountry.value = null;
          },
          suffixIcon:
              selectedCountry.watch(context) != null
                  ? Container(
                    padding: EdgeInsets.symmetric(vertical: 12.5.relHeight),
                    child: SvgPicture.asset('assets/icons/search.svg'),
                  )
                  : null,
          prefixIconImage:
              selectedCountry.watch(context) != null
                  ? '${selectedCountry.value?.asset}'
                  : 'assets/icons/search.svg',
          onChanged: (value) {
            final query = value.toLowerCase().trim();
            if (query.isEmpty) {
              filteredList.value = countries;
              return;
            }

            filteredList.value =
                countries
                    .where((e) => e.name.toLowerCase().contains(query))
                    .toList();
          },

          hintText: 'Search Country',
        ),
        24.vSpace,
        if (showCountries.watch(context))
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              cacheExtent: MediaQuery.sizeOf(context).height * 0.5,
              itemBuilder: (context, index) {
                final country = filteredList.value[index];

                bool isFirstOfAlphabet =
                    index == 0 ||
                    country.name[0].toUpperCase() !=
                        filteredList.value[index - 1].name[0].toUpperCase();
                return Tappable(
                  type: TappableType.press,
                  onTap: () {
                    _searchController.text = country.name;
                    selectedCountry.value = (
                      name: country.name,
                      asset: country.asset,
                    );
                    showCountries.value = false;
                  },
                  child: FadeInUp(
                    curve: Sprung.overDamped,
                    child: Row(
                      children: [
                        SvgPicture.asset(country.asset, height: 30.relHeight),
                        19.hSpace,
                        Text(
                          country.name,
                          style: TextStyles.w400_14(
                            context,
                          ).copyWith(color: AppColors.black),
                        ),
                        Spacer(),
                        if (isFirstOfAlphabet)
                          Text(
                            country.name[0].toUpperCase(),
                            style: TextStyles.w600_14(
                              context,
                            ).copyWith(color: AppColors.border),
                          ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => 12.vSpace,
              itemCount: filteredList.watch(context).length,
            ),
          )
        else ...[
          Spacer(),
          AppButton(
            text: 'Continue',
            onTap:
                selectedCountry.watch(context)?.name != null
                    ? () => signUpState.value = SignUpState.basicInfo
                    : null,
            status:
                selectedCountry.watch(context)?.name != null
                    ? ABStatus.enabled
                    : ABStatus.disabled,
          ),
        ],
      ],
    );
  }
}
