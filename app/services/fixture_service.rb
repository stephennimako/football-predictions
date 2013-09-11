class FixtureService

  require 'rubygems'
  require 'nokogiri'
  require 'restclient'
  require 'date'


  def retrieve_future_fixtures
    page = Nokogiri::HTML(RestClient.get("http://www.premierleague.com/en-gb/matchday/matches.html?paramClubId=ALL&paramComp_8=true&view=.dateSeason"))

    fixtures = []
    current_date = nil
    page.css('.fixturelist .contentTable').each do |fixtures_table|
      fixture_date = fixtures_table.css('tr')[0].css('th').text

      next_date = DateTime.parse(fixture_date)
      break if current_date != nil && next_date - current_date > 1
      current_date = next_date

      fixtures_table.css('tr').each do |fixture|
        teams = fixture.css('td.clubs a').text
        if teams == ""
          next
        else
          teams_split = teams.split(' v ')
          home_team = teams_split[0]
          away_team = teams_split[1]
          time = fixture.css('td.time').text
          kick_off = fixture_date + time + ':00'
          current_date =  DateTime.parse(kick_off)

          fixtures << {:kick_off => kick_off, :home_team => home_team, :away_team => away_team}
        end
      end
    end
    fixtures
  end
end