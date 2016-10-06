require 'active_record'

class Character < ActiveRecord::Base
  validates :name, :character_class, :level, presence: true
  belongs_to :player
end

class Player < ActiveRecord::Base
  validates :player_name, :hours_played, presence: true
  has_many :characters
end

class CharactersPlayersJoinTable < ActiveRecord::Base
end

# character = Character.create()
# player = Player.create()
# CreateCharactersPlayersJoinTable.create(character_id: character.id, player_id: player.id)
