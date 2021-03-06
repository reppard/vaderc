# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vaderc/version'

Gem::Specification.new do |spec|
  spec.name          = 'vaderc'
  spec.version       = Vaderc::VERSION
  spec.authors       = ['Reppard Walker']
  spec.email         = ['reppardwalker@gmail.com']

  spec.summary       = 'Write a short summary, because Rubygems requires one.'
  spec.description   = 'Write a longer description or delete this line.'
  spec.homepage      = 'https://github.com/reppard/vaderc'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`
                       .split("\x0").reject do |f|
                         f.match(%r{^(test|spec|features)/})
                       end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.executables << 'vaderc'

  spec.add_development_dependency 'bundler',       '~> 1.10'
  spec.add_development_dependency 'guard',         '~> 2.13'
  spec.add_development_dependency 'guard-rspec',   '~> 4.6.4'
  spec.add_development_dependency 'guard-rubocop', '~> 1.2'
  spec.add_development_dependency 'guard-bundler', '~> 2.1'
  spec.add_development_dependency 'rake',          '~> 10.0'
  spec.add_development_dependency 'rspec',         '~> 3.4'
  spec.add_development_dependency 'rubocop',       '~> 0.37'
  spec.add_development_dependency 'simplecov',     '~> 0.11.2'

  spec.add_runtime_dependency 'curses', '~> 1.0.1'
end
