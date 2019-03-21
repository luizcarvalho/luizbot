require 'firebase'

module LuizBot
  class FBase

    def initialize
      base_uri = ENV['FIREBASE_URL']
      @firebase = Firebase::Client.new(base_uri)
    end

    def client
      @firebase
    end

  end
end