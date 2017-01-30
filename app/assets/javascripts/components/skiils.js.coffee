 @Skills = React.createClass
    getInitialState: ->
      skills: @props.data
    getDefaultProps: ->
      skills: []
    render: ->
      React.DOM.div
        className: 'skills'
        React.DOM.h2
          className: 'title'
          'Skills'
        React.DOM.table
          className: 'table table-bordered'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th null, 'Skill-type'
          React.DOM.tbody null,
          for skill in @state.skills
            React.createElement Skill, key: skill.id, skill: skill
