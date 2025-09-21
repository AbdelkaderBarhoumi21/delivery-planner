// lib/features/shop/screens/order/models/trip_track_args.dart
class TripTrackArgs {
  final String tripId;
  final List<String> orderIds;
  const TripTrackArgs({required this.tripId, required this.orderIds});
}
