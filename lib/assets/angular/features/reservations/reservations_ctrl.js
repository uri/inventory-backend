angular.module("mainModule")
.controller("ReservationsCtrl", ["$scope", "Reservation", "$aside", function ($scope, Reservation, $aside) {
  var editModal = $aside({scope: $scope, contentTemplate: "/assets/features/reservations/modal.html", html:true, show: false, placement: 'left', animation: "am-fade-and-slide-left"});

  $scope.editReservation = function(reservation) {
    $scope.currentReservation = reservation;
    editModal.$promise.then(editModal.show);
  };
}])
