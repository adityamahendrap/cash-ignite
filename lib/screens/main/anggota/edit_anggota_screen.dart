import 'package:color_log/color_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:progmob_magical_destroyers/configs/colors/colors_planet.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/mobile_api.dart';
import 'package:progmob_magical_destroyers/external/requester/mobile_api/types/base/anggota_type.dart';
import 'package:progmob_magical_destroyers/utils/helpless_util.dart';
import 'package:progmob_magical_destroyers/widgets/app_bar_with_back_button.dart';
import 'package:progmob_magical_destroyers/widgets/app_snack_bar.dart';
import 'package:progmob_magical_destroyers/widgets/full_width_button_bottom_bar.dart';
import 'package:progmob_magical_destroyers/widgets/input/date_input.dart';
import 'package:progmob_magical_destroyers/widgets/input/phone_number_input.dart';
import 'package:progmob_magical_destroyers/widgets/input/text_input.dart'
    as input;
import 'package:progmob_magical_destroyers/widgets/twin_buttons.dart';
import 'package:progmob_magical_destroyers/widgets/wrapper/bottom_sheet_fit_content_wrapper.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditAnggotaScreen extends StatefulWidget {
  final Anggota anggota;
  final Function(Anggota) updateAnggotaStateCallback;

  const EditAnggotaScreen({
    Key? key,
    required this.anggota,
    required this.updateAnggotaStateCallback,
  }) : super(key: key);

  @override
  State<EditAnggotaScreen> createState() => EditAnggotaScreenState();
}

class EditAnggotaScreenState extends State<EditAnggotaScreen> {
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _registrationController = TextEditingController();

  final MobileApiRequester _apiRequester = MobileApiRequester();

  String? _tempSelectedBirthday;
  String? _selectedBirthday = null;
  PhoneNumber number = PhoneNumber(isoCode: 'ID');
  bool _isValidPhoneNumber = true;
  late bool _statusAnggota;

  void onPhoneNumberValidated(bool value) {
    _isValidPhoneNumber = value;
  }

  void _showBirthdayDatePicker() {
    FocusManager.instance.primaryFocus?.unfocus();
    bottomSheetFitContentWrapper(
      context: context,
      content: _birthdayDatePicker(),
    );
  }

