![Rodolfo Logo](assets/rodolfo-logo.png)

[![Build Status](https://travis-ci.org/initios/rodolfo.svg?branch=master)](https://travis-ci.org/initios/rodolfo)
[![Code Climate](https://codeclimate.com/github/initios/rodolfo/badges/gpa.svg)](https://codeclimate.com/github/initios/rodolfo)
[![Gem Version](https://badge.fury.io/rb/rodolfo.svg)](https://badge.fury.io/rb/Rodolfo)
[![Test Coverage](https://codeclimate.com/github/initios/rodolfo/badges/coverage.svg)](https://codeclimate.com/github/initios/rodolfo/coverage)
[![Issue Count](https://codeclimate.com/github/initios/rodolfo/badges/issue_count.svg)](https://codeclimate.com/github/initios/rodolfo)

Rodolfo is a little binary to create pdfs with ease using the powerful Prawn library.
The main objective is to be able to use Rodolfo on any project / language as a tool
to create all of your pdf documents.

All you need to do is create a recipe folder with the following files:

  - schema.json – a json schema with the required fields, data-types, etc (optional)
  - template.rb – a ruby prawn template (see recipes folder for examples)
  - data.json - as a valid data example and to test your template (optional)

Check the recipes folder for examples or check [Rodolfo-Recipes](https://github.com/initios/rodolfo-recipes)

By default prawn, prawn/table and prawn/measurements are loaded.

No advanced ruby skills are required.
Just follow the Prawn documentation and the example templates and you should be fine.

## Installation

```bash
gem install rodolfo
```

## Quick Start

```
rodolfo g new-recipe "hello world recipe"
rodolfo render new-recipe --save-to hello.pdf
```

## Usage

```bash
cat recipes/example/data.json | rodolfo render recipes/example > output.pdf
```

Possible responses:
- status code 0. Everything went successfull. stdout is the pdf bytes
- status code 2. JSON Schema validation failed. stdout is a json with the errors
- status code ?. Unexpected failure

Check the [cucumber html report](https://cdn.rawgit.com/initios/rodolfo/master/docs/features.html) for more usage examples
Or run rodolfo without args too see the help

## Prawn

Rodolfo loads the following Prawn recipes:

```bash
require 'prawn'
require 'prawn/measurements'
require 'prawn/measurement_extensions'
require 'prawn/table'
```

Ask to include any other on the [issue tracker](https://github.com/initios/rodolfo/issues)


## Changelog

### [2.3.0] - 2017-09-12
### Updated

- Full JSON schema is stored on the PDF instead of partial data
- Upgrade prawn to 2.2.0 (Minimum ruby is now 2.1)
- Upgrade json-schema to 2.8.0

### Fixed

- JSON schema validation errors are now returned as JSON

### Removed

- Ruby 2.0 compatibility, now minimum is 2.1


### [2.2.1] - 2016-11-28
### Added
- Payload is added to PDF metadata for easier debugging bad rendered PDFs.
Use rodolfo read file.pdf to get the payload which made that PDF and use that
to improve your template and schema.


### [2.2.0] - 2016-11-21
### Refactoring
- Templates refactored again

### [2.1.0] - 2016-11-19
### Added
- Add recipe scaffolding command
- Read command option. It prints a pdf metadata
- --strict option enabled. Any missing field will make validation to fail
- Rescue some unexpected errors
- New --save-to option to save pdf files to a file instead to stdout
- Add schema default values support
  ```bash
  // Schema
  "properties": [
    "msg": {
      "type": "string", "default": "default msg"
    }
  ]

  // Payload
  {}

  Will transform the payload to
  {"msg": "default msg"}
  ```


### Modified
- The cli now uses Thor
- Renamed `rodolfo -p recipe` to `rodolfo render recipe` etc. Check the docs
- Rodolfo templates now uses simple ruby classes, removed Prawn inheritance


### Removed

- --skip-validation flag removed. Validation should be always performed


### [1.0.0] - 2016-10-31
### Added
- Option --schema

### [1.0.0.pre1] - 2016-10-20
### Added
- Rodolfo now is bundled with Prawn and another dependencies

### Breaking changes
- Refactor -t and --template to -p and --recipe

### [0.0.5] - 2016-10-19
### Added
- Validation (along with --skip-validation option) to perform schema validation when the document is created
- RDoc on Rodolfo classes
- Changelog!
