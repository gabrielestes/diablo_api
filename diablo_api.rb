require 'sinatra'
require 'active_record'
require_relative 'environment'
require_relative 'all_tables'

get '/api/characters' do
  name = params['name']
  character_class = params['character_class']
  level = params['level']

  if !name.nil? && !character_class.nil?
    characters = Character.where(name: name, character_class: character_class, level: level)
  elsif !name.nil?
    characters = Character.where(name: name)
  elsif !character_class.nil?
    characters = Character.where(character_class: character_class)
  elsif !level.nil?
    characters = Character.where(level: level)
  else
    characters = Character.all.order(level: :DESC)
  end

  characters.to_json
  erb :index, :locals => {:name => characters.first.name, :character_class => characters.first.character_class}
  # status 302
end

get '/api/players' do
  player_name = params['player_name']
  hours_played = params['hours_played']

  if !player_id.nil?
    players = Player.where(player_name: player_name)
  elsif
    players = Player.where(hours_played: hours_played)
  else
    players = Player.all.order(player_name: :DESC)
  end

  players.to_json
  erb :index, :locals => {:player_name => players.first.player_name, :hours_played => players.first.hours_played}
  # status 302
end

post '/api/characters' do
  name = params['name']
  character_class = params['character_class']
  level = params['level']

  character = Character.create(name: name, character_class: character_class, level: level)

  character.to_json
  # status 201
end

post '/api/players' do
  player_name = params['player_name']
  hours_played = params['hours_played']

  player = Player.create(player_name: player_name, hours_played: hours_played)

  player.to_json
  # status 201
end

put '/api/characters' do # put is the update statement
  name = params['name']
  character_class = params['character_class']
  level = params['level']

  character = Character.find_by(name: name, character_class: character_class, level: level)
  character.update(name: params['new_name'], character_class: params['new_character_class'], level: params['new_level'])

  character.to_json
end

put '/api/players' do # put is the update statement
  player_name = params['player_name']
  hours_played = params['hours_played']

  player = Player.find_by(player_name: player_name, hours_played: hours_played)
  player.update(player_name: params['new_player_name'], hours_played: params['new_hours_played'])

  player.to_json
end

delete '/api/characters' do
  name = params['name']
  character_class = params['character_class']
  level = params['level']

  character = Character.find_by(name: name, character_class: character_class, level: level)

  character.destroy
end

delete '/api/players' do
  player_name = params['player_name']
  hours_played = params['hours_played']

  player = Player.find_by(player_name: player_name, hours_played: hours_played)

  player.destroy
end
