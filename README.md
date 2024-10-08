# (simplified) Markdown to HTML Converter

# Parsing rules / presumptions

## Links
Will transform all markdown links from `[Some Link Name](https://google.com)` 
to `<a href="https://google.com" >Some Link Name</a>`

### callouts
* url protocol is optional and case-insensitive, but must be `http | https` if provided
* url TLD must be 2+ characters, it isn't checking for real TLD
* will not be converted to an anchor tag if either the `link name` or `link url` are blank


# How to run
This is a simple runner to start. It uses the `input.md` and `simple_runner.rb` files at the root.

From this directory run. You can modify the markdown by changing the contents of `input.md` 
```
ruby simple_runner.rb
```