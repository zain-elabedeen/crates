
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crates/version'

Gem::Specification.new do |spec|
  spec.name          = 'crates'
  spec.version       = Crates::VERSION
  spec.authors       = ['Zain']
  spec.email         = ['elabedeen.zain@gmail.com']

  spec.summary       = 'Write a short summary, because RubyGems requires one.'
  spec.description   = 'Write a longer description or delete this line.'
  spec.homepage      = ''

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'faraday', '~> 0.15'
  spec.add_development_dependency 'faraday_middleware'
  spec.add_development_dependency 'thor', '~> 0.20'

  spec.add_development_dependency 'byebug'
end
