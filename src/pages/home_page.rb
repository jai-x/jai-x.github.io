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
        render HomeSection.new("posts") do
          posts.each do |post|
            h3 do
              a(href: "/posts/#{post.slug}.html") { post.title }
            end
            p do
              strong { post.date }
            end
          end
        end

        render HomeSection.new("projects") do
          render Projects.new
        end

        render HomeSection.new("ideas") do
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
