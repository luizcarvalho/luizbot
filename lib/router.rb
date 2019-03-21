module LuizBot
  class Router
    RouteRule = Struct.new(
      :pattern,
      :action,
      :options
    )

    def self.match(pattern, action:, options: {})
      puts "creating route #{pattern}"
      routes << RouteRule.new(pattern, action,  options)
    end

    def self.routes
      @@routes ||= []
    end

    def self.dispatch(bot, text_message)
      matcheds = routes.map do |rule|
        if matches_pattern?(rule.pattern, text_message.text)
          Handler.send(rule.action, bot, text_message)
        end
      end

      if matcheds.any?
        true
      else
        Handler.send(:default, bot, text_message)
        false
      end

    end

    def self.matches_pattern?(pattern, text_message)
      pattern === text_message
    end

  end
end
