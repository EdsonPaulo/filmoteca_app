import 'package:filmoteca_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

Map<String, String> sortByOptions = {
  'popularity.desc': 'Mais Popular',
  'popularity.asc': 'Menos Popular',
  'release_date.desc': 'Mais Recente',
  'release_date.asc': 'Mais Antigo',
  'vote_count.desc': 'Mais Votado',
  'vote_count.asc': 'Menos Votado',
  'vote_average.desc': 'Avalição Alta',
  'vote_average.asc': 'Avalição Baixa',
  'original_title.asc': 'Título A-Z',
  'original_title.desc': 'Título Z-A',
};

class SortByDropdown extends StatefulWidget {
  final ValueChanged<String> onSortChanged;
  final String selectedSortBy;

  const SortByDropdown({
    super.key,
    required this.selectedSortBy,
    required this.onSortChanged,
  });

  @override
  _SortByDropdownState createState() => _SortByDropdownState();
}

class _SortByDropdownState extends State<SortByDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.selectedSortBy,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: AppColors.primaryColor, // Cor do ícone
      ),
      dropdownColor: AppColors.darkSecondaryColor,
      hint: const Text('Selecione...',
          style: TextStyle(
            color: AppColors.darkSecondaryColor,
            fontSize: 12,
          )),
      onChanged: (String? newValue) {
        widget.onSortChanged(newValue!);
      },
      items: sortByOptions.entries.map<DropdownMenuItem<String>>(
        (entry) {
          return DropdownMenuItem<String>(
            value: entry.key,
            child: Text(entry.value,
                style: const TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14,
                )),
          );
        },
      ).toList(),
    );
  }
}
