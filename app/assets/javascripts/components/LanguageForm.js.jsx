var LanguageForm = class LanguageForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {language:"", languages:this.props.languages, level:"", shown: this.props.shown}
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
 handleSubmit(e){
   e.preventDefault();
   var formData = new FormData();
   formData.append("[language_user[language]]", this.state.language);
   formData.append("[language_user[level]]", this.state.level);
   $.ajax({
     url: '/create_language_preference',
     type: 'POST',
     processData: false,
     contentType: false,
     dataType: 'json',
     data: formData,
     success: function(post) {
        this.props.handleNewLanguage(this.state.language, this.state.level,post.id)
        this.setState({language:"",level:""})
     }.bind(this)
   })
 }
  render(){
    if (this.state.shown){
      var selects = [];
      for (var i = 0; i < this.state.languages.length; i++) {
        selects.push(this.state.languages[i].name);
      }
      $( "#language-filter" ).autocomplete({
        source: selects,
        delay: 0,
        change: function (event, ui) {
            var capitalized=event.target.value.charAt(0).toUpperCase()+ event.target.value.slice(1);
            if (selects.indexOf(event.target.value) < 0 && selects.indexOf(capitalized)>-1) {
              this.setState({language:capitalized})
            }
            else if (selects.indexOf(capitalized) < 0) {
              this.setState({language:""})
             }
        }.bind(this),
        messages: {
                noResults: '',
                results: function() {}
            }
      });
      return (
        <form className='form-inline'>
           <div className='form-group'>
             <input type='search' className='form-control' placeholder='Add language'
              value={this.state.language} onChange={this.handleChange.bind(this, 'language')}
              onBlur={this.handleChange.bind(this, 'language')}
              id="language-filter" placeholder="Select language"  />
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
