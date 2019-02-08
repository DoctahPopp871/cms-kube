import reduxifyServices from 'feathers-redux'
import feathersClient from './feathersClient'

const services = [ 'status', 'user' ]

export default reduxifyServices(feathersClient, services)
