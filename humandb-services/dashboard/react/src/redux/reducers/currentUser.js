export default (state = {}, action) => {
  switch (action.type) {
    case 'LOGIN':
      return Object.assign({}, { isSaving: true })

    case 'LOGIN_SUCCESS':
      return Object.assign({}, action.user, { accessToken: action.accessToken })
    case 'SET_CURRENT_USER':
      return Object.assign({}, state, action.user)

    case 'SERVICES_USER_PATCH_FULFILLED':
      return Object.assign({}, state, action.payload)

    case 'LOGIN_ERROR':
      return { error: action.error.message }

    case 'LOGOUT':
      return {}

    default:
      return state
  }
}
