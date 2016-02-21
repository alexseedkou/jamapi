class AddQualifiedToTabsSet < ActiveRecord::Migration
  def change
    add_column 'tabs_sets', 'qualified', :boolean, default: false
  end
end
