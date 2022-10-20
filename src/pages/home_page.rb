# frozen_string_literal: true

module Pages
  class HomePage < ApplicationPage
    def initialize(posts)
      @posts = posts
    end

    def path
      "index.html"
    end

    def template
      render Layout.new("home") do
        render HomeSection.new do
          h2(style: "margin-top: 0;") { "posts" }
          posts.each do |post|
            h3 { a post.title, href: "/posts/#{post.slug}.html" }
            p { strong post.date }
          end
        end

        hr

        render HomeSection.new do
          h2 "projects"
          render Projects.new
        end

        hr

        render HomeSection.new do
          h2 "ideas"
          render Ideas.new
        end
      end
    end

    private

    attr_reader :posts

    def ideas
      @ideas ||= File.read("./ideas.md")
    end
  end
end
