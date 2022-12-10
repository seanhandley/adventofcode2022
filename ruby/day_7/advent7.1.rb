#!/usr/bin/env ruby

def input
  @input ||= STDIN.readlines
end

class File
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size
  end

  def to_s
    "#{@name} (#{@size} bytes)"
  end
end

class Directory
  attr_reader :name, :children, :parent
  
  def initialize(name, parent = nil)
    @name = name
    @parent = parent
    @children = []
  end

  def add_child(child)
    @children << child
  end

  def size
    @children.sum(&:size)
  end

  def to_s
    "#{@name} (#{size} bytes)
\t#{@children.map { |child| "  #{child}" }.join("
    ")}"
  end
end

def build_tree
  @directories = {}
  current_directory = Directory.new("/")
  @directories["/"] = current_directory
  input.each do |line|
    if /\$ cd \.\./.match(line)
      current_directory = current_directory.parent
    elsif match = /\$ cd .+/.match(line)
      name = match[0].split(" ").last
      current_directory = @directories[name]
    elsif line == "ls"
      # do nothing
    elsif match = /(\d+) (.+)/.match(line)
      current_directory.add_child(File.new(match[2], match[1].to_i))
    elsif match = /dir (.+)/.match(line)
      name = match[1]
      directory = Directory.new(match[1], current_directory)
      current_directory.add_child(directory)
      @directories[name] = directory
    end
  end
end

def directories_below_threshold(threshold)
  @directories.values.select { |directory| directory.size <= threshold }
end

if __FILE__ == $0
  build_tree
  puts @directories["/"]
  # puts directories_below_threshold(100_000).sum(&:size)
end
