# frozen_string_literal: true

module Pages
  class ApplicationPage < Phlex::HTML
    include Components

    def path
      raise NotImplementedError, "#{self.class} must implement method #path"
    end
  end
end
