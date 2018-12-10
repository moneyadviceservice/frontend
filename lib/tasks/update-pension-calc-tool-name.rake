namespace :corporate_partners do
  desc 'Update tool name from "Pensions calculator" to "Pension calculator"'
  task update_tool_name: :environment do
    records_to_update = CorporatePartner.where(tool_name: 'Pensions calculator')
    puts "record ids: #{records_to_update.map(&:id)}"

    CorporatePartner.transaction do
      records_to_update.each do |record|
        record.update(tool_name: 'Pension calculator')
      end

      puts "#{records_to_update.count} updated"
    end    
  end
end
