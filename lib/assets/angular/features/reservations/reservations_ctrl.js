angular.module("mainModule").
controller("ReservationsCtrl", ["$scope", "Reservation", function ($scope, Reservation) {
  alert("Boop")
  $scope.getReservations = function () {
    $scope.reservations = Reservation.query();
  }
  $scope.getReservations();
}]);
