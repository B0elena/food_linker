class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :tweet_name,    null: false
      t.string :tweet_text,    null: false
      t.references :admin,     null: false, foreign_key: true
      t.timestamps
    end
  end
end
