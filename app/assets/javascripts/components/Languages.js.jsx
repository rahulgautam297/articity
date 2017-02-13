var Languages = class Languages extends React.Component {
  constructor(props) {
    super(props);
    this.state = {allLanguages: this.props.allLanguages,
              languages: this.props.languagesLevels,languageFormPresent: false}
  }
  displayLanguageForm(e){
    e.preventDefault();
    this.setState({languageFormPresent : true});
  }

  addLanguage(language, level, id) {
  var language = {name:language, level:level, level_id:id}
  var languages = React.addons.update(this.state.languages, { $push: [language] })
  this.setState({ languages: languages });
  }

  deleteLanguage(id) {
    array=this.state.languages
    var index=-1;
    for(var i = 0; i < array.length; i ++) {
      if(array[i].level_id === id){
          index=i;
          break;
      }
    }
    var languages = React.addons.update(this.state.languages,
                                                    { $splice: [[index, 1]] });
    this.setState({ languages: languages, languageFormPresent: false});
  }

  updateLanguage(language, data) {
    var index = this.state.languages.indexOf(language);
    var languages = React.addons.update(this.state.languages,
                                      { $splice: [[index, 1, data]] });
    this.setState({ languages: languages });
  }
  render(){
    return (
      <div className="centerTable">
        <LanguageForm handleNewLanguage={this.addLanguage.bind(this)}
  languages={this.state.allLanguages} shown={this.state.languageFormPresent} />
        <table>
          <thead>
            <tr>
              <th>
              Language
              </th>
              <th>
              Level
              </th>
              <th>
                <button className="btn btn-primary"
                                  onClick={this.displayLanguageForm.bind(this)}>
                <span className="glyphicon glyphicon-plus"
                                    aria-hidden="true"></span> Add More</button>
              </th>
            </tr>
          </thead>
          <tbody>
          {this.state.languages.map(function(language) {
            return <Language key={language.level_id} language={language}
                 handleDeleteLanguage={this.deleteLanguage.bind(this)}
                 handleEditLanguage={this.updateLanguage.bind(this)} />
          }.bind(this))}
          </tbody>
        </table>
      </div>
    )
  }
}
ReactDOM.render(<Languages />,document.getElementById('languageKeeper'));
