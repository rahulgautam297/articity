var Skill = class Skill extends React.Component {
  constructor(props) {
    super(props);
    this.state = { edit: false, multimedia:""}
  }

  handleToggle(e) {
    e.preventDefault();
    this.setState({ edit: !this.state.edit });
  }

  handleDelete(e) {
    e.preventDefault();
    var formData = new FormData();
    formData.append("[user_skill[user_skill_id]]", this.props.skill.user_skill_id);
    $.ajax({
      url: '/delete_user_skill',
      type: 'DELETE',
      processData: false,
      contentType: false,
      dataType: 'json',
      data: formData,
      success: function() {
        this.props.handleDeleteSkill(this.props.skill.user_skill_id)
    }.bind(this)
    });
  }

  handleEdit(e) {
    e.preventDefault();
    data={name:ReactDOM.findDOMNode(this.refs.skill_name).value,
          description:ReactDOM.findDOMNode(this.refs.skill_description).value,
          price:ReactDOM.findDOMNode(this.refs.skill_price).value,
          portfolio:ReactDOM.findDOMNode(this.refs.skill_portfolio).value,
                                  user_skill_id:this.props.skill.user_skill_id}
    var formData = new FormData();
    if(ReactDOM.findDOMNode(this.refs.skill_multimedia).files.length> 0){
      data.multimedia=
            ReactDOM.findDOMNode(this.refs.skill_multimedia).files[0].name
            formData.append("[user_skill[multimedia]]",
            ReactDOM.findDOMNode(this.refs.skill_multimedia).files[0]);
    }
    else{
      data.multimedia=
            ReactDOM.findDOMNode(this.refs.skill_multimedia).defaultValue;
    }

    formData.append("[user_skill[user_skill_id]]",data.user_skill_id);
    formData.append("[user_skill[name]]",data.name);
    formData.append("[user_skill[description]]",data.description);
    formData.append("[user_skill[price]]",data.price);
    formData.append("[user_skill[portfolio]]",data.portfolio);
     $.ajax({
       url: '/update_user_skill',
       type: 'PUT',
       processData: false,
       contentType: false,
       dataType: 'json',
       data: formData,
       success: function(post) {
         this.setState({ edit: false });
        this.props.handleEditSkill(this.props.skill, data);
     }.bind(this)
     });
  }

  skillRow() {
    return(
      <tr>
        <td>{this.props.skill.name}</td>
        <td>{this.props.skill.description}</td>
        <td>{this.props.skill.price}</td>
        <td>{this.props.skill.portfolio}</td>
        <td>{this.props.skill.multimedia}</td>
        <td>
          <a className='btn btn-warning btn-sm' onClick={this.handleToggle.bind(this)}>
            Edit
          </a>
          <a className='btn btn-danger btn-sm' onClick={this.handleDelete.bind(this)}>
            Delete
          </a>
        </td>
      </tr>
    );
  }

  skillForm() {
    return(
      <tr>
        <td>
          <input className='form-control' type='text'
                 defaultValue={this.props.skill.name} ref='skill_name'>
          </input>
        </td>
        <td>
          <input className='form-control' type='text'
                 defaultValue={this.props.skill.description} ref='skill_description'>
          </input>
        </td>
        <td>
          <input className='form-control' type='text'
                 defaultValue={this.props.skill.price} ref='skill_price'>
          </input>
        </td>
        <td>
          <input className='form-control' type='text'
                 defaultValue={this.props.skill.portfolio} ref='skill_portfolio'>
          </input>
        </td>
        <td>
          <span className="glyphicon glyphicon-upload upload-size" aria-hidden="true">
           <input type='file' className='skillInput'
           defaultValue={this.props.skill.multimedia} ref='skill_multimedia'/>
         </span>
        </td>
        <td>
          <a className='btn btn-success' onClick={this.handleEdit.bind(this)}>
            Update
          </a>
          <a className='btn btn-danger' onClick={this.handleToggle.bind(this)}>
            Cancel
          </a>
        </td>
      </tr>
    );
  }

  renderedSkill() {
    if (this.state.edit === true) {
      return this.skillForm();
    } else {
      return this.skillRow();
    }
  }

  render() {
    // add autocomplete in edit mode too
    return this.renderedSkill();
  }
}
