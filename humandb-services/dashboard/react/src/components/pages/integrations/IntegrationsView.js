import React, { Component } from 'react'
import { Card, Icon, Segment } from 'semantic-ui-react'
import { Link } from 'react-router-dom'

class IntegrationsView extends Component {
  render () {
    const { loaded = true } = this.props

    return (
      <div className='usersComponent'>
        {!loaded
          ? <span>Loading status...<Icon name='spinner' loading /></span>
          : <div className='statusContainer'>
            <Segment>
              <Card
                image='/images/ADVAITA-Logo-NewTag220.png'
                header={<a target='_blank' rel='noopener noreferrer' href='https://advaitabio.com/'>Advaitabio</a>}
                meta='Bioinformatics that Inspire'
                description='Other solutions bring you the haystack; we lead you to the needle in the haystack.'
                extra={<Link to='/integrations/advaita' className='ui button primary'>Actions</Link>}
                />
            </Segment>
          </div>
        }
      </div>
    )
  }
}

export default IntegrationsView
