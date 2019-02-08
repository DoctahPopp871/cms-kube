import React, { Component } from 'react'
import { Icon } from 'semantic-ui-react'

class FhirView extends Component {
  render () {
    const { currentUser, loaded = true } = this.props

    return (
      <div className='usersComponent'>
        {!loaded
          ? <span>Loading status...<Icon name='spinner' loading /></span>
          : <div className='statusContainer'>
            <iframe
              style={{ border: '0px solid #fff' }}
              src={`https://api.1up.health/connect/marketplace?client_id=${currentUser.oneUpClientId}&access_token=${currentUser.oneUpAccessToken}`}
              height='500'
              width='100%' />
          </div>
        }
      </div>
    )
  }
}

export default FhirView
