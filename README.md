# (simplified) Markdown to HTML Converter

# Parsing rules / presumptions

# Test

## Links
Will transform all markdown links from `[Some Link Name](https://google.com)` 
to `<a href="https://google.com" >Some Link Name</a>`

### callouts
#### Url protocol is optional and case-insensitive, but must be `http | https` if provided
So for example, the following will be converted: `http://google.com`, `https://google.com`, `HTTPS://google.com`, `google.com`
#### Url TLD must be 2+ characters, it isn't checking for real TLD 
This will be converted `[link](dev.io)` but this will not `[link](a.i)`
#### A link will not be converted to an anchor tag if either the `link name` or `link url` are blank (or invalid in link url's case)
So for example, the following will not be converted: `[](google.com)`, `[link name]()`, `[link name](a.i)`


## Headers
Will transform all markdown headers from `# some header` to `<h1>some header</h1>`

### callouts
#### Supports h1 - h6, via `#`, `##`, ... , `######`
#### A header must include at least 1 space between the `#` and the header content
So `# content` will be converted as will `#      content`, but `#content` will not be converted
#### Supports optional indentation by 1-3 spaces before the `#`
So ` # content`, through `   # content` will be converted, but `    # content` will not be converted
#### Trims leading and trailing whitespace around the header content, but not within the content
So `#     content      is      spread out     ` will be converted to `<h1>content      is      spread out</h1>` 
#### closing `#`s are not supported, they will always be rendered as part of the content
So `### content ###` will be converted to `<h3>content ###</h3>`
#### links can be any part of the header content
So `# [link](google.com) is a header` will be converted to `<h1><a href="google.com">link</a> is a header</h1>`

<hr/>

# How to run
This is a simple runner to start. It uses the `input.md` and `simple_runner.rb` files at the root.

From this directory run. You can modify the markdown by changing the contents of `input.md` 
```
ruby simple_runner.rb
```