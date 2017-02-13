var SkillForm = class SkillForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {skill:"",description:"",price:"",portfolio:"", multimedia:"", skills: this.props.skills}
  }
  handleChange(name, e){
    e.preventDefault();
    var obj = {};
    obj[name] = e.target.value;
    this.setState(obj);
  }
  handleImage(name, e){
    e.preventDefault();
    var obj = {image:e.target.files[0]};
    this.setState({multimedia: obj})
  }
  valid() {
   return (this.state.skill && this.state.description && this.state.price
    && (this.state.multimedia || this.state.portfolio));
 }

 handleSubmit(e){
   e.preventDefault();
   var file = this.state.multimedia;
   var upload= false
   if (file !=""){
    upload=true
  }
  var skill= this.state.skill
  var desc = this.state.skills.filter(function( obj ) {
    return obj.name == skill
  })
   var formData = new FormData();
   formData.append("[user_skill[skill_id]]", desc[0].id);
   formData.append("[user_skill[price]]", this.state.price);
   formData.append("[user_skill[description]]", this.state.description);
   if (upload && this.state.portfolio!=""){
    formData.append("[user_skill[multimedia]]", file.image);
    formData.append("[user_skill[portfolio]]", this.state.portfolio);
   }
   else if (upload){
    formData.append("[user_skill[multimedia]]", file.image);
   }
   else{
   formData.append("[user_skill[portfolio]]", this.state.portfolio);
  }
   $.ajax({
     url: '/user_skills',
     type: 'POST',
     processData: false,
     contentType: false,
     dataType: 'json',
     data: formData,
     success: function(post) {
       var data= {name:this.state.skill, description:this.state.description,
                  portfolio:this.state.portfolio, price:this.state.price,
                  multimedia:post.multimedia, user_skill_id:post.id}
        this.props.handleNewSkill(data)
        this.setState({skill:"",description:"",price:"",portfolio:"",multimedia:""})
     }.bind(this)
   })
 }
  render(){
    var selects = [];
    for (var i = 0; i < this.state.skills.length; i++) {
      selects.push(this.state.skills[i].name);
    }
    $( "#"+this.state.skills[0].id ).autocomplete({
      source: selects,
      cacheLength:20,
      max:20,
      delay: 0,
      change: function (event, ui) {
        var capitalized=event.target.value.charAt(0).toUpperCase()+ event.target.value.slice(1);
        if (selects.indexOf(event.target.value) < 0 && selects.indexOf(capitalized)>-1) {
          var desc = this.state.skills.filter(function( obj ) {
            return obj.name == capitalized;
          });
          var node=ReactDOM.findDOMNode(this.refs.skill_description)
          node['placeholder']=desc[0].description
          this.setState({skill:capitalized})
        }
        else if (selects.indexOf(capitalized) < 0) {
          this.setState({skill:"",description:""})
         }
         else if (ui.item) {
           var desc = this.state.skills.filter(function( obj ) {
             return obj.name == ui.item.value;
           });
           var node=ReactDOM.findDOMNode(this.refs.skill_description)
           node['placeholder']=desc[0].description
           this.setState({skill:ui.item.value})
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
           <input type='search' className='form-control' placeholder='Add skill'
            value={this.state.skill} onChange={this.handleChange.bind(this, 'skill')}
            onBlur={this.handleChange.bind(this, 'skill')}
            id={this.state.skills[0].id} placeholder="select skill"  />
         </div>
         <div className='form-group'>
           <input type='text' className='form-control' placeholder="Please add description"
            value={this.state.description} onChange={this.handleChange.bind(this, 'description')}
            ref ='skill_description' />
         </div>
         <div className='form-group'>
          <input type='text' className='form-control' placeholder="set price for service"
            value={this.state.price} onChange={this.handleChange.bind(this, 'price')}  />
        </div>
        <div className='form-group'>
         <input type='text' className='form-control' placeholder="portfolio link or upload content"
           value={this.state.portfolio} onChange={this.handleChange.bind(this, 'portfolio')}  />
       </div>
       <div className='form-group'>
       <span className="glyphicon glyphicon-upload upload-size" aria-hidden="true">
        <input type='file' className='skillInput'onChange={this.handleImage.bind(this, 'multimedia')}  />
      </span>
      </div>
      <br />
         <div className='form-group'>
           <button className='btn btn-primary btn-sm'
                      onClick={this.handleSubmit.bind(this)}  disabled={!this.valid()}>
          Add
          </button>
         </div>
       </form>
    );
  }
}
