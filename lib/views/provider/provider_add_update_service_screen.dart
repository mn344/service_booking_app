import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../viewmodels/provider/provider_service_view_model.dart';
import '../../models/provider_service_model.dart';

class AddUpdateServiceScreen extends StatefulWidget {
  final ProviderServiceModel? service;

  const AddUpdateServiceScreen({super.key, this.service});

  @override
  State<AddUpdateServiceScreen> createState() =>
      _AddUpdateServiceScreenState();
}

class _AddUpdateServiceScreenState extends State<AddUpdateServiceScreen> {
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();

  String _mainType = "home";
  bool _isActive = true;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // UPDATE MODE → pre-fill data
    if (widget.service != null) {
      _titleCtrl.text = widget.service!.title;
      _descCtrl.text = widget.service!.description;
      _priceCtrl.text = widget.service!.price.toString();
      _mainType = widget.service!.mainType;
      _isActive = widget.service!.isActive;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Get.find<ProviderServiceViewModel>();

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF06BEE1),
        title: Text(
          widget.service == null
              ? "Add Service"
              : "Update Service",
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [

              _inputField(
                controller: _titleCtrl,
                label: "Service Title",
                validator: (v) =>
                v!.isEmpty ? "Title required" : null,
              ),

              _inputField(
                controller: _descCtrl,
                label: "Description",
                maxLines: 3,
                validator: (v) =>
                v!.isEmpty ? "Description required" : null,
              ),

              _inputField(
                controller: _priceCtrl,
                label: "Price",
                keyboardType: TextInputType.number,
                validator: (v) =>
                v!.isEmpty ? "Price required" : null,
              ),

              const SizedBox(height: 12),

              // MAIN TYPE
              DropdownButtonFormField<String>(
                value: _mainType,
                decoration: _decoration("Main Type"),
                items: const [
                  DropdownMenuItem(
                      value: "home", child: Text("Home")),
                  DropdownMenuItem(
                      value: "janitorial", child: Text("Janitorial")),
                  DropdownMenuItem(
                      value: "commercial", child: Text("Commercial")),
                ],
                onChanged: (v) => setState(() => _mainType = v!),
              ),

              const SizedBox(height: 12),

              // ACTIVE SWITCH
              SwitchListTile(
                title: const Text("Service Active"),
                value: _isActive,
                activeColor: const Color(0xFF06BEE1),
                onChanged: (v) => setState(() => _isActive = v),
              ),

              const SizedBox(height: 24),

              // SAVE BUTTON
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF06BEE1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    final model = ProviderServiceModel(
                      id: widget.service?.id ?? "",
                      title: _titleCtrl.text.trim(),
                      description: _descCtrl.text.trim(),
                      price: double.parse(_priceCtrl.text),
                      mainType: _mainType,
                      isActive: _isActive,
                    );

                    if (widget.service == null) {
                      // ADD
                      vm.addService(model);
                    } else {
                      // UPDATE
                      vm.updateService(model);
                    }

                    Get.back();
                  },
                  child: Text(
                    widget.service == null
                        ? "Add Service"
                        : "Update Service",
                    style: const TextStyle(
                        fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // COMMON INPUT WIDGET
  // =========================
  Widget _inputField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        validator: validator,
        decoration: _decoration(label),
      ),
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
