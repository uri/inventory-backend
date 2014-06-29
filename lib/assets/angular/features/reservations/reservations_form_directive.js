
var app = angular.module("mainModule");
app.directive("reservationForm", function () {
  return {
    restrict: "E",
    scope: {reservation: '='},
    templateUrl: "/assets/features/reservations/reservation_form.html",
    link: function ($scope, $ele, $attr) {
      $scope.newReservation = {};
      console.log($scope.reservation);

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
