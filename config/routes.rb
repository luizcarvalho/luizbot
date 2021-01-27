require_relative '../lib/router'

class Routes < LuizBot::Router
  match(/\/get/, action: 'fetch_data')
  match(/\/set/, action: 'send_data')
  match(/\/list/, action: 'list_options')
  match(/\/update/, action: 'update_data')
  match(Promoluiz::DETECT_REGEX, action: 'amazon_promotion')
end
