require "net/http"
require "uri"
require "json"
require "virtus"
require_relative "auth_keys/version"
require_relative "auth_keys/utility/request"
require_relative "auth_keys/utility/config"
require_relative "auth_keys/utility/main"
require_relative "auth_keys/github/org"
require_relative "auth_keys/github/team"
require_relative "auth_keys/github/member"

module AuthKeys

  def self.go
    return "invalid_config" if invalid_config
    if keys.empty?
      "No keys to write. Make sure your config is setup correctly"
    else
      puts "Writing keys to file: #{AuthKeys.config.file_path}" if AuthKeys.config.verbose
      File.open(AuthKeys.config.file_path, 'w') do |file|
        keys.each { |key| file.puts key}
      end
      if File.chmod(0644, AuthKeys.config.file_path) == 1
        "success™"
      else
        "failure"
      end
    end
  end

  private
    # Returns an array of strings.
    # Each line will be written to the authorized_keys file.
    #
    # For example
    # [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCq6H5sIqrU17t7a89gokyybToDwr67U7t590IdV1WaMDEHnc+X7dEETYnh4jpHI5IiZ/b+H1L4Zl2b6MbifVqzBgu3Ua2ZzWsDYlFIkGagN5ZcHvWIlVev0r7hzRi5wWRjz/VbeI7BHtkGQ08lQ9uMU40yguojrfrtDEgh1xQoQ41FJoswFAfwzzUG1cqUTmptZthsw6NeSHMvs4rbxASuBveE45du3FFE5U0XyZje3nr/Ahp+tSWnBYJxkjZcfUPQ+YTTk8QPFH4HDVE+H7FOLW5exp+g1lLLpm1NUDIngr8jM7aZzfDuCbtp5WYGZ6HAEbS6pEuJQVASnD5CMwpf cabm"]
    def self.keys
      @keys ||= AuthKeys.config.team_ids.map do |id|
        team = Team.new(id: id)
        puts "Team: #{team.details["name"]}" if AuthKeys.config.verbose
        team.keys
      end.flatten.uniq
    end

    def self.invalid_config
       [
         AuthKeys.config.org_name.nil?,
         AuthKeys.config.auth_token.nil?,
         AuthKeys.config.team_ids.empty?,
         AuthKeys.config.file_path.nil?
       ].include?(true)
    end
end
