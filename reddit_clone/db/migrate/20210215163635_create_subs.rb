class CreateSubs < ActiveRecord::Migration[5.2]
  def change
    create_table :subs do |t|
      t.string :title
      t.text :description
      t.integer :moderator

      t.timestamps
    end

    add_index :subs, :moderator
    add_index :subs, :title
  end
end
