angular.module("mainModule")
.factory("Reservation", ["$resource", function ($resource) {
  return $resource("/mocks/reservations/:id/:action/:extended_action", {format: "json"}, {
    update: {method: "PUT", isArray: false, params: {id: "@id"} },
  })
}])
