# frozen_string_literal: true

module Components
  class Markdown < Phlex::View
    def initialize(content)
      @content = content
    end

    def template
      raw markdown.render(content)
    end

    private

    attr_reader :content

    def markdown
      Redcarpet::Markdown.new(renderer, {
        tables: true,
        fenced_code_blocks: true,
        footnotes: true,
      })
    end

    def renderer
      # absolute memes to avoid making new classes
      @@renderer ||= Class.new(Redcarpet::Render::HTML) do
        include Rouge::Plugins::Redcarpet

        def block_code(code, lang)
          lang, filename = lang.split(":")
          parsed = super(code, lang)
          MarkdownCodeBlock.new(parsed, lang, filename).call
        end

        def rouge_formatter(_lexer)
          Rouge::Formatters::HTML.new
        end
      end
    end
  end

end
