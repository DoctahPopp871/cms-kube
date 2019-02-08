const Promise = require('bluebird')
const feathers = require('@feathersjs/feathers')
const socketio = require('@feathersjs/socketio-client')
const auth = require('@feathersjs/authentication-client')
const io = require('socket.io-client')
const fs = require('fs')

const service = 'test'
const url = 'http://hdb-dash-auth:3001/'

const authData = {
  strategy: 'local',
  email: 'test',
  password: 'test'
}

const socket = io(url, {
  path: '/auth/socket.io',
  transports: ['websocket']
})

const app = feathers()
  .configure(socketio(socket, { timeout: 10000, 'force new connection': true }))
  .configure(auth({ path: '/auth/authenticatasion' }))

const authenticate = () =>
  app.authenticate(authData)
    .then(res => console.log('Successfully authenticated against auth API ', res))

const notify = async ({ status, dependency, description, error = '' }) => {
  const query = { service, dependency }
  const { total } = await app.service('status').find({ query })

  if (total) {
    return app.service('status').patch(null, { status, error }, { query })
  }

  return app.service('status').create({ service, status, dependency, description, error })
}

const checkLocalFileDep = () => {
  const dependency = 'Local file system'
  try {
    fs.readFileSync('./local.test')

    return notify({ status: 'Available', dependency, description: 'These files should be present in the local filesystem of the container.' })
  } catch (e) {
    return notify({ status: 'Unavailable', dependency, error: `Could not load local file 'local.test', error: ${e.message}` })
  }
}

const checkMountedVolumeFileDep = () => {
  const dependency = 'Mounted file system'
  try {
    fs.readFileSync('/data/mounted.test')

    return notify({ status: 'Available', dependency, description: 'These files should be present in the mounted /data folder of the container.' })
  } catch (e) {
    return notify({ status: 'Unavailable', dependency, error: `Could not load mounted file '/data/mounted.test', error: ${e.message}` })
  }
}

const checkDeps = async () => {
  try {
    await authenticate()

    return Promise.all([
      checkLocalFileDep(),
      checkMountedVolumeFileDep()
    ])
  } catch (e) {
    console.log(`Error checking deps: ${e.message}`)

    return setTimeout(checkDeps, 5000)
  }
}

checkDeps()