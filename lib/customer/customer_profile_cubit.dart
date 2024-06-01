import 'package:beautfy_center/core/Cache/shared_manager.dart';
import 'package:beautfy_center/customer/customer_employees_cubit.dart';
import 'package:beautfy_center/model/reservation/getallreservationdetailresponse.dart';
import 'package:beautfy_center/model/user/get_user_profile_response.dart';
import 'package:beautfy_center/services/IUserService.dart';
import 'package:beautfy_center/services/ReservationService.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomerProfileCubit extends Cubit<CustomerProfileState> {
  IUserService service;
  late SharedManager sharedManager;
  GetUserProfileResponse? data;
  GetAllReservationDetailResponseModel? reservations;
  ReservationService reservationService;
  bool isLoading = false;
  CustomerProfileCubit({ required this.reservationService ,required this.service})
      : super(CustomerProfileInitial()) {
    getUserProfile();
    getReservationsCustomerId();
  }

  getUserProfile() async {
    _changeLoading();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    int? id = prefs.getInt("user_id");

    data = await service.GetUserProfileById(id);
     await getReservationsCustomerId();
    _changeLoading();

  }
   delete(int? id) async {
  
    await reservationService.deleteReservation(id);
    
    getReservationsCustomerId();
 
  }

  getReservationsCustomerId() async {
  
     SharedPreferences prefs = await SharedPreferences.getInstance();
     int? id = prefs.getInt("user_id");
     reservations = await reservationService.getAllDetailsByCustomerId(id);
    emit(CustomerProfileLoading());
   
  }

  _changeLoading() {
    isLoading = !isLoading;

    emit(CustomerProfileLoading());
  }
}

class CustomerProfileInitial extends CustomerProfileState {}

class CustomerProfileLoading extends CustomerProfileState {}

class CustomerProfileState {}
