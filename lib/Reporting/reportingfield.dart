import 'package:flutter/material.dart';

class ReportingTypeField extends StatelessWidget {

  final String value;

  final ValueChanged<String?> onChanged;

  const ReportingTypeField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField<String>(

      value: value,
      decoration: InputDecoration(
        labelText: 'Jenis Laporan',
        labelStyle: const TextStyle(
          fontSize: 12,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: Color(0xff2457A6),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down,
      ),

      items: const [
        DropdownMenuItem<String>(
          value: 'Barang Masuk',
          child: Text(
            'Barang Masuk',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Barang Keluar',
          child: Text(
            'Barang Keluar',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}

class ReportingPeriodField extends StatelessWidget {

  final String value;
  final ValueChanged<String?> onChanged;

  const ReportingPeriodField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: 'Periode',
        labelStyle: const TextStyle(
          fontSize: 12,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          borderSide: BorderSide(
            color: Color(0xff2457A6),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down,
      ),
      items: const [
        DropdownMenuItem<String>(
          value: 'Bulan Ini',
          child: Text(
            'Bulan Ini',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Bulan Lalu',
          child: Text(
            'Bulan Lalu',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Tahun Ini',
          child: Text('Tahun Ini',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
        DropdownMenuItem<String>(
          value: 'Custom',
          child: Text('Custom',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ],
      onChanged: onChanged,
    );
  }
}


class ReportingDateField extends StatelessWidget {
  final String label;
  final DateTime value;
  final ValueChanged<DateTime> onChanged;

  const ReportingDateField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: value,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (picked != null) {
          onChanged(
            picked,
          );
        }
      },

      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),

          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),

          suffixIcon: const Icon(
            Icons.calendar_month,
            size: 18,
          ),
        ),

        child: Text(
          '${value.year.toString().padLeft(4, '0')}-'
          '${value.month.toString().padLeft(2, '0')}-'
          '${value.day.toString().padLeft(2, '0')}',

          style:
          const TextStyle(
            fontSize: 12,
            color:
            Colors.black,
          ),
        ),
      ),
    );
  }
}