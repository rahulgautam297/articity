var Languages = class Languages extends React.Component {
  constructor(props) {
    super(props);
    this.state = {allLanguages: this.props.allLanguages,
              languages: this.props.languagesLevels,languageFormPresent: false}
  }
  displayLanguageForm(e){
    e.preventDefault();
    this.setState({languageFormPresent : true});
    {console.log(this.state.Languages);}
  }

  render(){
    return (
      <div>
        <LanguageForm shown={this.state.languageFormPresent} />
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
                 handleDeleteLanguage={this.deleteLanguage}
                 handleEditLanguage={this.updateLanguage} />
          }.bind(this))}
          </tbody>
        </table>
      </div>
    )
  }
}
ReactDOM.render(<Languages />,document.getElementById('languageKeeper'));
