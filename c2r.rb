require "fileutils"

def c_to_ruby(filename, path)
  ruby_comment = "#==============================================================================\n"

  if File.extname(filename) == ".c"
    ruby_filename = File.basename(filename, ".c") + ".rb"

    output = open(path + "/" + ruby_filename, "w")

    open(path + "/" + filename, "r") do |f|
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
        line = line.gsub(" else", "else")
        line = line.gsub("case", "when")
        line = line.gsub("switch", "case")
        line = line.gsub("int ", "")
        line = line.gsub("float ", "")
        line = line.gsub("double ", "")
        # line = line.gsub(/^\/(\**)/, ruby_comment)
        # line = line.gsub(/(\**)\//, ruby_comment)
        output << line
      end
    end
  end
end

path = File.dirname ARGV[0]
if File.directory?(ARGV[0])
  path = ARGV[0]
  Dir.each_child(ARGV[0]) do |filename|
    c_to_ruby(filename, path)
  end
elsif File.file?(ARGV[0])
  filename = File.basename ARGV[0]
  c_to_ruby(filename, path)
end
