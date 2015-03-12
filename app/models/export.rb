require 'rubygems'

class Export
 
  def self.get(output)
    CSV.open(get_file(output), "w") do |csv|
      csv << ["Manufacturer Name", "Part number", "Part Description", "Distributor", "SKU", "Stock Quantity", "MOQ- Minimum Order Quantity", "Packaging", "Currency", "Price"] 
      output["results"].each do |part|
        part["item"]["offers"].each do |offer|
        csv << [ part['item']['manufacturer']['name'],
                 offer['sku'],
                 part["snippet"],
                 offer["seller"]["name"],
                 offer["sku"],
                 offer["in_stock_quantity"],
                 offer["moq"],
                 offer["packaging"],
                 offer["prices"].keys[0],
                 offer["prices"].values.flatten.in_groups_of(2).to_h
                ]
        end   
      end 
    end
  end

 private 
  def get_file(output)
    "public/#{output["request"]["q"]}.csv"
  end

end