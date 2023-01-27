# frozen_string_literal: true

module Components
  class MarkdownCodeBlock < Phlex::HTML
    def initialize(parsed, lang, filename)
      @parsed = parsed
      @lang = lang
      @filename = filename
    end

    def template
      div class: "code-block" do
        div(class: "code-label") { label } if lang.present?
        pre do
          code class: "code-highlight" do
            unsafe_raw parsed
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
