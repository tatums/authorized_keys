module AuthKeys
  class << self
    attr_writer :configuration
  end

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)
  end

end
