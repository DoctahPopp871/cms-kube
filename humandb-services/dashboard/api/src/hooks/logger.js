// A hook that logs service method before, after and error
const logger = require('winston')

module.exports = () =>
  hook => {
    if (hook.app.get('logging') === 'disabled') { return }

    let message = `${hook.type}: ${hook.path} - Method: ${hook.method}`

    if (hook.type === 'error') {
      message += `: ${hook.error.message}`
    }

    logger.info(message)
    logger.debug('hook.data', hook.data)
    logger.debug('hook.params', hook.params)

    if (hook.result) {
      logger.debug('hook.result', hook.result)
    }

    if (hook.error) {
      logger.error(hook.error.toString().substring(0, 500))
    }
  }
