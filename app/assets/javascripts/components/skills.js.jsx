var Skills = class Skills extends React.Component {
  constructor(props) {
    super(props);
    this.state = {allSkills: this.props.allSkills, userSkills: this.props.userSkills}
  }

  addSkill(data) {
  var skills = React.addons.update(this.state.userSkills, { $push: [data] })
  this.setState({ userSkills: skills });
  }

  deleteSkill(id) {
    array=this.state.userSkills
    var index=-1;
    for(var i = 0; i < array.length; i ++) {
      if(array[i].user_skill_id === id){
          index=i;
          break;
      }
    }
    var skills = React.addons.update(this.state.userSkills,
                                                    { $splice: [[index, 1]] });
    this.setState({ userSkills: skills});
  }

  updateSkill(skill, data) {
    var index = this.state.userSkills.indexOf(skill);
    var skills = React.addons.update(this.state.userSkills,
                                      { $splice: [[index, 1, data]] });
    this.setState({ userSkills: skills });
  }

  render(){

    return (
      <div className="centerSkillCategories">
        <section>
          <table className= "centerUserSkills">
            <thead>
              <tr>
                <th>
                Skill
                </th>
                <th>
                Description
                </th>
                <th>
                Price
                </th>
                <th>
                portfolio
                </th>
                <th>
                Attachment
                </th>
              </tr>
            </thead>
            <tbody>
          {this.state.userSkills.map(function(skill) {
            return <Skill key={skill.user_Skill_id} skill={skill}
                 handleDeleteSkill={this.deleteSkill.bind(this)}
                 handleEditSkill={this.updateSkill.bind(this)} />
          }.bind(this))}
          </tbody>
        </table>
          {this.state.allSkills.map(function(skill){
            return(
              <div className= "categoryType">
                <h2>{skill.name}</h2>
                <SkillForm key="1" handleNewSkill={this.addSkill.bind(this)}
                skills={skill.skills}/>
              </div>
            )
          }.bind(this))}
        </section>

      </div>
    )
  }
}
document.addEventListener("skillContainer", function(event) {
ReactDOM.render(<Skills />,document.getElementById('skillContainer'));
});
