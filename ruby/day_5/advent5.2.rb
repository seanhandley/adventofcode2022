#!/usr/bin/env ruby

require_relative "./advent5.1"

def follow_instruction(stacks, count, source, destination)
  stacks[destination].unshift(*stacks[source].shift(count))
end

if __FILE__ == $0
  puts heads_of_stacks(rearrange_crates)
end
