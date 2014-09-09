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
             <h4 className='modal-title' id='profilePage'>make changes</h4>
             </div>
              <div className='modal-body'>
                <p>{this.props.userInfo.user}</p>
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
