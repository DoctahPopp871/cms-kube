import React, { Component } from 'react'
import { Segment } from 'semantic-ui-react'

class HomeView extends Component {
  render () {
    return (
      <Segment>
        <span>You are now logged in.</span><br /><br />
      </Segment>
    )
  }
}

export default HomeView
