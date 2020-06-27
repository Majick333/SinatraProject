class CreateLists < ActiveRecord::Migration[4.2]

    def change
        create_table :lists do |t|
            t.text :task
            t.text :content
            t.integer :user_id
        end
    end
end