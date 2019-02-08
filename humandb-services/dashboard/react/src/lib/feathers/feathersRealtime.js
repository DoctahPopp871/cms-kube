import client from 'lib/feathers/feathersClient'
import services from 'lib/feathers/feathersServices'
import store from 'redux/store'
import { throttle } from 'lodash'

const throttleThreshold = 5000 // 5 seconds

const statusRegexp = /^\/status/

const updateStatus = throttle(async () => {
  if (statusRegexp.test(window.location.pathname)) {
    // store.dispatch(services.status.find())
    // TODO: fix ^ - this causes the SERVICES_STATUS_FIND_PENDING event to cause a double render in the view because it
    // changes the queryResult state to different/stale data for some reason - below is the workaround for this
    const result = await services.status.find()
    const payload = await result.payload.promise

    store.dispatch({
      type: 'SERVICES_STATUS_FIND_FULFILLED',
      payload
    })
  }
}, throttleThreshold)

export default {
  init () {
    client.service('user').on('patched', user => {
      const currentUser = store.getState().currentUser
      if (currentUser.id === user.data.id) {
        store.dispatch({ type: 'SET_CURRENT_USER', user: user.data || user })
      }
    })

    client.service('status').on('created', updateStatus)
    client.service('status').on('patched', updateStatus)
  }
}
