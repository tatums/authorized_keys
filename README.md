# AuthorizedKeys

Pull public ssh keys from a github team and write them to an authorized_keys file. This is good for granting access to a server.

## Installation

Add this line to your application's Gemfile:

```
gem 'authorized_keys'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install authorized_keys


## Usage

```ruby
AuthorizedKeys.configure do |c| 
    c.org_name = "AwesomeOrg"
    c.auth_token="asdfasdf12341234123412341234"; 
    c.team_ids = [123456, 123457]; 
    c.file_path = "/home/ubuntu/.ssh/authorized_keys" 
end
```

Assuming your config is valid.  The go method will write all keys to the file specified in the config

```ruby
AuthorizedKeys.go
=> "success™"
```

## Examples
```ruby
pry(main)> require "./lib/authorized_keys"
=> true
```



### AuthorizedKeys::Org
```ruby
AuthorizedKeys::Org.details
AuthorizedKeys::Org.teams
```

### AuthorizedKeys::Team
```ruby
AuthorizedKeys::Team.new(id: 687081).details
AuthorizedKeys::Team.new(id: 687081).members
AuthorizedKeys::Team.new(id: 687081).keys
```

### AuthorizedKeys::Member
```ruby
AuthorizedKeys::Member.new(id: 72979).details
AuthorizedKeys::Member.new(id: 72979).keys
```


## Contributing

1. Fork it ( https://github.com/[my-github-username]/authorized_keys/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
