# NEWS

## Unreleased

### Runtime

* Racc no longer ships the native `racc/cparse` parser runtime. The runtime is
  now pure Ruby.
* `require "racc/cparse"` is kept as a compatibility shim for existing code.
* `Racc::Parser.racc_runtime_type` now returns `"ruby"`.

### Installation

* Installing the gem no longer requires a C compiler or Java extension build.
