import React, {Component} from 'react'
import { Dropdown, Divider, Image, Menu } from 'semantic-ui-react'
import './Header.css'

const DropdownItem = Dropdown.Item

const profileSrc = '/images/icons/defaultProfile.svg'

const integrationsRegexp = /^\/integrations/
const statusRegexp = /^\/status/
const usersRegexp = /^\/users/

const getPageDescription = path => {
  if (integrationsRegexp.test(path)) return 'A list of currently available integrations'
  if (statusRegexp.test(path)) return 'Shows the current status of connection integrations'
  if (usersRegexp.test(path)) return 'Add users that can login to this dashboard by their Google account e-mail address'

  return ''
}

class HeaderView extends Component {
  render () {
    const { currentUser, routeTo, router, logout } = this.props
    const menuTrigger = <Image src={profileSrc} className='profileImage' />

    const path = router.location.pathname

    return currentUser.id || currentUser._id
      ? (
        <Menu className='headerComponent'>
          <Menu.Menu position='left'>
            <span style={{ color: 'black' }}>{ getPageDescription(path) }</span>
          </Menu.Menu>
          <Menu.Menu position='right'>
            <Menu.Item>{currentUser.walletAccountName}</Menu.Item>
            <Dropdown name='settings' pointing trigger={menuTrigger} icon={null}>
              <Dropdown.Menu className='headerDropdownMenu'>
                <DropdownItem key='profile' onClick={() => routeTo('/profile')}>Profile</DropdownItem>
                <DropdownItem key='settings' onClick={() => routeTo('/settings')}>Settings</DropdownItem>
                <Divider />
                <DropdownItem key='logout' onClick={logout}>Log Out</DropdownItem>
              </Dropdown.Menu>
            </Dropdown>
          </Menu.Menu>
        </Menu>
      )
      : ''
  }
}

export default HeaderView
