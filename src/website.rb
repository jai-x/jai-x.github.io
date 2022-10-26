# frozen_string_literal: true

class Website
  def self.generate(with_drafts: false)
    new(with_drafts: with_drafts).generate
  end

  def initialize(with_drafts: false)
    @with_drafts = with_drafts
  end

  def generate
    pages.each { |page| writer.write page }
  end

  private

  def pages
    posts = @with_drafts ? all_posts : all_posts.reject(&:draft?)

    @pages = make_pages(posts)
  end

  def make_pages(posts)
    [
      Pages::NotFoundPage.new,
      Pages::HomePage.new(posts),
      Pages::CvPage.new,
      *posts.map { |post| Pages::PostPage.new(post) },
    ].freeze
  end

  def all_posts
    @all_posts ||= Dir["./posts/*.md"]
                   .map { |src| Post.new(src) }
                   .sort
                   .reverse
  end

  def writer
    @writer ||= PageWriter.new(prefix: "./www")
  end
end
