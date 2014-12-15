module AuthorizedKeys
  class Request
    def self.get(string)
      uri = URI.parse(string)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(uri.request_uri)
      request.add_field("Authorization", "token #{AuthorizedKeys.config.auth_token}")
      response = http.request(request)
      JSON.parse(response.body)
    end
  end
end
