import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:http/http.dart' as http;

class DriveHelper {
  final _googleSignIn = GoogleSignIn.standard(scopes: [
    DriveApi.driveReadonlyScope,
    SheetsApi.spreadsheetsReadonlyScope,
  ]);

  DriveApi? _driveApi;
  SheetsApi? _sheetsApi;

  Future<bool> signIn() async {
    final googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential loginUser =
      await FirebaseAuth.instance.signInWithCredential(credential);

      assert(loginUser.user?.uid == FirebaseAuth.instance.currentUser?.uid);
    }

    final headers = await googleUser?.authHeaders;
    if (headers == null) {
      print("headers is null!!!");
      return false;
    }

    final client = GoogleAuthClient(headers);
    _driveApi = DriveApi(client);
    _sheetsApi = SheetsApi(client);
    return true;
  }

  Future<FileList?> fetchSpreadsheetList() async {
    if (_driveApi == null) {
      print("_driveApi is null!!!");
      return null;
    }
    FileList fileList = await _driveApi!.files.list(
      spaces: 'drive',
      q: "mimeType = 'application/vnd.google-apps.spreadsheet' and name contains 'EN1_'"  // spreadsheet
    );
    print(jsonEncode(fileList));
    return fileList;
  }

  Future<Spreadsheet> getPrivateSpreadsheet(String spreadsheetId) async {
    const fields = [
      'properties',
      'sheets.properties',
      'sheets.data.rowData.values.formattedValue',
      'sheets.data.rowData.values.textFormatRuns',
      'sheets.data.rowData.values.effectiveFormat.textFormat.bold'
    ];

    final Spreadsheet spreadsheet = await _sheetsApi!.spreadsheets.get(spreadsheetId, $fields: fields.join(','));
    return spreadsheet;
  }
}


class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}