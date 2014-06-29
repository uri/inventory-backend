angular.module("mainModule")
.controller('CategoriesCtrl', ["$scope", "Categories", function ($scope, Categories) {
  $scope.categories = Categories.query();
  console.log($scope.categories);

  $scope.items = [{
    name: "PROJECTER",
    category: "Av",
    sub_cat: "projector",
    picture: "img!",s
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

  $scope.setItems = function (item) {
    angular.forEach(items, function (item) {
      $scope.itemNameList.push(item.name);
    })
  };

}])
