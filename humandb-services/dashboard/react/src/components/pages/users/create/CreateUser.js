import { connect } from 'react-redux'

import services from 'lib/feathers/feathersServices'
import CreateUserView from './CreateUserView'

const mapStateToProps = state => ({})

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    createUser: async userData => {
      try {
        const { email, admin } = userData

        await dispatch(services.user.create({ email, admin }))

        return ownProps.history.push('/users')
      } catch (e) {
        void e
      }
    },
    routeTo: path => ownProps.history.push(path)
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(CreateUserView)
