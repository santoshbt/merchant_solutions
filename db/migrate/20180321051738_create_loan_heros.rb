class CreateLoanHeros < ActiveRecord::Migration[5.1]
  def change
    create_table :loan_heros do |t|

      t.timestamps
    end
  end
end
