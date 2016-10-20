# Rodolfo

[![Gem Version](https://badge.fury.io/rb/rodolfo.svg)](https://badge.fury.io/rb/Rodolfo)

[![Build Status](https://travis-ci.org/initios/rodolfo.svg?branch=master)](https://travis-ci.org/initios/rodolfo)
[![Code Climate](https://codeclimate.com/github/initios/rodolfo/badges/gpa.svg)](https://codeclimate.com/github/initios/rodolfo)
[![Test Coverage](https://codeclimate.com/github/initios/rodolfo/badges/coverage.svg)](https://codeclimate.com/github/initios/rodolfo/coverage)
[![Issue Count](https://codeclimate.com/github/initios/rodolfo/badges/issue_count.svg)](https://codeclimate.com/github/initios/rodolfo)

Rodolfo is a little binary to create pdfs with ease using the powerful Prawn library.
The main objective is to be able to use Rodolfo on any project / language as a tool
to create all of your pdf documents.

All you need to do is create a template folder with the following files:

  - schema.json – a json schema with the required fields, data-types, etc
  - template.rb – a ruby proc executed by Prawn

Check the templates folder for examples.

By default prawn, prawn/table and prawn/measurements are loaded.

No advanced ruby skills are required.
Just follow the Prawn documentation and the example templates and you should be fine.

## Installation

```bash
gem install rodolfo
```

## Usage

```bash
cat packages/example/data.json | rodolfo -t packages/example > output.pdf
```

Check the [cucumber html report](https://cdn.rawgit.com/initios/rodolfo/master/docs/features.html) for more usage examples

## Prawn

Rodolfo loads the following Prawn packages:

```bash
require 'prawn'
require 'prawn/measurements'
require 'prawn/measurement_extensions'
require 'prawn/table'
```

Ask to include any other on the [issue tracker](https://github.com/initios/rodolfo/issues)


## Changelog

### Unreleased
### Added
- Rodolfo now is bundled with Prawn and another dependencies

### [0.0.5] - 2016-10-19
### Added
- Validation (along with --skip-validation option) to perform schema validation when the document is created
- RDoc on Rodolfo classes
- Changelog!
