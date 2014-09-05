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
