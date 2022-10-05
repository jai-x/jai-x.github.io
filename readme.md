# jai.moe

My slightly overcomplicated static site

## requirements

- Install `asdf` version manager
- Use `asdf` to install `ruby`
- Use `bundle install` to install the required gems

## running

- Run `./bin/generate` to generate the website inside the `./www` directory
- Run `./bin/serve` to serve the `./www` directory on `localhost:8080`

## structure

- `./ideas.md`: place to put ideas
- `./bin`: ruby scripts to generate and run the website
- `./posts`: mardown source files to generate website posts
- `./www`: website generation output dir
- `./www/static`: website static files like fonts and css
- `./www/misc`: website content that isn't auto-generated, needs to be manually linked
