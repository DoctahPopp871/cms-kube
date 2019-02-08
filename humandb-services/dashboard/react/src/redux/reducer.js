import { combineReducers } from 'redux'
import { reducer as formReducer } from 'redux-form'
import { routerReducer } from 'react-router-redux'

import services from 'lib/feathers/feathersServices'
import feathersAuthentication from 'lib/feathers/feathersAuthentication'
import currentUser from 'redux/reducers/currentUser'
import page from './reducers/page'
import sort from './reducers/sort'
import search from './reducers/search'

const reducers = {
  auth: feathersAuthentication.reducer,
  currentUser,
  page,
  sort,
  search,
  user: services.user.reducer,
  statuses: services.status.reducer,
  form: formReducer,
  router: routerReducer
}

export default combineReducers(reducers)
