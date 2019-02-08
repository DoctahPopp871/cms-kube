import { all, put, takeLatest } from 'redux-saga/effects'
import { push } from 'react-router-redux'
import superagent from 'superagent'

import feathersauthentication from 'lib/feathers/feathersAuthentication'
import { url } from 'lib/feathers/feathersClient'

const removeJwtFromLocalStorage = () => {
  if (window.localStorage && window.localStorage.removeItem) {
    window.localStorage.removeItem('feathers-jwt')
  }
}

const loginPathRegexp = /\/(token-)?login/
function * loginSuccess ({ user, accessToken, discourseSSOTempToken }) {
  if (discourseSSOTempToken) {
    const { body: { path } } = yield superagent.post(`${url}/discourse/redirect`).set('Authorization', `Bearer ${accessToken}`).send({ discourseSSOTempToken })

    window.localStorage && window.localStorage.removeItem && window.localStorage.removeItem('discourseSSOTempToken')

    window.location.replace(path)
  } else if (loginPathRegexp.test(window.location.pathname)) {
    yield put(push('/'))
  }
}

function * logout () {
  const accessToken = window.localStorage && window.localStorage.getItem && window.localStorage.getItem('feathers-jwt')

  try {
    yield superagent.post(`${url}/discourse/logout`).set('Authorization', `Bearer ${accessToken}`)
  } catch (e) {
    console.log(`Error logging out of Discourse: ${e.message}`)
  }

  removeJwtFromLocalStorage()
  put(feathersauthentication.logout())

  window.location.replace('/login')
}

export default function * watchAuth () {
  yield all([
    takeLatest('LOGIN_SUCCESS', loginSuccess),
    takeLatest('LOGOUT', logout)
  ])
}
