require 'fileutils'
task :new do
  count = Dir.glob('_*').size + 1
  count = count.to_s.size.eql?(1) ? "0#{count}" : count.to_s
  name = ARGV.detect {|arg| arg =~ /=/ }.split('=').last
  puts "Making: _#{count}_#{name}"
  FileUtils.mkdir("_#{count}_#{name}")
  FileUtils.touch("_#{count}_#{name}/_#{count}_#{name}.pde")
end
