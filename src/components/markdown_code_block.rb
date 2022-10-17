# frozen_string_literal: true

module Components
  class MarkdownCodeBlock < Phlex::View
    def initialize(parsed, lang, filename)
      @parsed = parsed
      @lang = lang
      @filename = filename
    end

    def template
      div class: "code-block" do
        div(class: "code-label")  { label }
        pre do
          code class: "code-highlight" do
            raw parsed
          end
        end
      end
    end

    private

    attr_reader :parsed, :lang, :filename

    def label
      filename.present? ? filename : "#{lang.capitalize} code"
    end
  end
end
