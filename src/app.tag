import route from 'riot-route'

<app>
    <nav class="navbar navbar-default">
      <div class="container-fluid">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">{ opts.title }</a>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav">
            <li id='available-chores' class={ active: currentView.name === 'available-chores' }>
              <a href="#">Available Chores<span class="sr-only">(current)</span></a>
            </li>
            <li id='my-chores' class={ active: currentView.name === 'my-chores' }>
              <a href="#active-user">My Chores</a>
            </li>
            <li id='create-chore' class={ active: currentView.name === 'create-chore' }>
              <a href="#create">Create New Chore</a>
            </li>
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li>
              <button id="login-user-btn" type="button"
                  class={ "btn " + loginStyle() + " navbar-btn" }
                  data-toggle="modal" data-target="#login-user-mdl">
                { loginText() }
              </button>
              </li>
          </ul>
        </div><!-- /.navbar-collapse -->
      </div><!-- /.container-fluid -->
    </nav>

    <div id="viewContainer" class="container-fluid">
      <chore-box if={ currentView.tag === "chore-box" } api={ opts.api }/>
      <chore-form if={ currentView.tag === "chore-form" } api={ opts.api } />
    </div>

    <!-- Login Modal -->
    <div class="modal fade" tabindex="-1" role="dialog" id="login-user-mdl">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">Log In</h4>
          </div>
          <div class="modal-body">
            <p>
              <label>Username</label>
              <input type="text" class="form-control" placeholder="Username" id="achiever" required>
              <label>Password</label>
              <input type="password" class="form-control" id="password" required>
              Don't have an account? <a>Sign up</a>
            </p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-danger" data-dismiss="modal">
              Cancel
            </button>
            <button type="button" class="btn btn-primary" id="save-user"
                onclick={ handleLogin }>
              Save changes
            </button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <script>
      this.views = {
        'available-chores': 'chore-box',
        'my-chores': 'chore-box',
        'create-chore': 'chore-form'
      };

      this.currentView = {
        name: 'available-chores',
        tag: 'chore-box'
      };

      // Helper Methods
      this.swap = function(key) {
        var tmpTags;
        var tag = this.views[key];
        this.currentView.name = key;
        this.currentView.tag = tag;
        this.update();
      }

      this.loggedIn = function() {
        return this.opts.api.user.loggedInAs.length >= 1;
      }

      this.loginStyle = function() {
        return this.loggedIn() ? 'btn-info' : 'btn-default';
      }

      this.loginText = function() {
        return this.loggedIn() ? ('Welcome ' + this.opts.api.user.loggedInAs) : 'Log In';
      }

      this.handleLogin = function() {
        this.opts.api.user.login(this.achiever.value);
      }

      // Routes
      route('create', function() {
        this.swap('create-chore');
      }.bind(this));

      route('active-user', function() {
        this.swap('my-chores');
      }.bind(this));

      route(function() {
        this.swap('available-chores');
      }.bind(this));

      // Event Handlers
      this.opts.api.user.on('user-log-in', function(userName) {
        $('#login-user-mdl').modal('hide');
        this.update();
      }.bind(this));
    </script>
</app>
