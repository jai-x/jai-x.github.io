# frozen_string_literal: true

module Pages
  class CvPage < ApplicationPage
    def path
      "cv.html"
    end

    def template
      render Layout.new("cv") do
        add_cv_css

        render Grid.new(
          tl: cv[:info][:name],
          tr: '',
          bl: cv[:info][:website],
          br: cv[:info][:email],
        )

        render Section.new("Experience") do
          cv[:experience].each do |work|
            render WorkSection.new(work)
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
          end
        end

        render Section.new("Projects") do
          cv[:projects].each do |project|
            div class: "cv-info" do
              h3 class: "cv-info-title" do
                text "#{project[:name]} "
                text "("
                a(href: project[:link]) { project[:link].delete_prefix("https://") } if project[:link]
                text ")"
              end
              p class: "cv-info-para" do
                project[:summary]
              end
            end
          end
        end

        render Section.new("Programming Skills") do
          cv[:skills].each do |skill|
            div class: "cv-info" do
              h3 class: "cv-info-title" do
                skill[:key]
              end
              p class: "cv-info-para" do
                skill[:values].join(", ")
              end
            end
          end
        end
      end
    end

    private

    def cv
      @cv ||= YAML.load_file('./cv.yml', symbolize_names: true)
    end

    def add_cv_css
      style do
        raw PAGE_CSS
      end
      style media: "print" do
        raw PRINT_CSS
      end
    end

    PAGE_CSS = <<~CSS
      .cv-grid {
        margin-bottom: var(--spacing);
      }

      .cv-grid-row {
        display: flex;
        flex-direction: row;
        align-items: center;
        justify-content: space-between;
      }

      .cv-grid-row > * {
        margin: 0;
      }

      .cv-grid-row:last-child {
        text-align: right;
      }

      .cv-section-header {
        margin: var(--spacing) 0;
      }

      .cv-section-title {
        text-transform: uppercase;
        margin: 0;
      }

      .cv-section-divider {
        width: 100%;
        border-top: 2px solid var(--color-divider);
      }

      .cv-work-details {
        margin: var(--spacing) 0;
      }

      .cv-work-details-list {
        padding-left: 2ch;
        margin: 0;
      }

      .cv-info {
        margin: var(--spacing) 0;
      }

      .cv-info-title {
        margin: 0;
      }

      .cv-info-para {
        margin: 0;
      }
    CSS

    PRINT_CSS = <<~CSS
      @page {
        size: A4;
        padding: 0;
        margin: 0;
      }

      :root {
        --content-width: 100%;
        --content-text-size: 12px;
        --spacing: 10px;
      }

      html {
        margin: 0;
        padding: 0;
      }

      body {
        margin: 0;
        padding: 0;
      }

      main {
        margin-top: 25px;
        margin-left: auto;
        margin-right: auto;
        padding: 0;
        width: 90%;
      }

      nav {
        display: none;
      }

      .cv-info-title > a{
        color: unset;
      }
    CSS

    class Grid < Phlex::View
      def initialize(tl:, tr:, bl:, br:)
        @tl, @tr, @bl, @br = tl, tr, bl, br
      end

      def template
        div class: "cv-grid" do
          div class: "cv-grid-row" do
            h3 @tl
            span @tr
          end
          div class: "cv-grid-row" do
            span @bl
            span @br
          end
        end
      end
    end

    class Section < Phlex::View
      def initialize(title)
        @title = title
      end

      def template(&b)
        div class: "cv-section-header" do
          h3(class: "cv-section-title") { @title }
          div class: "cv-section-divider"
        end
        yield_content(&b)
      end
    end

    class WorkSection < Phlex::View
      def initialize(work)
        @work = work
      end

      def template
        div class: "cv-work-details" do
          render Grid.new(
            tl: @work[:company],
            tr: @work[:location],
            bl: @work[:position],
            br: "#{@work[:start_date]} - #{@work[:end_date]}",
          )
          ul class: "cv-work-details-list" do
            @work[:details].each do |item|
              li(class: "cv-work-details-list-item") { item }
            end
          end
        end
      end
    end
  end
end
