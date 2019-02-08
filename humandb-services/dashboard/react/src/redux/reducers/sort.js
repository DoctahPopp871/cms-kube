export default (state = {
  user: { createdAt: -1 }
}, action) => {
  switch (action.type) {
    case 'SET_SORT':
      return Object.assign({}, state, { [action.model]: action.sort })
    default:
      return state
  }
}
