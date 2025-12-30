import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:gold/app/core/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key, required this.upiID, required this.payeeName});
  final String upiID;
  final String payeeName;
  @override
  State<ScanQRCode> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _loadBarcode();
    });
  }

  bool isLoading = true;
  String? barcodeData;

  Future _loadBarcode() async {
    isLoading = true;
    setState(() {});
    String upiDetails =
        "upi://pay?pa=${widget.upiID}&pn=${widget.payeeName}&tn=Buy Clothes&cu=INR";
    barcodeData = _getBarcodeData(Barcode.qrCode(), upiDetails);
    isLoading = false;
    setState(() {});
  }

  String _getBarcodeData(Barcode bc, String data) {
    return bc.toSvg(
      data,
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.width * 0.7,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  SvgPicture.string(
                    '''$barcodeData''',
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Scan the QR code',
                    style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700,fontSize: 20.0),
                  ),

                ],
              ),
            ),
    );
  }
}
