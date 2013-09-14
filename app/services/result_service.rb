class ResultService

  require 'rubygems'
  require 'nokogiri'
  require 'restclient'
  require 'date'

  def retrieve_results oldest_fixture_date
    page = Nokogiri::HTML(RestClient.get("http://www.premierleague.com/en-gb/matchday/results.html?paramComp_8=true&view=.dateSeason"))

    results = {}
    match_report_finder = []
    page.css('.fixturelist .contentTable').each do |results_table|
      fixture_date = results_table.css('tr')[0].css('th').text

      next_result_date = DateTime.parse(fixture_date)
      break if next_result_date < oldest_fixture_date - 1.days

      results_table.css('tr').each do |result|
        score_link = result.css('.score a')[0]

        next if score_link.nil?

        score_split = score_link.text.split(' - ')
        home_team_score = score_split[0].to_i
        away_team_score = score_split[1].to_i
        home_team = result.css('.rHome a')[0].text
        away_team = result.css('.rAway a')[0].text
        fixture_key = (home_team + " v " + away_team).gsub!(" ", "_").to_sym
        results[fixture_key] =
            {:home_team_score => home_team_score,:away_team_score => away_team_score}
        match_report_finder << {:link => score_link[:href], :fixture_key => fixture_key}
      end
    end

    match_report_finder.each do |finder|
      page = Nokogiri::HTML(RestClient.get("http://www.premierleague.com#{finder[:link]}"))
      goal_scorers = []
      page.css('.fixtureheader .goals li').each do |scorer_element|
        scorer_text = scorer_element.text
        goal_scorers << scorer_text.scan(/(.*)\(.*/)[0][0].strip unless scorer_text.include?('og)')
      end
      results[finder[:fixture_key]][:goal_scorers] = goal_scorers
    end
    results
  end
end