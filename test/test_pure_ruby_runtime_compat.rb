require File.expand_path(File.join(__dir__, 'case'))

module Racc
  class TestPureRubyRuntimeCompat < TestCase
    def test_require_racc_cparse_after_parser
      assert_nothing_raised do
        require 'racc/cparse'
      end
    end

    def test_require_racc_cparse_before_parser
      assert_in_out_err(
        [
          "-I#{LIB_DIR}",
          "-e",
          "require 'racc/cparse'; require 'racc/parser'; abort Racc::Parser.racc_runtime_type unless Racc::Parser.racc_runtime_type == 'ruby'",
        ],
        '',
        [],
        []
      )
    end

    def test_parser_runtime_type_is_ruby
      assert_equal 'ruby', Parser.racc_runtime_type
      assert_equal Parser::Racc_Runtime_Core_Version_R,
                   Parser::Racc_Runtime_Core_Version
    end

    def test_c_named_private_methods_are_compatibility_aliases
      parser = Parser.allocate

      assert_respond_to parser, :_racc_do_parse_rb
      assert_respond_to parser, :_racc_yyparse_rb
      assert(parser.respond_to?(:_racc_do_parse_c, true))
      assert(parser.respond_to?(:_racc_yyparse_c, true))
      assert(Parser.private_method_defined?(:_racc_do_parse_c))
      assert(Parser.private_method_defined?(:_racc_yyparse_c))
    end
  end
end
