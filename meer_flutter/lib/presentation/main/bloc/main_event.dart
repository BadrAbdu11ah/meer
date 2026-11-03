part of 'main_bloc.dart';

@freezed
sealed class MainEvent with _$MainEvent {
  // تغيير الصفحة الحالية.
  const factory MainEvent.pageChanged(int page) = _PageChanged;
}
