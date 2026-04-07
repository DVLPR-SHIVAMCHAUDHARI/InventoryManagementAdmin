import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:inventory_mobile_app/core/consts/appcolors.dart';
import 'package:shimmer/shimmer.dart';

class AppDropdown<T> extends StatelessWidget {
  final String title;
  final String hint;
  final List<T> items; // ✅ generic
  final T? value; // ✅ generic
  final void Function(T?) onChanged; // ✅ generic
  final bool isRequired;

  final String Function(T)? itemLabel;

  const AppDropdown({
    super.key,
    required this.title,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
    this.isRequired = false,
    this.itemLabel, // ✅ optional
  });

  @override
  Widget build(BuildContext context) {
    // ── filter deleted items ──
    final filteredItems = items.where((e) {
      try {
        return (e as dynamic).isDeleted != 1;
      } catch (_) {
        return true;
      }
    }).toList();

    // ── match value from filtered list ──
    final matchedValue = value == null
        ? null
        : filteredItems.cast<T?>().firstWhere(
            (e) => e == value,
            orElse: () => null,
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Color(0xff383838)),
        ),
        const SizedBox(height: 6),

        DropdownButtonFormField2<T>(
          value: matchedValue, // ✅ matched from filtered list
          isExpanded: true,
          onChanged: onChanged,
          validator: isRequired
              ? (val) {
                  if (val == null) {
                    return 'Please select $title';
                  }
                  return null;
                }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.black4a),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: AppColors.black4a),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          hint: Text(
            hint,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down),
            iconEnabledColor: Colors.black,
          ),
          items: filteredItems
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e,
                  child: Text(
                    itemLabel != null ? itemLabel!(e) : e.toString(),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
              .toList(),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      ],
    );
  }
}

class AppDropdown2<T> extends StatelessWidget {
  final String title;
  final String hint;
  final List<T> items;
  final T? value;
  final String Function(T) label;
  final ValueChanged<T?> onChanged;

  const AppDropdown2({
    super.key,
    required this.title,
    required this.hint,
    required this.items,
    required this.value,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        DropdownButtonFormField2<T>(
          isExpanded: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.primaryLight,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
          value: value,
          hint: Text(hint),
          items: items
              .map((e) => DropdownMenuItem<T>(value: e, child: Text(label(e))))
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class AppDropdownShimmer extends StatelessWidget {
  final String title;

  const AppDropdownShimmer({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: 120,
            height: 14,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),

        const SizedBox(height: 6),

        /// Dropdown box shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
          ),
        ),
      ],
    );
  }
}

class NoDropdownShimmer extends StatelessWidget {
  const NoDropdownShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label shimmer

        /// Dropdown box shimmer
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
          ),
        ),
      ],
    );
  }
}

class NoLabelDropdown<T> extends StatelessWidget {
  final String hint;
  final List<T> items; // generic
  final T? value; // generic
  final void Function(T?) onChanged; // generic
  final bool isRequired;
  final String Function(T)? itemLabel;
  bool borderrequired;

  NoLabelDropdown({
    super.key,
    this.borderrequired = false,
    required this.hint,
    required this.items,
    required this.value,
    required this.onChanged,
    this.isRequired = false,
    this.itemLabel,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<T>(
      value: value,
      isExpanded: true,
      onChanged: onChanged,
      validator: isRequired
          ? (val) {
              if (val == null) {
                return 'Please select an option';
              }
              return null;
            }
          : null,
      decoration: InputDecoration(
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        enabledBorder: borderrequired
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                // borderSide: BorderSide(color: AppColors.black4a),
              )
            : null,
        focusedBorder: borderrequired
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                // borderSide: BorderSide(color: AppColors.black4a),
              )
            : null,
        errorBorder: borderrequired
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              )
            : null,
      ),
      hint: Text(
        hint,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
      ),
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      iconStyleData: const IconStyleData(
        icon: Icon(Icons.arrow_drop_down),
        iconEnabledColor: Colors.black,
      ),
      items: items
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: Text(
                itemLabel != null ? itemLabel!(e) : e.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          )
          .toList(),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.primary.withOpacity(0.2)),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}
