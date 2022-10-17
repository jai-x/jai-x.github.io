# frozen_string_literal: true

module Pages
  class PostPage < ApplicationPage
    def initialize(post)
      @post = post
    end

    def path
      "posts/#{post.slug}.html"
    end

    def template
      render Layout.new(post.title) do
        render Markdown.new(post.markdown)
      end
    end

    private

    attr_reader :post
  end
end
