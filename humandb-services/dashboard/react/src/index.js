import React from 'react'
import ReactDOM from 'react-dom'

import './index.css'
import App from './app'
import store from 'redux/store'
import initialAuth from 'lib/initialAuth'
import realtime from 'lib/feathers/feathersRealtime'

initialAuth(store)
  .then(() => ReactDOM.render(<App />, document.getElementById('root')))
  .then(realtime.init)
