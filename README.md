# (simplified) Markdown to HTML Converter
A tool for converting a subset of Markdown into HTML.

This is the supported subset of Markdown
| Markdown                               | HTML                                              |
| -------------------------------------- | ------------------------------------------------- |
| `# Heading 1`                          | `<h1>Heading 1</h1>`                              |
| `## Heading 2`                         | `<h2>Heading 2</h2>`                              |
| `### Heading 3`                        | `<h3>Heading 3</h3>`                              |
| `#### Heading 4`                       | `<h4>Heading 4</h4>`                              |
| `##### Heading 5`                      | `<h5>Heading 5</h5>`                              |
| `###### Heading 6`                     | `<h6>Heading 6</h6>`                              |
| `Unformatted text`                     | `<p>Unformatted text</p>`                         |
| `[Link text](https://www.example.com)` | `<a href="https://www.example.com">Link text</a>` |
| `Blank line`                           | `Ignored`                                         |

# Parsing rules / presumptions

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
So `_# content`, through `___# content` will be converted, but `____# content` will not be converted
#### Trims leading and trailing whitespace around the header content, but not within the content
So `#     content      is      spread out     ` becomes `<h1>content      is      spread out</h1>` 
#### Closing `#`s are not supported, they will always be rendered as part of the content
So `### content ###` becomes `<h3>content ###</h3>`
#### Links can be any part of the header content
So `# [link](google.com) is a header` becomes `<h1><a href="google.com">link</a> is a header</h1>`

## Paragraphs
Will transform anything other than a header or blank line into a paragraph tag. This includes across multiple lines of text.
Paragraphs are closed by a blank line, a header line, or the end of the content. 
Example: `across multiple\nlines\n` will become `<p>across multiple\nlines</p>\n`
Example where headers will not be included:
So this
```
this is a paragraph
## this is a header
this is a different paragraph
```
will become
```
<p>this is a paragraph</p>
<h2>this is a header</h2>
<p>this is a different paragraph</p>
```

### callouts
#### Existing html will be put within a paragraph tag
So `<p>existing paragraph</p>\n<div>some content</div>\n` becomes `<p><p>existing paragraph</p>\n<div>some content</div></p>\n`
#### The trailing newline is moved to after the closing paragraph tag
So `content\n` becomes `<p>content</p>\n`
#### Links can be any part of the paragraph content
So `[link](google.com)\n is a paragraph` becomes `<p><a href="google.com">link</a>\n is a paragraph</p>`

<hr/>

# Getting setup
Use [asdf](https://asdf-vm.com/) to install ruby (3.3.4), follow the guide to install the [asdf-ruby plugin](https://github.com/asdf-vm/asdf-ruby) 

Once asdf and asdf-ruby are installed, run
```
asdf install ruby 3.3.4
```

Then install dependencies (just for tests) by running
```
bundle install
```

# How to run
This is a simple runner to start. It uses the `input.md` and `simple_runner.rb` files at the root.

From this directory run. You can modify the markdown by changing the contents of `input.md` 
```
ruby simple_runner.rb
```

# Running tests
To run all the tests, just run:
```
rspec
```