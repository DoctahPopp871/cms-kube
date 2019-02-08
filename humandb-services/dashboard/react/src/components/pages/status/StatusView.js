import React, { Component } from 'react'
import { Card, Icon, Image, Segment } from 'semantic-ui-react'

class StatusView extends Component {
  componentDidMount () {
    this.props.loadStatuses()
  }

  render () {
    const { loaded, statuses } = this.props

    return (
      <div className='statusComponent'>
        {!loaded
          ? <span>Loading status...<Icon name='spinner' loading /></span>
          : statuses.length
          ? <div className='statusContainer'>
            <Card.Group>
              { statuses.map(status => {
                return (
                  <Card key={`${status.id}${status.service}${status.dependency}`}>
                    <Card.Content>
                      <Image floated='right' size='mini' src='/images/avatar/large/steve.jpg' />
                      <Card.Header>{status.service}</Card.Header>
                      <Card.Meta>{status.dependency}</Card.Meta>
                      <Card.Description>{status.description}</Card.Description>
                    </Card.Content>
                    <Card.Content extra>
                      <span style={{ color: status.status === 'Available' ? 'green' : 'red' }}>{status.status}</span>

                      {status.error &&
                      <div style={{ marginTop: '10px', color: 'red' }}>Error: {status.error}</div>
                        }
                    </Card.Content>
                  </Card>
                )
              })
              }
            </Card.Group>
          </div>
          : <Segment>No containers have been added yet.</Segment>
        }
      </div>
    )
  }
}

export default StatusView
