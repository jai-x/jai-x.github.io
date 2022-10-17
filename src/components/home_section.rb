# frozen_string_literal: true

module Components
  class HomeSection < Phlex::View
    def template(&block)
      section class: "home-section" do
        yield_content(&block)
      end
    end
  end
end
