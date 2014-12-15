module AuthorizedKeys
  class Org
    include Virtus.model
    attribute :id, Integer
    attribute :name, String

    def self.details
      Request.get("https://api.github.com/orgs/#{AuthorizedKeys.config.org_name}")
    end

    def self.teams
      data = Request.get("https://api.github.com/orgs/#{AuthorizedKeys.config.org_name}/teams")
      data.map do |attr|
        Team.new(attr)
      end
    end

  end
end
