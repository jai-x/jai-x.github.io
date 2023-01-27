# frozen_string_literal: true

module Components
  class Markdown < Phlex::HTML
    def initialize(content)
      @content = content
    end

    def template
      unsafe_raw markdown.render(content)
    end

    private

    attr_reader :content

    def markdown
      Redcarpet::Markdown.new(CustomRedcarpetRenderer, REDCARPET_OPTIONS)
    end

    REDCARPET_OPTIONS = {
      tables: true,
      fenced_code_blocks: true,
      footnotes: true,
      autolink: true,
    }.freeze

    class CustomRedcarpetRenderer < Redcarpet::Render::HTML
      include Rouge::Plugins::Redcarpet

      def block_code(code, lang)
        lang, filename = lang&.split(":")
        parsed = super(code, lang)
        MarkdownCodeBlock.new(parsed, lang, filename).call
      end

      def rouge_formatter(_lexer)
        Rouge::Formatters::HTML.new
      end
    end
  end
end
