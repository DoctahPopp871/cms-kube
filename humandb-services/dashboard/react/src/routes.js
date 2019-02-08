import React, { Component } from 'react'
import store from 'redux/store'
import { Route, Switch } from 'react-router-dom'

import EnsureLoggedIn from 'components/auth/EnsureLoggedIn'
import Home from 'components/pages/home/Home'
import Login from 'components/pages/login/Login'
import Users from 'components/pages/users/Users'
import CreateUser from 'components/pages/users/create/CreateUser'
import Status from 'components/pages/status/Status'
import Integrations from 'components/pages/integrations/Integrations'
import AdvaitaIntegration from 'components/pages/integrations/advaita/AdvaitaIntegration'
import Fhir from 'components/pages/fhir/Fhir'

const ownerAndAdminRegexp = /(admin|owner)/

class Routes extends Component {
  render () {
    const { role } = store.getState().currentUser

    return (
      <Switch>
        <Route exact path='/login' component={Login} />
        <EnsureLoggedIn>
          <Route exact path='/' component={Home} />

          { ownerAndAdminRegexp.test(role) && <Route exact path='/users' component={Users} /> }
          { ownerAndAdminRegexp.test(role) && <Route exact path='/users/create' component={CreateUser} /> }
          { ownerAndAdminRegexp.test(role) && <Route exact path='/status' component={Status} /> }
          { ownerAndAdminRegexp.test(role) && <Route exact path='/integrations' component={Integrations} /> }
          { ownerAndAdminRegexp.test(role) && <Route exact path='/integrations/advaita' component={AdvaitaIntegration} /> }
          { ownerAndAdminRegexp.test(role) && <Route exact path='/load-your-data' component={Fhir} /> }
        </EnsureLoggedIn>
      </Switch>
    )
  }
}

export default Routes
