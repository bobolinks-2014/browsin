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
            <input type='text' className='form-control' placeholder='ex: I have 30 minutes' />
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
