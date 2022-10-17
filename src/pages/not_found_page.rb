# frozen_string_literal: true

module Pages
  class NotFoundPage < ApplicationPage
    def path
      "404.html"
    end

    def template
      render Layout.new("404") do
        h1 "404"
        p "Page not found"
      end
    end
  end
end
