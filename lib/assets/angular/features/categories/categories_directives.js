angular.module("mainModule")
.directive('item', function () {
  return {
    restrict: 'A',
    scope: {
      item: '='
    },
    templateUrl: '/assets/features/categories/item.html',

    link: function ($scope, $ele, $attr) {
      console.log("here")
      if ($scope.item.status === "Checked Out"){
        $scope.color = "danger"
        $scope.dotColor = '#d9534f'
      }else if($scope.item.status === "booked"){
        $scope.color = "warning"
        $scope.dotColor = '#f0ad4e'
      }else{
        $scope.color = "success"
        $scope.dotColor = '#5cb85c'
      }


      $scope.modal = {
        "title": $scope.item.name,
        "content": $scope.item.description
      };
    }
  };
})
