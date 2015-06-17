require 'rubygems'
require 'nokogiri'

command = Thread.new do
 `"C:\\Program Files (x86)\\STORMWARE\\POHODA\\Pohoda.exe" /XML "Admin" "password" "C:\\Users\\joas\\RubymineProjects\\Aiesec\\base\\init.ini"`
end
command.join

  jednotky = File.open("ucetni_jednotky.xml")
  doc = Nokogiri::XML(jednotky)
  Dir.mkdir 'output' unless Dir.exist? 'output'
  doc.xpath("//acu:itemAccountingUnit").each do |node|
  if node
    output_dir = "output/#{node.xpath('//typ:company').inner_html}"
    database = node.xpath('//acu:dataFile').inner_html
    Dir.mkdir output_dir unless Dir.exist? output_dir
    unless File.exist?("#{output_dir}/init.ini")
    init_file = File.new("#{output_dir}/init.ini",'w')
    init_file << "[XML]\ninput_dir=input\ncheck_duplicity=0,1\nformat_output=0,1\ndatabase=#{database}\nresponse_dir=#{output_dir.sub(/\//,'\\')}"
    init_file.close
    end
    `"C:\\Program Files (x86)\\STORMWARE\\POHODA\\Pohoda.exe" /XML "Admin" "880526" "C:\\Users\\joas\\RubymineProjects\\Aiesec\\#{output_dir}\\init.ini"`
  end
end
jednotky.close