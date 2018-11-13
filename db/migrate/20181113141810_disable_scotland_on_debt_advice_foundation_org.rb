class DisableScotlandOnDebtAdviceFoundationOrg < ActiveRecord::Migration
  def up
    if ActiveRecord::Base.connection.table_exists?('debt_advice_locator_organisations')
      debt_advice_foundation = DebtAdviceLocator::Organisation
        .where(name: 'Debt Advice Foundation')
        .where('provides_telephone = true OR provides_web = true')

      debt_advice_foundation.each do |organisation|
        organisation.update(region_scotland: false)
      end
    end
  end

  def down
    if ActiveRecord::Base.connection.table_exists?('debt_advice_locator_organisations')
      debt_advice_foundation = DebtAdviceLocator::Organisation
        .where(name: 'Debt Advice Foundation')
        .where('provides_telephone = true OR provides_web = true')

      debt_advice_foundation.each do |organisation|
        organisation.update(region_scotland: true)
      end
    end
  end
end
