#!/usr/bin/env ruby

require_relative "./advent20.1"

def decryption_key
  811_589_153
end

if __FILE__ == $0
  sequence = input.dup

  10.times { sequence = mix(sequence) }

  p find_coordinates(sequence)
end
