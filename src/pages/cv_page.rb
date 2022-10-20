# frozen_string_literal: true

module Pages
  class CvPage < ApplicationPage
    def path
      "cv.html"
    end

    def template
      render Layout.new("cv") do
        render Grid.new(
          tl: cv[:info][:name],
          tr: cv[:info][:email],
          bl: cv[:info][:website],
          br: cv[:info][:phone],
        )

        render Section.new("Experience") do
          cv[:experience].each do |work|
            render Grid.new(
              tl: work[:company],
              tr: work[:location],
              bl: work[:position],
              br: "#{work[:start_date]} - #{work[:end_date]}",
            )

            ul do
              work[:details].each do |point|
                li point
              end
            end
          end
        end

        render Section.new("Education") do
          cv[:education].each do |edu|
            render Grid.new(
              tl: edu[:institution],
              tr: edu[:location],
              bl: edu[:qualification],
              br: "#{edu[:start_date]} - #{edu[:end_date]}",
            )

            ul do
              edu[:details].each do |point|
                li point
              end
            end
          end
        end

        render Section.new("Projects") do
          cv[:projects].each do |project|
            h4 style: "margin-bottom: 0;" do
              text "#{project[:name]} "
              a(href: project[:link]) { "(link)" } if project[:link]
            end
            p style: "margin-top: 5px" do
              project[:summary]
            end
          end
        end

        render Section.new("Programming Skills") do
          cv[:skills].each do |skill|
            h4(style: "margin-bottom: 0;") { skill[:key] }
            p(style: "margin-top: 5px") { skill[:values].join(", ") }
          end
        end
      end
    end

    private

    def cv
      @cv ||= YAML.load_file('./cv.yml', symbolize_names: true)
    end

    class Grid < Phlex::View
      ROW_STYLE = <<~CSS
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-between;
      CSS

      def initialize(tl:, tr:, bl:, br:)
        @tl, @tr, @bl, @br = tl, tr, bl, br
      end

      def template
        div style: "margin-bottom: 15px" do
          div style: ROW_STYLE do
            h3(style: "margin: 0") { @tl }
            span(style: "text-align: right;") { @tr }
          end
          div style: ROW_STYLE do
            span @bl
            span(style: "text-align: right;") { @br }
          end
        end
      end
    end

    class Section < Phlex::View
      def initialize(title)
        @title = title
      end

      def template(&b)
        hr
        h3(style: "text-transform: uppercase;") { @title }
        hr
        yield_content(&b)
      end
    end
  end
end
