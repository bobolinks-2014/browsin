/** @jsx React.DOM */
var UserInfo = React.createClass({
  getInitialState: function() {
    return (
      <div>
        {this.props.userInfo}
      </div>
    )
  },

  render: function() {
    return (
      <div className='modal-dialog user-modal'>
        <div className='modal-content'>
          <div className='modal-header mod-header-color'>
            <button type='button' className='close' data-dismiss='modal'>
              <span aria-hidden="true">&times;</span>
          </button>
             <h4 className='modal-title' id='profilePage'>{this.props.userInfo.email}</h4>
             </div>
              <div className='modal-body'>
                <div className='provider-list'>
                    <div className='row'>
                      {InfoCheck.providerList().map(function(item, index){
                        return <div className='col-sm-6 col-md-4' key={index}>
                          <div className='button-group-main' key={item}>
                            <span key={item} className={item + " sprite-size"}></span>
                            <div className='caption' id={this.props.userInfo.service_list}>
                          <p id={item} key={item}>{(InfoCheck.getButton(item, this.props.userInfo.service_list) == 'add') ? <button key={item} className='btn btn-main btn-xs add' role='button'>add</button> : <button key={item} className='btn btn-xs remove'>remove</button> }</p>
                          </div>
                        </div>
                      </div>
                      }.bind(this))}
                    </div>
                </div>
                <div className='hidden-media'>
                  {(this.props.userInfo.hidden_media.length > 0) ? <h4>Hidden Media</h4> : false}
                  <table className='table table-hover' key={this.props.userInfo.id}>
                  <tbody>
                    {this.props.userInfo.hidden_media.map(function(item, index) {
                      return <tr key={index}>
                      <td id={item.imdb_id} key={item.imdb_id} className='profile-media'><strong>{item.title}</strong></td>
                      <td key={item.rating}>Rating: {item.rating}</td>
                      <td id={item.id} className='add-media-back'>
                        <button key={item.id} id={item.imdb_id} className='btn btn-xs show pull-right'>show</button>
                      </td>
                      </tr>
                    })}
                  </tbody>
                   </table>
                </div>
              </div>
        </div>
      </div>
    )
  }
});

var renderUserPage = function(user) {
  React.renderComponent(
    <UserInfo userInfo={user} />,
    document.getElementById('profile-page')
  );
}
