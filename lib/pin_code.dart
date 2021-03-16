import 'package:fl_pin_code/styles.dart';
import 'package:flutter/material.dart';

class PinCode extends StatefulWidget {
  /// Number of Pin fields
  final int numberOfFields;

  /// Field width
  final double fieldWidth;

  /// Text style on each field
  final TextStyle style;

  /// Text keyboard type on fields
  final TextInputType keyboardType;

  /// Style on each field
  final PinCodeStyle fieldStyle;

  /// is obscure text?
  final bool isObscure;

  /// Called when pin changes its fields
  final ValueChanged<String>? onChanged;

  /// Called when pin is completed
  final ValueChanged<String>? onCompleted;

  PinCode(
      {Key? key,
      required this.numberOfFields,
      required this.fieldWidth,
      required this.style,
      required this.fieldStyle,
      this.keyboardType = TextInputType.number,
      this.isObscure = false,
      this.onChanged,
      this.onCompleted});

  @override
  _PinCodeState createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  late List<String> _pinCode;
  late List<TextEditingController?> _textControllers;
  late List<FocusNode?> _focusNodes;
  late List<Widget> _pinFields;

  @override
  void initState() {
    super.initState();

    _textControllers = List<TextEditingController?>.filled(
        widget.numberOfFields, null,
        growable: false);

    _focusNodes =
        List<FocusNode?>.filled(widget.numberOfFields, null, growable: false);

    _pinCode = List.generate(widget.numberOfFields, (index) => '');

    _pinFields = List.generate(
        widget.numberOfFields, (index) => _buildTextField(context, index));
  }

  @override
  void dispose() {
    super.dispose();
    _textControllers
        .forEach((TextEditingController? controller) => controller?.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _pinFields,
      ),
    );
  }

  Widget _buildTextField(BuildContext context, int index) {
    if (_focusNodes[index] == null) {
      _focusNodes[index] = new FocusNode();
    }

    if (_textControllers[index] == null) {
      _textControllers[index] = new TextEditingController();
    }

    return Container(
      width: widget.fieldWidth,
      child: TextField(
        textAlign: TextAlign.center,
        maxLength: 1,
        maxLines: 1,
        keyboardType: widget.keyboardType,
        style: widget.style,
        autofocus: false,
        obscureText: widget.isObscure,
        controller: _textControllers[index],
        focusNode: _focusNodes[index],
        decoration: InputDecoration(
          counterText: "",
          border: getInputDecoration(widget.fieldStyle),
        ),
        onChanged: (String value) {
          if (value.trim().isEmpty) {
            if (index == 0) return;

            _focusNodes[index]!.unfocus();
            _focusNodes[index - 1]!.requestFocus();
          }

          setState(() {
            _pinCode[index] = value;
          });

          if (value.trim().isNotEmpty) {
            _focusNodes[index]!.unfocus();
          }

          if (index + 1 != widget.numberOfFields && value.trim().isNotEmpty) {
            FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
          }

          String currentPin = '';
          _pinCode.forEach((element) => currentPin += element);

          // if there is no any null value, then pin code is completed, automatically
          // call onCompleted callback
          if (!_pinCode.contains(null) &&
              !_pinCode.contains('') &&
              currentPin.length == widget.numberOfFields) {
            widget.onCompleted!(currentPin);
          }

          // call onChanged callback
          if (widget.onChanged != null) {
            widget.onChanged!(currentPin);
          }
        },
      ),
    );
  }

  InputBorder getInputDecoration(PinCodeStyle style) {
    switch (style) {
      case PinCodeStyle.box:
        return OutlineInputBorder(
            borderSide: BorderSide(width: widget.fieldWidth));
      case PinCodeStyle.underline:
      default:
        return UnderlineInputBorder(
            borderSide: BorderSide(width: widget.fieldWidth));
    }
  }
}
