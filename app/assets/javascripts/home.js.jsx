/** @jsx React.DOM */
var MediaItem = React.createClass({
  render: function() {
  return (
      <tbody>
        <tr>
          <th>{this.props.title}</th>
          <div className='icon-area'>
            <th className='platforms'>
              {this.props.services.map(function(result, index) {
                return <span id={result.name}>{result.name}</span>;
              })}
            </th>
            <th className='runtime'>{this.props.runtime}</th>
            <th className='genres'>
              {this.props.genres.map(function(result, index) {
                return <span id={result.name}>{result.name}</span>;
              })}
            </th>
          </div>
        </tr>
      </tbody>
      );
  }
});

var MediaList = React.createClass({
  render: function () {
    var mediaNodes = this.props.mediaItems.map(function (mediaItem, index) {
      return (
        <MediaItem title={mediaItem.title} services={mediaItem.services} runtime={mediaItem.run_time} genres={mediaItem.genres} key={index} />
      );
    });
    
    return (
        <table className='table table-striped'>
          {mediaNodes}
        </table>
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
        <a className='profile top-button pull-right'>{this.props.user}</a>
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
