Gem::Specification.new do |gem|
  gem.name    = 'tolk'
  gem.version = '0.2.2'
  gem.date    = Time.now.strftime('%Y-%m-%d')

  gem.add_dependency 'ya2yaml', '~> 0.29.2'
  gem.add_dependency 'will_paginate', '~> 2.3.13'
  # gem.add_development_dependency 'rspec', '~> 1.2.9'

  gem.summary = "Tolk, the Rails translation engine"
  gem.description = "Tolk is a Rails engine designed to facilitate the translators doing the dirty work of translating your application to other languages."

  gem.authors  = ['David Heinemeier Hansson', 'Pratik Naik']
  gem.email    = 'david@loudthinking.com'
  gem.homepage = 'http://github.com/dhh/tolk'

  gem.rubyforge_project = nil
  gem.has_rdoc = true
  gem.rdoc_options = ['--main', 'README', '--charset=UTF-8']
  gem.extra_rdoc_files = ['README', 'MIT-LICENSE']

  gem.files = Dir['Rakefile', '{app,generators,lib,test}/**/*', 'README*', 'MIT-LICENSE*']
  gem.files &= `git ls-files -z`.split("\0") if `type -t git 2>/dev/null || which git 2>/dev/null` && $?.success?
end
