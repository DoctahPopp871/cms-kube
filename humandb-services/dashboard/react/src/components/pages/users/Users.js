import { connect } from 'react-redux'
import { push } from 'react-router-redux'

import services from 'lib/feathers/feathersServices'
import UsersView from './UsersView'

const mapStateToProps = state => ({
  currentUser: state.currentUser,
  users: state.user.queryResult ? state.user.queryResult.data : [],
  page: state.page.user,
  search: state.search.user,
  queryResult: { users: state.user.queryResult || { total: 0, limit: 0 } },
  loaded: state.user.isFinished
})

const mapDispatchToProps = dispatch => {
  return {
    routeTo: path => dispatch(push(path)),
    loadUsers: () => dispatch(services.user.find()),
    removeUser: id => dispatch(services.user.remove(null, { query: { id } })),
    setPage: page => dispatch({ type: 'SET_PAGE', model: 'user', page }),
    setSort: sort => dispatch({ type: 'SET_SORT', model: 'user', sort }),
    setSearch: search => dispatch({ type: 'SET_SEARCH', model: 'user', search })
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(UsersView)
