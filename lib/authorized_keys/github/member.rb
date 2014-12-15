module AuthorizedKeys
  class Member
    include Virtus.model
    attribute :id, Integer
    attribute :login, String

    def details
      Request.get "https://api.github.com/user/#{id}"
    end

    def keys
      Request.get "https://api.github.com/user/#{id}/keys"
    end

  end
end
