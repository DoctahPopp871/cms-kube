import { connect } from 'react-redux'

import services from 'lib/feathers/feathersServices'
import StatusView from './StatusView'

const mapStateToProps = state => ({
  currentUser: state.currentUser,
  statuses: state.statuses.queryResult ? state.statuses.queryResult.data : [],
  loaded: state.statuses.isFinished
})

const mapDispatchToProps = dispatch => {
  return {
    loadStatuses: () => dispatch(services.status.find())
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(StatusView)
