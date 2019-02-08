import feathers from '@feathersjs/feathers'
import socketio from '@feathersjs/socketio-client'
import auth from '@feathersjs/authentication-client'
import io from 'socket.io-client'

export const url = `${window.location.protocol}//${window.location.host}/auth`

const ioURL = url.replace(/\/auth$/, '')

const socket = io(ioURL, {
  path: '/auth/socket.io',
  transports: ['websocket']
})

const feathersClient = feathers()
  .configure(socketio(socket, { timeout: 10000 }))
  .configure(auth({ path: '/auth/authentication', storage: window.localStorage }))

export default feathersClient
