/** @jsx React.DOM */
var MediaItem = React.createClass({
  render: function() {
  return (
      <div className='media-item'>
      <h1 className='title'>{this.props.title}</h1>
      <div className='icon-area'>
        <span className='platforms'>{this.props.platform}</span> | 
        <span className='runtime'>{this.props.runtime}</span> | 
        <span className='genres'>{this.props.genre}</span>
      </div>
      </div>
      );
  }
});

var MediaList = React.createClass({
  render: function () {
    var mediaNodes = this.props.mediaItems.map(function (mediaItem, index) {
        return (
            <MediaItem title={mediaItem.title} platform={mediaItem.platforms} runtime={mediaItem.runtime} genre={mediaItem.genres} key={index} />
        );
        });
    
    return (
        <div className="mediaList">
        {mediaNodes}
        </div>
    );
    }
});

var renderList = function (list) {
  React.renderComponent(
    <MediaList mediaItems={list} />,
    document.getElementById('content')
 );
};

var SearchBar = React.createClass({
  render: function() {
    return (
      <div className='col-md-12'>
        <form className='navbar-form col-md-6 col-md-offset-3' role='search'>
          <div className='form-group'>
            <input type='text' className='form-control' placeholder='ex: I have 30 minutes for comedy' />
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
        <a className='profile top-button pull-right'>{this.props.user}</a>
      </div>
    );
  }
});

var UserLoginArea = React.createClass({
  render: function() {
    return (
      <div className='col-md-12 col-md-offset-4'>
        <form className='form-inline' role='form' id='login-form'>
          <div className='form-group'>
            <label className='sr-only' for='email'>Email address</label>
              <input type="email" className="form-control" id="email" name="email" placeholder="Enter email" />
            <label className="sr-only" for="password">Password</label>
              <input type="password" className="form-control" id="password" name="password" placeholder="Password" />
          </div>
          <button type="submit" className="btn" id="sign-in-button">Sign in</button>
        </form>
      </div>
    );
  }
});
