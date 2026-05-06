# frozen_string_literal: true

# Compatibility shim for releases without the native Racc runtime.
#
# Historically this path loaded racc/cparse.so. The native extension has been
# removed; Racc::Parser uses the pure Ruby runtime instead.

require 'racc/info'

module Racc
  class CparseParams
    private_class_method :new
  end unless const_defined?(:CparseParams, false)

  if const_defined?(:Parser, false)
    class Parser
      unless const_defined?(:Racc_Runtime_Core_Version_C, false)
        Racc_Runtime_Core_Version_C = ::Racc::VERSION
      end

      unless const_defined?(:Racc_Runtime_Core_Id_C, false)
        Racc_Runtime_Core_Id_C = 'pure-ruby compatibility shim'
      end
    end
  end
end
