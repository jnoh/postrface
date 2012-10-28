class AddNestedSetToPosts < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth
    end
  end
end
