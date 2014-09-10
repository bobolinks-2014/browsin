/** @jsx React.DOM */
var MediaItem = React.createClass({
  render: function() {
  return (
          <div className='panel panel-views'>
            <div className='panel-heading height-extend'>
              <div className='col-md-7 col-sm-7 col-xs-7'>
              <span className='ratings pull-left' data-toggle='tooltip' title="Movie Rating">{this.props.rating}</span>
              <h4 className='panel-title small-title'>
                <a data-toggle='collapse' data-parent='#media-items' href={"#" + this.props.imdb_id}>
                  {this.props.title}
                </a>
              </h4>
              </div>
                <div className='col-md-5 col-sm-5 col-xs-5'>
                <span className='services'>
                  {this.props.services.map(function(result, index) {
                    return <a key={index} href={"http://"+Vendor.find(result) + this.props.title} target='blank' data-toggle='tooltip' title="Watch" className={result + " sprite-size"}></a>;
                  }.bind(this))}
                </span>
                <span className='genres hidden-xs' key={this.props.id}>
                  {this.props.genres.map(function(result, index) {
                    return <a key={index} id={result} title={result} className={result.toLowerCase() + ' search-item sprite-size hand-cursor'} data-toggle='tooltip'></a>;
                  })}
                </span>
                <span className='delete-media-item small-trash' data-toggle='tooltip' title='Click to hide'>
                </span>
                </div>
            </div>
            <div id={this.props.imdb_id} className='panel-collapse collapse'>
              <div className='panel-body'>
                {this.props.synopsis}
                <span className='actors'>
                  See more from:
                    {this.props.actors.map(function(result, index) {
                      return <a key={index} id={result.name} className='actor search-item'> {result.name} </a>
                     })}
                  <span className='runtime'>
                    / Runtime: {this.props.runtime}
                  </span>
                </span>
              </div>
            </div>
          </div>
      );
  }
});

var MediaList = React.createClass({
  render: function () {
    var mediaNodes = this.props.mediaItems.map(function (mediaItem, index) {
      return (
        <MediaItem id={mediaItem.id} imdb_id={mediaItem.imdb_id} rating={mediaItem.rating} synopsis={mediaItem.synopsis} title={mediaItem.title} services={mediaItem.service_icons} runtime={mediaItem.run_time} genres={mediaItem.genre_icons} actors={mediaItem.actors} key={index} />
      );
    });

    return (
        <div className='panel-group media-items' id='media-items'>
          {mediaNodes}
        </div>
    );
    }
});

var renderList = function (list) {
  React.renderComponent(
    <MediaList mediaItems={list} />,
    document.getElementById('search-results-area')
 );
};

var SearchBar = React.createClass({
  render: function() {
    return (
      <div className='col-md-12'>
        <form id='main-search-form' className='navbar-form col-md-6 col-md-offset-3' role='search'>
          <div className='form-group'>
            <input id='search-bar-value' type='text' className='form-control' placeholder='ex: I have 30 minutes for comedy' />
          </div>
        </form>
      </div>
    );
  }
});

var renderSearchBar = function() {
  React.renderComponent(
    <SearchBar />,
    document.getElementById('search-area')
  );
}

var userLoggedIn = function(user) {
  React.renderComponent(
    <UserArea user={user} />,
    document.getElementById('login-area')
  );
}

var userLoggedOut = function() {
  React.renderComponent(
    <UserLoginArea />,
    document.getElementById('search-area')
  );
}

var UserArea = React.createClass({
  render: function() {
    return (
      <div className='userArea'>
        <a className='logout top-button pull-right'>log out</a>
        <a className='profile top-button pull-right' data-target='#profile-page' data-toggle='modal'>{this.props.user}</a>
      </div>
    );
  }
});

var UserLoginArea = React.createClass({
  render: function() {
    return (
      <div className='col-md-offset-4 col-sm-offset-3'>
        <form className='form-inline' role='form' id='login-form'>
          <div className='form-group'>
            <input type="email" className="form-control" id="email" name="email" placeholder="Enter email"></input>
            <input type="password" className="form-control" id="password" name="password" placeholder="Password"></input>
          </div>
          <button type="submit" className="btn" id="sign-in-button">Sign in</button>
        </form>
      </div>
    );
  }
});
