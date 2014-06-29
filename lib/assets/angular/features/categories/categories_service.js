angular.module("mainModule")
.factory("Category", ["$resource", function ($resource) {
    return $resource("/api/categories", {format: 'json'}, {

    });
}]);
