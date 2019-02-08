import { connect } from 'react-redux'
import { push } from 'react-router-redux'
import HeaderView from './HeaderView'

const mapStateToProps = (state, ownProps) => {
  return {
    currentUser: state.currentUser,
    router: state.router
  }
}

const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    routeTo (path) { dispatch(push(path)) },
    logout: () => dispatch({ type: 'LOGOUT' })
  }
}

const Header = connect(
  mapStateToProps,
  mapDispatchToProps
)(HeaderView)

export default Header
