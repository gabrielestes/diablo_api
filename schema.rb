require_relative 'environment'
require 'active_record'

class CreateCharactersTable < ActiveRecord::Migration[5.0]

  def up
    create_table :characters do |t|
      t.string :name
      t.string :character_class
      t.integer :level
    end
  end

  def down
    drop_table :characters
  end
end

class CreatePlayersTable < ActiveRecord::Migration[5.0]

  def up
    create_table :players do |t|
      t.string :player_name
      t.integer :hours_played
    end
  end

  def down
    drop_table :players
  end
end

class CreateCharactersPlayersJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :characters_players, id: false do |t|
      t.integer :character_id
      t.integer :player_id
    end

    add_index :characters_players, :character_id
    add_index :characters_players, :player_id
  end
end

def main
  action = (ARGV[0] || :up).to_sym
  CreateCharactersTable.migrate(action)
  CreatePlayersTable.migrate(action)
  CreateCharactersPlayersJoinTable.migrate(action)
end

main if __FILE__ == $PROGRAM_NAME
