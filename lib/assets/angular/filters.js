angular.module("mainModule")

.filter("dateFormat", ["moment", function (moment) {
  return function (date, format) {
    var momentDate = moment(date)
    if (!format) {
      format = 'ddd, MMM Do';
    }
    return momentDate.format(format);
  }
}])


.filter("fromNowDate", ["moment", function (moment) {
  return function (date, openWrapper, closeWrapper) {
    var momentDate = moment(date, "YYYY-MM-DD HH:mm")
    return (openWrapper || "") + momentDate.fromNow() + (closeWrapper || "");
  }
}])

.filter("calendarTime", ["moment", function (moment) {
  return function (date) {
    moment.lang('en', {
      calendar : {
          lastDay : '[Yesterday at] LT',
          sameDay : '[Today at] LT',
          nextDay : '[Tomorrow at] LT',
          lastWeek : '[Last] dddd [at] LT',
          nextWeek : 'dddd [at] LT',
          sameElse : 'ddd, MMM Do' // customize format
      }
    });
    return moment(date).calendar();
  }
}])

.filter("calendarDate", ["moment", function (moment) {
  return function (date) {
    moment.lang('en', {
      calendar : {
          lastDay : '[Yesterday]',
          sameDay : '[Today]',
          nextDay : '[Tomorrow]',
          lastWeek : '[Last] dddd',
          nextWeek : 'dddd',
          sameElse : 'ddd, MMM Do' // customize format
      }
    });
    return moment(date).calendar();
  }
}])
