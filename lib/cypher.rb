require 'digest/sha2'
require 'drb/drb'
require 'json'
require 'yaml'

require 'daemons'
require 'gibberish'
require 'timers'
require 'thor'

require 'cypher/config'
require 'cypher/cli'
require 'cypher/client'
require 'cypher/password'
require 'cypher/repository'
require 'cypher/server'

$SAFE = 1

module Cypher

  def self.config
    @config ||= Config.new
  end

end
