# A look at esbuild
**2022-02-05**

I've recently made a [new small web project][crashfm] which requires some
Javascript. I did try initially to make it as simple as possible using only
vanilla JS but eventually making use of some libraries became necessary, for
both code quality and things like [animation][gsap]. Libraries and bundling
require build tooling and the Javascript ecosystem has far too much choice in
that front. From experience at work and some [other][wasd2020]
[projects][wasd2021] I've used both Webpack and Rollup but I wanted to try
something different that I had heard good things about: esbuild.

[esbuild][esbuild] is interesting in that it is very "batteries included"
compared to most other JS build tools. Its default install is capable of module
path resolving, bundling, tree shaking, minification, and sourcemaps all without
the needing to install plugins. Additional perks include an in-built dev server,
support for JSX, and support for Typescript. The main party trick is that it is
fast! Unlike most JS build tools, esbuild is not written in Javascript but in Go
and is distributed as a statically compiled binary executable with an optional
Javascript API. As a result, a single command line invocation of esbuild can
replace a more complex Webpack config with no additional plugins, and still be
much faster.

As an example here's the command I used to use for development on my current
project and a breakdown of what each part does:

```shell
$ esbuild src/app.js --outfile=./www/static/main.js --bundle --sourcemap --servedir=./www
```

- `esbuild`:  
  Invocation of the `esbuild` binary on the command line.

- `esbuild src/app.js --outfile=./www/static/main.js`:  
  Defining the entrypoint and output file,  with the outfile requiring an
  additional `--outfile` flag. My project is a static site with only the site
  JS needing transformation so I can output the bundle directly into the serve
  directory.

- `--bundle`:  
  Enables esbuild to resolve module imports and bundle them into the outfile.
  By default, using this flag will also activate [tree shaking][treeshaking]
  for all static module imports that esbuild is able to resolve and analyse.

- `--sourcemap`:  
  Enables output of a [source map][sourcemap] with the bundle, which makes
  debugging easier.

- `--servedir=./www`:  
  Enables esbuild to serve the contents of the specified directory on localhost.
  As my site is entirely static with only the JS needed transformation, this is
  handy as I can simply serve the entire output directory. When `--servedir` is
  combined with `--outfile`, any requests made to the server for the outfile
  will result in esbuild recompiling and returning the result it as the response
  on demand instead of serving a pre-generated file. This is in contrast to the
  common JS tooling pattern of having the dev server watch for source file
  changes to recompile and optionally use hot module reloading. This approach is
  explained more in the [docs][esbuildserve].


As another example here's the command I used to use for building for deployment
with different flags and a breakdown of what each part does:

```shell
$ esbuild src/app.js --outfile=./www/static/main.js --bundle --minify --legal-comments=none --drop:console --analyze
```

- `--minify`:  
  Performs [minification][minification] on the outfile.

- `--legal-comments=none`:  
  Strips any legal comments that are bundled with dependant libraries from the
  outfile.

- `--drop:console`:  
  Performs source code modification on outfile to remove any calls to the JS
  `console` API. I found this useful as I can leave in debug print statements in
  the source code and have them automatically removed on build.

- `--analyze`:  
  Provides a pretty printed output to console with a breakdown how each module
  resolved from the input source contributed to the final size of the outfile.

esbuild having all its options available via command line flags is quite handy,
especially when iterating and trying to find the correct setting for your
project. Even in the documentation, the command line flags are always presented
as the first choice for any configurable option. As such, you can just easily
just copy these command line invocations into your `package.json` scripts
section and have things up and running really quickly. Here's what that used to
look like for my project:

```json:package.json
{
  "scripts": {
    "dev": "esbuild src/app.js --outfile=./www/static/main.js --bundle --sourcemap --servedir=./www",
    "build": "esbuild src/app.js --outfile=./www/static/main.js --bundle --minify --legal-comments=none --drop:console --analyze"
  }
}
```

While these lines aren't the most unwieldy, they aren't the best to look at and
as with most tooling I wanted to move this to a config file that esbuild could
use instead. Unfortunately, one of esbuild's drawbacks as it does not support
using a config file. Instead esbuild chooses to expose a Javascript API to
invoke the core process so that you can write a script which can be used in
place of a config file. While this does indeed cover the use case of having the
configuration stored in it's own file, using the API has the side effect of
disabling the default console output which is something I found really useful.
As such, I ended up making a [simple script][esbuildparse] to read in a simple
JSON config file, parse it into the expected command line flags and then pipe
the result into the esbuild binary. As a result, my `package.json` file and
associated esbuild JSON config files now look like this:

```json:package.json
{
  "scripts": {
    "build": "./bin/esbuildParse.mjs ./esbuild.build.json | xargs esbuild",
    "dev": "./bin/esbuildParse.mjs ./esbuild.dev.json | xargs esbuild",
  }
}
```
```json:esbuild.dev.json
{
  "entry": "./src/app.js",
  "outfile": "./www/static/main.js",
  "bundle": true,
  "sourcemap": true,
  "servedir": "./www"
}
```
```json:esbuild.build.json
{
  "entry": "./src/app.js",
  "outfile": "./www/static/main.js",
  "bundle": true,
  "minify": true,
  "legal-comments": "none",
  "drop": "console",
  "analyze": true
}
```

Looking at npm, there do seem to be packages that provide this sort of
functionality to wrap the esbuild command with a config file, but I think I will
just stick with my simple script for now.

[crashfm]: https://crashfm.live
[gsap]: https://greensock.com/gsap/
[wasd2020]: https://github.com/jai-x/wasd2020
[wasd2021]: https://github.com/jai-x/wasd2021
[treeshaking]: https://en.wikipedia.org/wiki/Tree_shaking
[esbuild]: https://esbuild.github.io
[sourcemap]: https://developer.mozilla.org/en-US/docs/Tools/Debugger/How_to/Use_a_source_map
[esbuildserve]: https://esbuild.github.io/api/#serve
[minification]: https://en.wikipedia.org/wiki/Minification_(programming)
[esbuildparse]: https://github.com/jai-x/crashfm-dot-live/blob/main/bin/esbuildParse.mjs
