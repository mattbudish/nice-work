import riot from 'riot';

export var user = (() => {
  var user = riot.observable();

  user.loggedInAs = "";

  user.login = function(userName) {
    user.loggedInAs = userName;
    user.trigger('user-log-in', userName);
  }

  return user;
})();
