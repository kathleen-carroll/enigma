require 'simplecov'
SimpleCov.start

SimpleCov.start do
  add_filter 'test'
end

require 'minitest/autorun'
require 'minitest/pride'
