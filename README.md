# SimpleFile
Provide simple functionalities for file import and export

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'simple_file'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install simple_file
```

## Usage
#### SETUP
```ruby
# rails
# config/initializers/alphapay.rb
SimpleFile.setup do |s|
  s.encoding = CUSTOM_ENCODING # defaults is 'UTF-8'
end
```
---
#### IMPORT
```ruby
file = File.open(FILE_PATH)
# default import
importer = SimpleFile::CSV.new
# import with custom mapping
importer = SimpleFile::CSV.new(mapping: { 'col1': 'new_col1' })

importer.import(file)
importer.results
importer.count
importer.file
importer.col_sep
importer.encoding
importer.mapping
importer.errors
```

## ToDo
- csv export
- excel import and export

## Contributing
- Clone this repo and go into the gem top-level directory and run `bundle install`
- To run the specs run `rspec spec`.
- To access irb development environment run `ruby bin/console`
- Submit a pull request for and explain what your changes are.
ps. You will usually want to write tests for your changes

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
