var User=class User extends React.Component {
  constructor(props) {
    super(props);
    this.state = {imageUrl: this.props.data.picture.url}
  }
 handleUpload(e) {
  e.preventDefault();
  var reader = new FileReader();
  var file = e.target.files[0];
  reader.onloadend = function() {
   this.setState({imageUrl: reader.result });
  }.bind(this);
  if (file){
    reader.readAsDataURL(file);
  }
  var formData = new FormData();
  formData.append("[user[picture]]", file);
  $.ajax({
    url: '/upload_picture',
    type: 'POST',
    processData: false,
    contentType: false,
    dataType: 'json',
    data: formData,
    success: function(post) {
       console.log("Done!")
    }
  })
}
  imagePresent(){
    return (
      <section className="containImageandInput">
        <img src={this.state.imageUrl} className="centerImage"/>
        <input className="fileInput" type="file" onChange={this.handleUpload.bind(this)}/>
      </section>
    );
  }

  imageNotPresent(){
    return (
      <section className="containImageandInput">
        <form className = "centerImage">
          <input className="fileInput" type="file" onChange={this.handleUpload.bind(this)}/>
        </form>
      </section>
    );
  }

  renderOneOfTwo() {
    imageLink=this.state.imageUrl;
    if (imageLink == null) {
      return this.imageNotPresent();
    }
    else{
      return this.imagePresent();
    }
  }

  render() {
    return this.renderOneOfTwo();
  }
}

ReactDOM.render(<User />,document.getElementById('pictureKeeper'));
