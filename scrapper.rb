require 'pismo'
require 'csv'

def get_relevant_info(url)
  doc = Pismo::Document.new(url)

  [doc.description.strip, doc.doc.xpath("//title").children.text.strip, doc.title.strip, "na"].each do |i|
    return i unless i.empty?
  end
end

rows = []

File.open("source/directory", "r") do |f|
  f.each_line do |url|
    row = []
    row << url.strip
    begin
      row << get_relevant_info(url)
    rescue Exception
      row << "na"
    end

    rows << row
  end
end

csv_string = CSV.generate do |csv|
  csv << ['URL', 'Description']
  rows.each do |row|
      csv << row
  end
end

puts csv_string