
var app = angular.module("mainModule");
app.directive("reservationForm", function () {
  return {
    restrict: "E",
    templateUrl: "/assets/features/reservations/reservation_form.html",
    link: function ($scope, $ele, $attr) {
      $scope.newReservation = {};

      $scope.submitReservation = function (reservation) {
        Reservation.save(reservation, function (success) {
          $scope.errors = [];
        }, function (errors) {
          $scope.errors = errors;
        })
      }

    },
  };
});
