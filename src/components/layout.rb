# frozen_string_literal: true

module Components
  class Layout < Phlex::View
    def initialize(title)
      @title_text = title
    end

    def template(&block)
      doctype

      html do
        head do
          meta charset: "utf-8"
          meta name: "viewport", content: "width=device-width, initial-scale=1"
          link rel: "preload", href: "/static/roboto_slab_regular.ttf", as: "font", crossorigin: true
          link rel: "preload", href: "/static/fira_code_regular.ttf", as: "font", crossorigin: true
          link rel: "stylesheet", href: "/static/main.css"
          title { "#{title_text} | jai.moe" }
        end

        body do
          nav do
            div class: "nav-items" do
              a(href: "/") { "jai.moe" }
              a(href: "https://twitter.com/jai_1337") { "twitter" }
              a(href: "https://github.com/jai-x") { "github" }
              a(href: "https://github.com/jai-x/jai-x.github.io") { "source" }
              a(href: "mailto:jai@jai.moe") { "email" }
              a(href: "/cv.html") { "cv" }
            end
            div class: "nav-line"
          end

          main { yield_content(&block) }
        end
      end
    end

    private

    attr_reader :title_text
  end
end
