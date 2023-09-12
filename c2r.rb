require "fileutils"

Dir.each_child(ARGV[0]) do |file|
  if File.extname(file) == ".c"
    ruby_file = File.basename(file, ".c") + ".rb"
    output = open(ARGV[0] + "/" + ruby_file, "w")
    open(ARGV[0] + "/" + file, "r") do |f|
      f.each_line do |line|
        next if line[0] == "#"
        next if (line.include? "main") && (line.include? "(")
        line = line.gsub("  ", "")
        line = line.gsub("//", "#")
        line = line.gsub("return 0;\n", "")
        line = line.gsub(";", "")
        line = line.gsub("printf", "puts ")
        line = line.gsub("(", "")
        line = line.gsub(")", "")
        line = line.gsub("{", "")
        line = line.gsub("}", "")
        line = line.gsub("\\n", "")
        line = line.gsub("else if", "elsif")
        line = line.gsub("int ", "")
        line = line.gsub("float ", "")
        line = line.gsub("double ", "")

        output << line
      end
    end
  end
end
