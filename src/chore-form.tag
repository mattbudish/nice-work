<chore-form>
    <div class="panel panel-primary">
        <div class="panel-heading">
            <h3 class="panel-title">Create a Chore</h3>
        </div>
        <div class="panel-body">
            <form onsubmit={ add }>
                <div class="form-group">
                    <label for="inputTitle">Title</label>
                    <input id="inputTitle" type="text" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="inputDesc">Description</label>
                    <textarea id="inputDesc" class="form-control"></textarea>
                </div>
                <div class="form-group">
                    <label for="inputPoints">Points</label>
                    <input id="inputPoints" type="number" min="0" class="form-control" required>
                </div>
                <input type="submit" class="btn btn-primary" value="Create">
            </form>
        </div>
    </div>

    <script>
      this.mixin('choreService');

      add(e) {
        var chore = {
          title: this.inputTitle.value,
          description: this.inputDesc.value,
          points: parseInt(this.inputPoints.value)
        };
        this.choreService.save(chore);
        e.target.reset();
      };
    </script>
</chore-form>
