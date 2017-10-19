<chore-box>
    <div class="panel panel-default">
        <div class="panel-heading">
            <h3 class="panel-title">Available Chores</h3>
        </div>
        <div class="panel-body">
            <chore-list api={ opts.api }></chore-list>
        </div>
    </div>
</chore-box>

<chore-list>
    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
        <div each={ chore in chores } class="panel panel-default">
        <chore chore={ chore } id={ chore.id } ></chore>
        </div>
    </div>

    <div class="modal fade" tabindex="-1" role="dialog" id="complete-chore-mdl">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">Complete Chore</h4>
          </div>
          <div class="modal-body">
            <p>Chore updated successfully!</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Ok</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <script>
      this.mixin('choreService');
      this.chores = [];

      this.on('before-mount', function() {
        this.choreService.list();
      }.bind(this));

      this.choreService.on('chore-list-loaded', function(data) {
        this.chores = data;
        this.update();
        $('.collapse').collapse();
      }.bind(this));

      this.choreService.on('chore-created', function(chore) {
        this.chores.push(chore);
        this.update();
      }.bind(this));

      this.choreService.on('chore-updated', function(chore) {
        var delidx = this.chores.findIndex(function(element) {
          return chore.id === element.id;
        });

        this.chores.splice(delidx, 1);
        this.update();
        $('#complete-chore-mdl').modal('show');
      }.bind(this));
    </script>
</chore-list>

<chore>
    <div class="panel-heading" role="tab" id={ "heading_" + opts.id }>
        <h4 class="panel-title">
          <div class="row">
            <div class="col-md-6">
              <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href={ "#collapse_" + opts.id } aria-expanded="false" aria-controls={ "collapse_" + opts.id }>
                  { opts.chore.title }
              </a>
            </div>
            <div class="col-md-6 text-right">
              { opts.chore.points }
            </div>
          </div>
        </h4>
    </div>
    <div id={ "collapse_" + opts.id } class="panel-collapse collapse in" role="tabpanel" aria-labelledby={ "heading_" + opts.id }>
        <div class="panel-body">
          <p>
            { opts.chore.description }
          </p>
          <button type="button" class="btn btn-primary" id="dibs-chore-btn"
            onclick={ callDibs }
            disabled={ disabled: disabled() }>
            Call dibs
          </button>
          <button type="button" class="btn btn-success" id="complete-chore-btn"
            onclick={ completeChore }
            disabled={ disabled: disabled() }>
            Complete chore
          </button>
        </div>
    </div>

    <script>
      this.mixin('choreService');

      disabled() {
        var result = this.parent.opts.api.user.loggedInAs.length < 1;
        return result;
      }

      completeChore(e) {
        var chore = opts.chore;
        chore.completedBy = this.parent.opts.api.user.loggedInAs;

        this.choreService.change(chore);
      }

      callDibs(e) {
        var chore = opts.chore;
        chore.assignedTo = this.parent.opts.api.user.loggedInAs;

        this.choreService.change(chore);
      }

    </script>
</chore>
