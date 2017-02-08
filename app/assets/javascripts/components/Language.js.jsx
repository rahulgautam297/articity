var Language = class Language extends React.Component {
  constructor(props) {
    super(props);
    this.state = { edit: false}
  }

  handleToggle(e) {
    e.preventDefault();
    console.log(123);
    this.setState({ edit: !this.state.edit });
  }

  handleDelete(e) {
    $.ajax({
      method: 'DELETE',
      url: '/records/' + this.props.record.id,
      dataType: 'JSON',
      success: function() {
        this.props.handleDeleteRecord(this.props.record)
      }.bind(this)
    });
  }

  handleEdit(e) {
    e.preventDefault();
    var data = { title: React.findDOMNode(this.refs.title).value,
                 date: React.findDOMNode(this.refs.date).value,
                 amount: React.findDOMNode(this.refs.amount).value }
    $.ajax({
      method: 'PUT',
      url: '/records/' + this.props.record.id,
      dataType: 'JSON',
      data: { record: data },
      success: function(data) {
        this.setState({ edit: false });
        this.props.handleEditRecord(this.props.record, data);
      }.bind(this)
    });
  }

  languageRow() {
    return(
      <tr>
        <td>{this.props.language.name}</td>
        <td>{this.props.language.level}</td>
        <td>
          <a className='btn btn-default' onClick={this.handleToggle}>
            Edit
          </a>
          <a className='btn btn-danger' onClick={this.handleDelete}>
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
                 defaultValue={this.props.language.name} ref='date'>
          </input>
        </td>
        <td>
          <input className='form-control' type='text'
                 defaultValue={this.props.record.level} ref='title'>
          </input>
        </td>
        <td>
          <a className='btn btn-default' onClick={this.handleEdit}>
            Update
          </a>
          <a className='btn btn-danger' onClick={this.handleToggle}>
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
