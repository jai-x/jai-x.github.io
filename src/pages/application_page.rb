# frozen_string_literal: true

module Pages
  class ::Phlex::View
    register_element :hr
  end

  class ApplicationPage < Phlex::View
    include Components

    def path
      raise NotImplementedError
    end
  end
end
