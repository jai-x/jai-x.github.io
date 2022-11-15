# frozen_string_literal: true

module Components
  class Projects < Phlex::HTML
    def template
      render Markdown.new(projects)
    end

    private

    def projects
      @projects ||= File.read("./projects.md")
    end
  end
end
