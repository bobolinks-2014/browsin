/** @jsx React.DOM */
/**on show of a hidden object
S
 show
 /users
 
 edit
 /users/edit PATCH
  {service_list: ['list']}
 /users/add PATCH
  {item_id: id}  
 */

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
                  <h4>browsin' service list</h4>
                    <div className='row'>
                      {InfoCheck.providerList().map(function(item, index){
                        return <div className='col-sm-6 col-md-4' key={index}>
                          <div className='thumbnail'>
                            <span className={item + " sprite-size"}></span>
                            <div className='caption pull-right'>
                          <p>{(InfoCheck.getButton(item) === 'add') ? <a className='btn btn-main btn-xs' role='button'>add</a> : <button className='btn btn-xs'>remove</button> }</p>
                          </div>
                        </div>
                      </div>
                      })}
                    </div>
                </div>
                <div className='hidden-media'>
                  <h4>Hidden Media</h4>
                  <table className='table table-hover'>
                  {this.props.userInfo.hidden_media.map(function(item, index){
                    return <tr key={index}>
                    <td id={item.imdb_id} className='profile-media'><strong>{item.title}</strong></td>
                    <td>Rating: {item.rating}</td>
                    <td id={item.id} className='add-media-back'>
                      <button className='btn btn-xs'>show</button>
                    </td>
                    </tr>
                  })}
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
