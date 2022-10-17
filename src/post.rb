# frozen_string_literal: true

class Post
  attr_reader :markdown

  def initialize(md_path)
    @markdown = File.read(md_path)
  end

  def title
    @title ||= begin
      title = markdown.lines[0].gsub("#", "").strip.downcase
      draft? ? "[DRAFT] #{title}" : title
    end
  end

  def date
    @date ||= Date.parse(markdown.lines[1].gsub("*", "").strip)
  end

  def draft?
    @draft ||= markdown.lines[2].strip == "draft"
  end

  def slug
    @slug ||= title.parameterize
  end

  # Sort comparison by date
  def <=>(other)
    date <=> other.date
  end
end
