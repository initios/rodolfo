# Rodolfo

[![Build Status](https://travis-ci.org/initios/rodolfo.svg?branch=master)](https://travis-ci.org/initios/rodolfo)
[![Code Climate](https://codeclimate.com/github/initios/rodolfo/badges/gpa.svg)](https://codeclimate.com/github/initios/rodolfo)
[![Test Coverage](https://codeclimate.com/github/initios/rodolfo/badges/coverage.svg)](https://codeclimate.com/github/initios/rodolfo/coverage)
[![Issue Count](https://codeclimate.com/github/initios/rodolfo/badges/issue_count.svg)](https://codeclimate.com/github/initios/rodolfo)

## Usage

```bash
echo '{"msg": "Hello World"}' | rodolfo -t /path/to/templates/simple -o output.pdf
cat data.json | rodolfo -t /path/to/templates/simple > output.pdf
```

## Examples

The templates folder contains a few examples made for testing.
