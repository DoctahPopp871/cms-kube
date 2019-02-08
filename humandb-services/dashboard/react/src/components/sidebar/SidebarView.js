import React, { Component } from 'react'
import { Menu, Image } from 'semantic-ui-react'
import './Sidebar.css'

const integrationsRegexp = /^\/integrations/
const statusRegexp = /^\/status/
const usersRegexp = /^\/users/
const loadYourDataRegexp = /^\/load-your-data/
const ownerOrAdminRegexp = /(owner|admin)/

class SidebarView extends Component {
  render () {
    const { currentUser, routeTo, router } = this.props

    return currentUser.id ? (
      <Menu vertical className='sidebarComponent'>
        <Menu.Item onClick={() => routeTo('/')}>
          <Image src='/images/18F-HumanDB-LogoR1-02.svg' />
        </Menu.Item>
        { ownerOrAdminRegexp.test(currentUser.role) &&
          <Menu.Item active={usersRegexp.test(router.location.pathname)} onClick={() => routeTo('/users')}>
            Users
          </Menu.Item>
        }
        <Menu.Item active={integrationsRegexp.test(router.location.pathname)} onClick={() => routeTo('/integrations')}>
          Integrations
        </Menu.Item>
        { ownerOrAdminRegexp.test(currentUser.role) &&
          <Menu.Item active={statusRegexp.test(router.location.pathname)} onClick={() => routeTo('/status')}>
            Status
          </Menu.Item>
        }
        { currentUser.role === 'owner' &&
          <Menu.Item active={loadYourDataRegexp.test(router.location.pathname)} onClick={() => routeTo('/load-your-data')}>
            Load Your Data
          </Menu.Item>
        }
        <Menu.Item onClick={() => window.location.replace(`https://${window.location.hostname}/discussion/`)}>
          Discussion
        </Menu.Item>
      </Menu>
    ) : ''
  }
}

export default SidebarView
