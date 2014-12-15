require "spec_helper.rb"

describe AuthorizedKeys do

  it "returns a team_ids array" do
    expect(AuthorizedKeys.config.team_ids).to eq([])
  end

  it "can be configured" do
    AuthorizedKeys.configure { |c|
      c.team_ids = [1]
      c.auth_token = "123"
      c.file_path = "/home/ubuntu/.ssh/authorized_keys"
    }
    expect(AuthorizedKeys.config.team_ids).to eq([1])
    expect(AuthorizedKeys.config.auth_token).to eq("123")
    expect(AuthorizedKeys.config.file_path).to eq(
      "/home/ubuntu/.ssh/authorized_keys"
    )
  end

  describe "#go" do
    context "without a config" do
      it do
        expect(AuthorizedKeys.go).to eq("invalid_config")
      end
    end


    context "with a config " do
      before do
        AuthorizedKeys.configure { |c| c.org_name = "blah"; c.team_ids = [1];
                                       c.auth_token = "123"; c.file_path = "/home/ubuntu/.ssh/authorized_keys" }
      end

      it do
        body = [
                  {"login"=>"tatums",
                  "id"=>72979,
                  "avatar_url"=>"https://avatars.githubusercontent.com/u/72979?v=3",
                  "gravatar_id"=>"",
                  "url"=>"https://api.github.com/users/tatums",
                  "html_url"=>"https://github.com/tatums",
                  "followers_url"=>"https://api.github.com/users/tatums/followers",
                  "following_url"=>"https://api.github.com/users/tatums/following{/other_user}",
                  "gists_url"=>"https://api.github.com/users/tatums/gists{/gist_id}",
                  "starred_url"=>"https://api.github.com/users/tatums/starred{/owner}{/repo}",
                  "subscriptions_url"=>"https://api.github.com/users/tatums/subscriptions",
                  "organizations_url"=>"https://api.github.com/users/tatums/orgs",
                  "repos_url"=>"https://api.github.com/users/tatums/repos",
                  "events_url"=>"https://api.github.com/users/tatums/events{/privacy}",
                  "received_events_url"=>"https://api.github.com/users/tatums/received_events",
                  "type"=>"User",
                  "site_admin"=>false}
        ].to_json
        stub_request(:get, "https://api.github.com/teams/1/members").to_return(:status => 200, :body =>body, :headers => {})

        body = [{"id"=>3309134,
                   "key"=>
           "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDzY3zHSKRMG7HwbR1AvHIQ1/NtvGoaoLRyvgU5NPjFSWNNSuJ+GMTp/42JzOWnE+GcpO/w5a61IzC6WX1npjlHiqu8MJqNTRmejNqZIpbMbnD7a5A1M+Pk6Qx/zHjeXiPNlxv1TO9X8s/kxyMt+BvQAk/tB8yd3ckSYMuXZCIrYkS8oDVLzffdx5CwkgQXet3u+GYgga9GkNuKTZahUshrXz87en3zFK0yHOE0Wz7zp6Puu1f1TxUQh0r6TihCo0U+wp2cFNfV2yoLh5717QcxUPpp28+drQYIfAdwI1K8nTWA3/DFsSoUu+2rwdF1zzg2ZpHpCCziIp44tICCYjJP"}
        ].to_json
        stub_request(:get, "https://api.github.com/user/72979/keys").to_return(:status => 200, :body =>body, :headers => {})
        expect(File).to receive(:open)
        expect(File).to receive(:chmod).and_return 1
        expect(AuthorizedKeys.go).to eq("success™")
      end

      it do
        body = [
                  {"login"=>"tatums",
                  "id"=>72979,
                  "avatar_url"=>"https://avatars.githubusercontent.com/u/72979?v=3",
                  "gravatar_id"=>"",
                  "url"=>"https://api.github.com/users/tatums",
                  "html_url"=>"https://github.com/tatums",
                  "followers_url"=>"https://api.github.com/users/tatums/followers",
                  "following_url"=>"https://api.github.com/users/tatums/following{/other_user}",
                  "gists_url"=>"https://api.github.com/users/tatums/gists{/gist_id}",
                  "starred_url"=>"https://api.github.com/users/tatums/starred{/owner}{/repo}",
                  "subscriptions_url"=>"https://api.github.com/users/tatums/subscriptions",
                  "organizations_url"=>"https://api.github.com/users/tatums/orgs",
                  "repos_url"=>"https://api.github.com/users/tatums/repos",
                  "events_url"=>"https://api.github.com/users/tatums/events{/privacy}",
                  "received_events_url"=>"https://api.github.com/users/tatums/received_events",
                  "type"=>"User",
                  "site_admin"=>false}
        ].to_json
        stub_request(:get, "https://api.github.com/teams/1/members").to_return(:status => 200, :body =>body, :headers => {})

        body = [{"id"=>3309134,
                   "key"=>
           "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDzY3zHSKRMG7HwbR1AvHIQ1/NtvGoaoLRyvgU5NPjFSWNNSuJ+GMTp/42JzOWnE+GcpO/w5a61IzC6WX1npjlHiqu8MJqNTRmejNqZIpbMbnD7a5A1M+Pk6Qx/zHjeXiPNlxv1TO9X8s/kxyMt+BvQAk/tB8yd3ckSYMuXZCIrYkS8oDVLzffdx5CwkgQXet3u+GYgga9GkNuKTZahUshrXz87en3zFK0yHOE0Wz7zp6Puu1f1TxUQh0r6TihCo0U+wp2cFNfV2yoLh5717QcxUPpp28+drQYIfAdwI1K8nTWA3/DFsSoUu+2rwdF1zzg2ZpHpCCziIp44tICCYjJP"}
        ].to_json
        stub_request(:get, "https://api.github.com/user/72979/keys").to_return(:status => 200, :body =>body, :headers => {})
        AuthorizedKeys.configure { |c|
          c.org_name = "blah"
          c.team_ids = [1]
          c.auth_token = "123"
          c.file_path = "/home/ubuntu/.ssh/authorized_keys"
        }
        expect(File).to receive(:open)
        expect(File).to receive(:chmod).and_return 0
        expect(AuthorizedKeys.go).to eq("failure")
      end
    end


    end

end
