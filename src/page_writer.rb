# frozen_string_literal: true

class PageWriter
  def initialize(prefix: "./")
    @prefix = prefix
  end

  def write(view)
    path = File.join(prefix, view.path)

    File.open(path, "w") do |file|
      file.write(view.call)
      puts "Rendered page: #{path}"
    end
  end

  def delete(view)
    path = File.join(prefix, view.path)

    FileUtils.rm(path)
    puts "Deleted page: #{path}"
  rescue => e
    puts e
  end

  private

  attr_reader :prefix
end

