require 'rubygems'
require 'nokogiri'

command = Thread.new do
 `"C:\\Program Files (x86)\\STORMWARE\\POHODA\\Pohoda.exe" /XML "Admin" "" "C:\\Users\\joas\\RubymineProjects\\Aiesec\\xml_export.ini"`
end
command.join

Dir.glob("output/*.xml").each do |filename|
  doc = Nokogiri::XML(File.new(filename))
  ucetni_jednotky = doc.xpath("//acu:dataFile")
  puts ucetni_jednotky.inner_text if ucetni_jednotky.any?
end
