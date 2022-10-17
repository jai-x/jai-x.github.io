# frozen_string_literal: true

module Components
  class Ideas < Phlex::View
    EMOJIS = [
      NOT_DONE    = "📝",
      IN_PROGRESS = "🚧",
      DONE        = "✅",
      UNKNOWN     = "❓",
    ].freeze

    def template
      p do
        ideas.each do |(status, line)|
          div(class: "idea-row") do
            span(class: "idea-emoji") { status }
            span line
          end
        end
      end
    end

    private

    def ideas
      @ideas ||= File.readlines("./ideas.md").map do |line|
        line.strip!

        next [NOT_DONE, line] if line.delete_prefix!("- [ ] ")
        next [IN_PROGRESS, line] if line.delete_prefix!("- [~] ")
        next [DONE, line] if line.delete_prefix!("- [x] ")

        [UNKNOWN, line]
      end
    end
  end
end
