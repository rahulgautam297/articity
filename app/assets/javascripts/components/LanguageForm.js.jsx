var LanguageForm = class LanguageForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {language:"", level:"", shown: this.props.shown}
  }
  handleChange(name, e){
    e.preventDefault();
    var obj = {};
    obj[name] = e.target.value;
    this.setState(obj);
  }
  removeForm(e){
    e.preventDefault();
    this.setState({shown: false});
  }
  valid() {
   return (this.state.language && this.state.level);
 }
 componentWillReceiveProps(shown){
   this.setState({shown: shown.shown});
 }
 handleSubmit(){
   var formData = new FormData();
   formData.append("[language_user[language]]", this.state.language);
   formData.append("[language_user[level]]", this.state.level);
   $.ajax({
     url: '/language_preferences',
     type: 'POST',
     processData: false,
     contentType: false,
     dataType: 'json',
     data: formData,
     success: function(post) {
        console.log("Done!")
        //append to screen added language preference
     }
   })
 }
  render(){
    if (this.state.shown){
      return (
        <form className='form-inline'>
           <div className='form-group'>
             <input type='text' className='form-control' placeholder='Add language'
              value={this.state.language} onChange={this.handleChange.bind(this, 'language')}>
             </input>
           </div>
           <div className='form-group'>
            <select value={this.state.level} onChange={this.handleChange.bind(this, 'level')}>
              <option value="0" className="hiddenOption">Language Level</option>
              <option value="Basic">Basic</option>
              <option value="Conversational">Conversational</option>
              <option value="Fluent">Fluent</option>
              <option value="Native or bilingual">Native or bilingual</option>
            </select>
           </div>
           <div className='form-group'>
             <button className='btn btn-primary btn-sm'
                        onClick={this.handleSubmit.bind(this)}  disabled={!this.valid()}>
            Add
            </button>
           </div>
           <div className='form-group'>
             <button className='btn btn-danger btn-sm'
                                      onClick={this.removeForm.bind(this)} >
              Cancel
            </button>
           </div>
         </form>
      );
    }
    else{
      return(null);
    }
  }
}
