// angular.module("mainModule")
// .controller('CategoriesCtrl', ["$scope", "Categories", function ($scope, Categories) {
angular.module("mainModule")
.controller('CategoriesCtrl', ["$scope", function ($scope) {
  // $scope.categories = Categories.query();
  // console.log($scope.categories);

  $scope.items = [{
    name: "Laser Cutter #1",
    category: "Tools",
    sub_cat: "",
    picture: "img!",
    status: "Checked In",
    description: "Laser cutter number one cutes stuff"
  },
  {
    name: "Laser Cutter #2",
    category: "Tools",
    sub_cat: "",
    picture: "img!",
    status: "Checked Out",
    description: "Laser cutter number two cutes stuff"
    },
    {
      name: "Laser Cutter #3",
      category: "Tools",
      sub_cat: "",
      picture: "img!",
      status: "booked",
      description: "Laser cutter number three cutes stuff"}];

  $scope.itemNameList = ["PROGJECTER", "THIS NAME"]

  $scope.setItems = function (item) {
    angular.forEach(items, function (item) {
      $scope.itemNameList.push(item.name);
    })
  };

}])
