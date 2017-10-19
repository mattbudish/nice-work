import riot from 'riot';

var choreService = riot.observable();
choreService.list = function() {
  $.get('api/chore').done(function(data) {
    choreService.trigger('chore-list-loaded', data);
  });
}

choreService.save = function(chore) {
  $.post('api/chore', chore).done(function(data) {
    choreService.trigger('chore-created', data);
  });
}

choreService.change = function(chore) {
  $.ajax({
    url: 'api/chore/' + chore.id,
    type: 'PUT',
    data: chore,
    success: function(data) {
      choreService.trigger('chore-updated', data);
    }
  });
}

riot.mixin('choreService', {
  choreService: choreService
});
