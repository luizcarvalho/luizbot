require_relative '../lib/router'

class Routes < LuizBot::Router
  match(%r{/get}, action: 'fetch_data')
  match(%r{/set}, action: 'send_data')
  match(%r{/list}, action: 'list_options')
  match(%r{/update}, action: 'update_data')
  match(Promoluiz::DETECT_REGEX, action: 'amazon_promotion')
  match(GasotocaWrapper::DETECT_REGEX, action: 'gasotoca')
end