  String? _checkName(String? value) {
    if (value!.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _checkAddress(String? value) {
    if (value!.isEmpty) {
      return 'Address is required';
    }
    return null;
  }

  String? _checkBirthday() {
    if (_selectedBirthday == null) {
      return 'Birtday is required';
    }
    return null;
  }

  String? _checkRegistrationNumber(String? value) {
    if (value!.isEmpty) {
      return 'Nomor induk is required';
    }
    if (int.tryParse(value) == null) {
      return 'Nomor induk must be a number';
    }
    return null;
  }

  String? _checkPhoneNumber() {
    if (_phoneNumberController.text.isEmpty) {
      return 'Phone number is required';
    }
    return null;
  }

  bool _validateInput() {
    return _checkName(_nameController.text) == null &&
        _checkAddress(_addressController.text) == null &&
        _checkRegistrationNumber(_registrationController.text) == null &&
        _checkBirthday() == null &&
        _checkPhoneNumber() == null &&
        _isValidPhoneNumber;
  }

  void save() async {
    if (!_validateInput()) {
      AppSnackBar.error("Failed", "Please fill the form correctly");
      return;
    }

    try {
      EasyLoading.show();
      clog.debug('status anggota: ${_statusAnggota}');
      await _apiRequester.updateAnggota(
        id: widget.anggota.id,
        nomorInduk: int.parse(_registrationController.text),
        nama: _nameController.text,
        alamat: _addressController.text,
        tglLahir: _selectedBirthday!,
        telepon: _phoneNumberController.text,
        status: _statusAnggota,
      );
      widget.updateAnggotaStateCallback(
        Anggota(
          id: widget.anggota.id,
          nomorInduk: int.parse(_registrationController.text),
          nama: _nameController.text,
          alamat: _addressController.text,
          tglLahir: _selectedBirthday!,
          telepon: _phoneNumberController.text,
          statusAktif: _statusAnggota,
        ),
      );
      Get.back();
      AppSnackBar.success('Success', 'Anggota updated successfully!');
    } on DioException catch (e) {
      if (e.response!.data['message']
          .contains("Integrity constraint violation")) {
        AppSnackBar.error("Failed", "Nomor induk sudah digunakan");
        return;
      }
      HelplessUtil.handleApiError(e);
    } finally {
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.anggota.nama;
    _addressController.text = widget.anggota.alamat;
    _phoneNumberController.text = widget.anggota.telepon;
    _registrationController.text = widget.anggota.nomorInduk.toString();
    _selectedBirthday = widget.anggota.tglLahir;
    _tempSelectedBirthday = widget.anggota.tglLahir;
    _statusAnggota = widget.anggota.statusAktif!;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _birthdayController.dispose();
    _phoneNumberController.dispose();
    _addressController.dispose();
    _registrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _birthdayController.text = _selectedBirthday ?? 'yyyy-MM-dd';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBarWithBackButton(title: 'Edit Anggota', centerTitle: true),
      body: Stack(
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  Form(
                    child: Column(
                      children: [
                        input.TextInput(
                          title: 'Nomor Induk',
                          hintText: 'Nomo Induk',
                          prefixIcon: Icons.confirmation_number_outlined,
                          controller: _registrationController,
                          validator: _checkRegistrationNumber,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 20),
                        input.TextInput(
                          title: 'Name',
                          hintText: 'Name',
                          prefixIcon: Icons.person_outline,
                          controller: _nameController,
                          validator: _checkName,
                        ),
                        SizedBox(height: 20),
                        input.TextInput(
                          title: 'Address',
                          hintText: 'Address',
                          prefixIcon: Icons.location_on_outlined,
                          controller: _addressController,
                          validator: _checkAddress,
                        ),
                        SizedBox(height: 20),
                        DateInput(
                          controller: _birthdayController,
                          onTap: _showBirthdayDatePicker,
                        ),
                        SizedBox(height: 20),
                        PhoneNumberInput(
                          controller: _phoneNumberController,
                          initialValue: number,
                          onInputValidated: onPhoneNumberValidated,
                        ),
                        SizedBox(height: 10),
                        _toggleStatusAnggota(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          FullWidthButtonBottomBar(
            context: context,
            text: 'Save',
            onPressed: () => save(),
          )
        ],
      ),
    );
  }

  Widget _birthdayDatePicker() {
    return Column(
      children: [
        SfDateRangePicker(
          backgroundColor: Colors.white,
          // view: DateRangePickerView.century,
          initialSelectedDate: _selectedBirthday != null
              ? DateFormat('yyyy-MM-dd').parse(_selectedBirthday!)
              : null,
          initialDisplayDate: _selectedBirthday != null
              ? DateFormat('yyyy-MM-dd').parse(_selectedBirthday!)
              : null,
          maxDate: DateTime.now(),
          headerStyle: DateRangePickerHeaderStyle(
            textAlign: TextAlign.center,
            backgroundColor: Colors.white,
            textStyle: TextStyle(
              color: ColorPlanet.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          selectionMode: DateRangePickerSelectionMode.single,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            _tempSelectedBirthday = DateFormat('yyyy-MM-dd').format(args.value);
          },
        ),
        SizedBox(height: 10),
        TwinButtons(
          textOkButton: "OK",
          textCancelButton: "Cancel",
          onPressedOkButton: () {
            clog.debug(_tempSelectedBirthday!.toString());
            _birthdayController.text = _tempSelectedBirthday!;
            _selectedBirthday = _tempSelectedBirthday;
            Get.back();
          },
          onPressedCancelButton: () {
            Get.back();
          },
        ),
      ],
    );
  }

  Widget _toggleStatusAnggota() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Status Aktif",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Switch(
          value: _statusAnggota,
          activeColor: ColorPlanet.primary,
          onChanged: (bool value) {
            setState(() {
              _statusAnggota = value;
              print(_statusAnggota ? 'active' : 'inactive');
            });
          },
        ),
      ],
    );
  }
}
