#!/usr/bin/env ruby

# frozen_string_literal: true

$stdout.sync = true

require "bundler"

Bundler.require

loader = Zeitwerk::Loader.new

loader.ignore(__FILE__)
loader.push_dir(__dir__)
loader.enable_reloading
loader.setup
loader.eager_load

website = Website.new

case ARGV.first&.strip
when "--with-drafts"
  website.generate(with_drafts: true)
when "--clean"
  website.clean
when "--watch"
  website.generate(with_drafts: true)
  Filewatcher.new("./posts/").watch do |changes|
    website.generate(with_drafts: true)
  end
else
  website.generate
end
