require 'firebase'

module LuizBot
  class FBase

    def initialize
      base_uri = ENV['FIREBASE_URL']
      @firebase = Firebase::Client.new(base_uri)
    end

    def run
      response = @firebase.push("todos", { :name => 'Pick the milk', :'.priority' => 1 })
      response.success? # => true
      response.code # => 200
      response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
      response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'
    end

  end
end