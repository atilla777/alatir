require_relative 'lib/alatir/version'

Gem::Specification.new do |spec|
  spec.name          = "alatir"
  spec.version       = Alatir::VERSION
  spec.authors       = ["Alexey Slivka"]
  spec.email         = ["slivka77@inbox.ru"]

  spec.summary       = %q{Alarmist attack incident response.}
  spec.description   = %q{Alarmist attack incident response (AlAtIr) is the library (and CLI app) for test security app and devices to know is they are worked?.}
  spec.homepage      = "https://github.com/atilla777/alatir"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/atilla777/alatir"
  spec.metadata["changelog_uri"] = "https://github.com/atilla777/alatir/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "winrm", ["= 2.3.4"]
  spec.add_runtime_dependency "net-ssh", ["= 6.1.0"]
end
