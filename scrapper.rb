require 'pismo'
require 'csv'

def get_relevant_info(url)
  doc = Pismo::Document.new(url)

  [doc.description.strip, doc.doc.xpath("//title").children.text.strip, doc.title.strip].each do |i|
    return i unless i.empty?
  end
end

File.open("source/directory", "r") do |f|
  f.each_line do |url|
    row = []
    row << url.strip
    begin
      row << get_relevant_info(url)
    rescue Exception

    end

    puts row.map{|i| 
      begin 
        i.force_encoding(Encoding::UTF_8)
      rescue Exception
        ""
      end
    }.to_csv
  end
end
