# frozen_string_literal: true

require_relative 'lib/cucumber_tags/version'

Gem::Specification.new do |s|
  s.name = 'cucumber_tags'
  s.version = CucumberTags::VERSION::STRING
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 3.0.0'
  s.authors = ['Fikri Ramadhan']
  s.description = <<-DESCRIPTION
    It aims to filter which feature have specific tags.
  DESCRIPTION

  s.email = 'fire_a2003@yahoo.com'
  s.files = Dir.glob('{lib}/**/*', File::FNM_DOTMATCH)
  s.extra_rdoc_files = ['README.md']
  s.homepage = 'https://github.com/boseagr/cucumber_tags'
  s.licenses = ['CC-BY-NC-2.5']
  s.summary = 'Automatic case id checking tool.'

  s.metadata = {
    'homepage_uri' => 'https://github.com/boseagr/cucumber_tags',
    'changelog_uri' => 'https://github.com/boseagr/cucumber_tags/CHANGELOG.md',
    'source_code_uri' => 'https://github.com/boseagr/cucumber_tags',
    'rubygems_mfa_required' => 'true'
  }

  s.add_runtime_dependency('cucumber', '~> 3.1.2')
end
