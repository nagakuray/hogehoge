# coding: utf-8

hoge = []
i = 0
File.open(ARGV[0]) do |f|
  f.each_line do |line|
    line.chomp!
    values = line.split(/\s/)
    hoge[i] = values
    i += 1
  end
end
p hoge

hoge.each do |h|
  puts "#{h[0]},#{h[1]},#{h[2]}"
end
