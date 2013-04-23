Gem::Specification.new do |s|
  s.name        = 'sentiwordnet_ruby'
  s.version     = '0.0.1'
  s.date        = '2013-04-23'
  s.summary     = "SentiWordNet 3.0"
  s.description = "A simple SentiWordNet utility for Ruby"
  s.authors     = ["Shailesh Kalamkar"]
  s.email       = 'shailesh.kalamkar@gmail.com'
  s.files        = Dir['lib/*'] << 'README.md'
  s.platform     = Gem::Platform::RUBY
  s.homepage    = 'https://github.com/kalamkar/sentiwordnet_ruby'
  s.require_path = '.'
  s.require_paths << 'lib'
end
