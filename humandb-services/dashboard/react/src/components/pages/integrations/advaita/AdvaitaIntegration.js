import { connect } from 'react-redux'
import { push } from 'react-router-redux'

import AdvaitaIntegrationView from './AdvaitaIntegrationView'

const mapStateToProps = state => ({
  currentUser: state.currentUser
})

const mapDispatchToProps = dispatch => {
  return {
    routeTo: path => dispatch(push(path))
  }
}

export default connect(mapStateToProps, mapDispatchToProps)(AdvaitaIntegrationView)
