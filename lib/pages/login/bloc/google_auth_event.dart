part of 'google_auth_bloc.dart';

@immutable
sealed class GoogleAuthEvent {}

final class SignInEvent extends GoogleAuthEvent {}

final class CheckAuthStatusEvent extends GoogleAuthEvent {}
