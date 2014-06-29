angular.module("mainModule")
.factory("Categories", ["$resource", function ($resource) {
    return $resource("/categories/:id/", {format: 'json'}, {
      
    });
}]);
