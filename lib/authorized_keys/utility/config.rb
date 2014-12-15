module AuthorizedKeys
  class Config
    attr_accessor :org_name, :auth_token, :team_ids, :file_path, :verbose

    def initialize
      @team_ids   = []
      @verbose    = false
    end

  end
end
