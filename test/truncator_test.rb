require "test/unit"
require_relative "../truncator"

class TruncatorTest < Test::Unit::TestCase

    def test_tokens_empty_standard
        tokens_exp = []
        tokens = Truncator::tokens "empty"

        assert_equal tokens_exp, tokens
    end

end