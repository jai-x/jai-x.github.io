# frozen_string_literal: true

module Components
  class HomeSection < Phlex::View
    def initialize(title)
      @title = title
    end

    def template(&block)
      section class: "home-section" do
        h2 { @title }
        yield_content(&block)
        hr
      end
    end
  end
end
