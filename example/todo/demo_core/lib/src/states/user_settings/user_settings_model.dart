import '../../models/theme.dart';

class UserSettingsModel {
  const UserSettingsModel(this.theme, {this.isLoading = false});

  final Theme theme;
  final bool isLoading;
}
