import React, { Component } from 'react'
import { Grid, Header, Image, Segment } from 'semantic-ui-react'
import { url } from 'lib/feathers/feathersClient'

class LoginView extends Component {
  render () {
    const { loading, loaded } = this.props
    console.log('url ', url)
    return (
      <div style={{ backgroundColor: '#FFFFFF', position: 'absolute', top: '0', left: '0', zIndex: '1000', width: '100%', height: '100%' }}>
        <Image src='/images/18F-HumanDB-LogoR1-02.svg' size='medium' style={{ margin: '200px auto 0 auto' }} />
        <Grid textAlign='center' style={{ position: 'relative', top: '2em' }}>
          <Grid.Column style={{ maxWidth: 360 }}>
            <Segment size='large' textAlign='center'>
              { loading && !loaded ? <Header>Logging In...</Header> : <Header><a href={`${url.replace(/\/auth$/, '')}/auth/google`}>Login With Google</a></Header> }
            </Segment>
          </Grid.Column>
        </Grid>
      </div>
    )
  }
}

export default LoginView
