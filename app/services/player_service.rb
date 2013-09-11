class PlayerService

  require 'rubygems'
  require 'nokogiri'
  require 'restclient'

  def retrieve_players
    team_names =
        [
            {:team_link_name => 'arsenal', :team_name => 'Arsenal'},
            {:team_link_name => 'aston-villa', :team_name => 'Aston Villa'},
            {:team_link_name => 'cardiff', :team_name => 'Cardiff'},
            {:team_link_name => 'chelsea', :team_name => 'Chelsea'},
            {:team_link_name => 'crystal-palace', :team_name => 'Crystal Palace'},
            {:team_link_name => 'everton', :team_name => 'Everton'},
            {:team_link_name => 'fulham', :team_name => 'Fulham'},
            {:team_link_name => 'hull', :team_name => 'Hull'},
            {:team_link_name => 'liverpool', :team_name => 'Liverpool'},
            {:team_link_name => 'man-city', :team_name => 'Man City'},
            {:team_link_name => 'man-utd', :team_name => 'Man Utd'},
            {:team_link_name => 'newcastle', :team_name => 'Newcastle'},
            {:team_link_name => 'norwich', :team_name => 'Norwich'},
            {:team_link_name => 'southampton', :team_name => 'Southampton'},
            {:team_link_name => 'stoke', :team_name => 'Stoke'},
            {:team_link_name => 'sunderland', :team_name => 'Sunderland'},
            {:team_link_name => 'swansea', :team_name => 'Swansea'},
            {:team_link_name => 'tottenham', :team_name => 'Tottenham'},
            {:team_link_name => 'west-brom', :team_name => 'West Brom'},
            {:team_link_name => 'west-ham', :team_name => 'West Ham'}
        ]
    players = []
    team_names.each do |team|
      page = Nokogiri::HTML(RestClient.get("http://www.premierleague.com/en-gb/clubs/profile.squads.html/#{team[:team_link_name]}"))
      page.css('.clubsquadlists .contentTable')[0..1].each do |squad|
        squad.css('tbody tr').each do |player|
          player_element = player.css('.player-squadno a')[0]
          if !player_element.nil?
            players << {:name => player_element.text, :team => team[:team_name]}
          end
        end
      end
    end
    players
  end
end