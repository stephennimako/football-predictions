require 'rubygems'
require 'nokogiri'
require 'restclient'
require 'date'

require 'capybara'
require 'capybara/dsl'
require 'capybara/poltergeist'

Capybara.default_driver = :poltergeist
Capybara.run_server = false

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end


class ResultService
  include Capybara::DSL

  def retrieve_results oldest_fixture_date
    visit("http://www.premierleague.com/en-gb/matchday/results.html?paramComp_8=true&view=.dateSeason")

    results = {}
    match_report_finder = []
    page.all('.fixturelist .contentTable').each do |results_table|
      fixture_date = results_table.all('tr')[0].find('th').text

      next_result_date = DateTime.parse(fixture_date)
      break if next_result_date < oldest_fixture_date - 1.days

      results_table.all('tr').each do |result|
        score_link = result.all('.score a')[0]

        next if score_link.nil?

        score_split = score_link.text.split(' - ')
        home_team_score = score_split[0].to_i
        away_team_score = score_split[1].to_i
        home_team = result.all('.rHome a')[0].text
        away_team = result.all('.rAway a')[0].text
        fixture_key = (home_team + " v " + away_team).gsub!(" ", "_").to_sym
        results[fixture_key] =
            {:home_team_score => home_team_score, :away_team_score => away_team_score}
        match_report_finder << {:link => score_link[:href], :fixture_key => fixture_key}
      end
    end

    match_report_finder.each do |finder|
      visit "http://www.premierleague.com#{finder[:link]}"

      results[finder[:fixture_key]][:home_goal_scorers] = extract_goal_scorers(page, 'home')
      results[finder[:fixture_key]][:away_goal_scorers] = extract_goal_scorers(page, 'away')
    end
    results
  end

  def extract_goal_scorers(page, type)
    goal_scorers = []
    page.all(".fixtureheader .goals.#{type} li").each do |scorer_element|
      scorer_text = scorer_element.text
      goal_scorers << scorer_text.scan(/(.*)\(.*/)[0][0].strip unless scorer_text.include?('og)')
    end
    goal_scorers
  end
end