var Language = class Language extends React.Component {
  constructor(props) {
    super(props);
    this.state = { edit: false}
  }

  handleToggle(e) {
    e.preventDefault();
    this.setState({ edit: !this.state.edit });
  }

  handleDelete(e) {
    e.preventDefault();
    var formData = new FormData();
    formData.append("[language_user[language_user_id]]", this.props.language.level_id);
    $.ajax({
      url: '/delete_language_preference',
      type: 'DELETE',
      processData: false,
      contentType: false,
      dataType: 'json',
      data: formData,
      success: function() {
        this.props.handleDeleteLanguage(this.props.language.level_id)
    }.bind(this)
    });
  }

  handleEdit(e) {
    e.preventDefault();
    data={name:ReactDOM.findDOMNode(this.refs.language_name).value,
                          level:ReactDOM.findDOMNode(this.refs.level).value,
                                        level_id: this.props.language.level_id}
    var formData = new FormData();
    formData.append("[language_user[language_user_id]]",data.level_id);
    formData.append("[language_user[language]]",data.name);
    formData.append("[language_user[level]]",data.level);
     $.ajax({
       url: '/update_language_preference',
       type: 'PUT',
       processData: false,
       contentType: false,
       dataType: 'json',
       data: formData,
       success: function(post) {
         this.setState({ edit: false });
        this.props.handleEditLanguage(this.props.language, data);
     }.bind(this)
     });
  }

  languageRow() {
    return(
      <tr>
        <td>{this.props.language.name}</td>
        <td>{this.props.language.level}</td>
        <td>
          <a className='btn btn-warning' onClick={this.handleToggle.bind(this)}>
            Edit
          </a>
          <a className='btn btn-danger' onClick={this.handleDelete.bind(this)}>
            Delete
          </a>
        </td>
      </tr>
    );
  }

  languageForm() {
    return(
      <tr>
        <td>
          <input className='form-control' type='text'
                 defaultValue={this.props.language.name} ref='language_name'>
                 //change to select for valid options
          </input>
        </td>
        <td>
          <select defaultValue={this.props.language.level} ref = "level">
            <option value="0" className="hiddenOption">Language Level</option>
            <option value="Basic">Basic</option>
            <option value="Conversational">Conversational</option>
            <option value="Fluent">Fluent</option>
            <option value="Native or bilingual">Native or bilingual</option>
          </select>
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

  renderedLanguage() {
    if (this.state.edit === true) {
      return this.languageForm();
    } else {
      return this.languageRow();
    }
  }

  render() {
    return this.renderedLanguage();
  }
}
