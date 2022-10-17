# frozen_string_literal: true

class Website
  def generate(with_drafts: false)
    posts = with_drafts ? all_posts : all_posts.reject { |post| post.draft? }

    make_pages(posts).each { |page| writer.write page }
  end

  def clean
    make_pages(all_posts).each { |page| writer.delete page }
  end

  private

  def make_pages(posts)
    [
      Pages::NotFoundPage.new,
      Pages::HomePage.new(posts),
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
