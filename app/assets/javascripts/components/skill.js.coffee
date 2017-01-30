  @skill = React.createClass
    render: ->
      React.DOM.tr null,
        React.DOM.td null, @props.skill.name
