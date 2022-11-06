import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:googleapis/drive/v3.dart';

import '../googlesheet/drive_helper.dart';
import '../googlesheet/sheet_helper.dart';

class PickPage extends StatefulWidget {
  const PickPage({Key? key}) : super(key: key);

  @override
  State<PickPage> createState() => _PickPageState();
}

class _PickPageState extends State<PickPage> {
  late double _deviceHeight, _deviceWidth;
  late DriveHelper _driveHelper;
  FileList? _fileList;

  @override
  void initState() {
    super.initState();

    _driveHelper = GetIt.instance.get<DriveHelper>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose a spreadsheet"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _fileListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fileListView() {
    return FutureBuilder(
      future: _driveHelper!.fetchSpreadsheetList(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          _fileList = snapshot.data;
          return _sheetList();
        } else {
          return SizedBox(
            height: _deviceHeight,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _sheetList() {
    List<File> files = _fileList!.files!;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true, // limit height
      primary: false, // disable scrolling
      itemCount: files.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () async {
            EasyLoading.instance.maskType = EasyLoadingMaskType.black;
            EasyLoading.show(status: 'loading...');
            print("Load ${files[index].name}");
            await SheetHelper.fetchSpreadsheet(files[index].id!, true);
            setState(() {});
            EasyLoading.dismiss();
          },
          title: Text(files[index].name!),
          subtitle: Text(files[index].id!),
        );
      },
    );
  }
}
