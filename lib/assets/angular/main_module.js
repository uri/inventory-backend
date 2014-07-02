
angular.module('momentjs', []).factory("moment", ["$window", function ($window) {
  if (typeof $window.moment === 'undefined') {
    throw 'moment.js not found.';
  }
  return $window.moment;
}])

angular.module('mainModule', ['mgcrea.ngStrap','ngAnimate', 'ngResource', 'ngSanitize', 'momentjs']);
