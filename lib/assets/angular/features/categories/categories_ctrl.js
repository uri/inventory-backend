// angular.module("mainModule")
// .controller('CategoriesCtrl', ["$scope", "Categories", function ($scope, Categories) {
angular.module("mainModule")
.controller('CategoriesCtrl', ["$scope", function ($scope) {
  $scope.items = [{
    name: "PROJECTER",
    category: "Av",
    sub_cat: "projector",
    picture: "img!",
    status: "Checked In",
    description: "The description"
  },
  {
    name: "THIS NAME",
    category: "Computers",
    sub_cat: "projector",
    picture: "img!",
    status: "Checked Out",
    description: "The description"}];

  $scope.itemNameList = ["PROGJECTER", "THIS NAME"]

  $scope.setItems = function () {
    angular.forEach(items, function (item) {
      $scope.itemNameList.push(item.name);
    })
  };

  $scope.categories_list = function () {

  };


  // angular.element(document).ready(function() {
  //     Categories.get({}, function (data) {
  //        $scope.setItems();
  //     });
  // });

}])
