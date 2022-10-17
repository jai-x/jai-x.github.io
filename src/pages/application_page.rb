# frozen_string_literal: true

module Pages
  class ApplicationPage < Phlex::View
    include Components

    def path
      raise NotImplementedError
    end

    private

    def hr
      raw "<hr align=\"left\">"
    end
  end
end
