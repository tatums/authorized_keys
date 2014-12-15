module AuthorizedKeys
  class Team
    include Virtus.model
    attribute :id, Integer
    attribute :name, String

    def self.all
      Request.get("https://api.github.com/orgs/#{AuthorizedKeys.config.org_name}/teams").map do |attr|
        self.new(attr)
      end
    end

    def details
      Request.get "https://api.github.com/teams/#{id}"
    end

    def members
      @members ||= begin
                      Request.get("https://api.github.com/teams/#{id}/members").map do |attr|
                        Member.new(attr)
                      end
                    end
    end

    def keys
      members.map do |m|
        puts "Key found for #{m.login}" if AuthorizedKeys.config.verbose
        m.keys.map { |k| "#{k["key"]} #{m.login}" }
      end.flatten
    end

  end
end
