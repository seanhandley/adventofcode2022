#!/usr/bin/env ruby

COORDINATE_INDICES = [1000, 2000, 3000]

def decryption_key
  1
end

def input
  @input ||= STDIN.readlines.
                   map(&:to_i).
                   map { |i| i * decryption_key }.
                   each_with_index.
                   map { |n, i| [n, i] }
end

def mix(sequence)
  input.each do |n, i|
    next if n.zero?

    curr = sequence.index([n, i])
    sequence.delete([n, i])
    new_i = (curr + n) % sequence.size
    sequence.insert(new_i, [n, i])
  end
  sequence
end

def find_coordinates(sequence)
  sequence = sequence.map(&:first)
  sequence = sequence.drop_while { |n| n != 0 } + sequence.take_while { |n| n != 0 }
  COORDINATE_INDICES.sum { |i| sequence[i % sequence.size] }
end

if __FILE__ == $0  
  p find_coordinates(mix(input.dup))
end
