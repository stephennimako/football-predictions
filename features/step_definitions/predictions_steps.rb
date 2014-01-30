When /^user (\d+) signs in and visits the predictions page$/ do |user_id|
  visit '/users/sign_in'
  fill_in "user_email", :with => "user#{user_id}@test.com"
  fill_in "user_password", :with => 'test1234'
  click_button "Sign in"
end

Then /^I should see "(.*?)"$/ do |message|
  page.should have_content(message)
end

Given /^the fixtures for the coming weeks are as follows:$/ do |table|
  # table is a | Date | Time  | Home team | Away team |

  fixtures_by_date = table.hashes.group_by { |fixture| fixture['Date'] }

  template = Tilt::ERBTemplate.new File.new 'features/responses/fixtures.html.erb'
  response = template.render(nil, {:fixtures_by_date => fixtures_by_date})
  stub_request(:get, "http://www.premierleague.com/en-gb/matchday/matches.html?paramClubId=ALL&paramComp_8=true&view=.dateSeason").
      to_return(:body => response, :status => 200)

end

When /^the results for the fixtures are the following:$/ do |table|
  # table is a | Home team | Away team | Kick off | Home team score | Away team score | Home team scorers | Away team scorers |

  results_by_date = table.hashes.group_by { |result| result['Date'] }

  template = Tilt::ERBTemplate.new File.new 'features/responses/results.html.erb'
  response = template.render(nil, {:results_by_date => results_by_date})
  stub_request(:get, "http://www.premierleague.com/en-gb/matchday/results.html?paramComp_8=true&view=.dateSeason").
      to_return(:body => response, :status => 200)

  table.hashes.each do |result|
    result.each { |k, v| result[k] = v.split(',') if ['Home team scorers', 'Away team scorers'].include? k }
    template = Tilt::ERBTemplate.new File.new 'features/responses/result_detailed_view.html.erb'
    response = template.render(nil, {:result => result})
    stub_request(:get, "http://www.premierleague.com/en-gb/matchday/matches/2013-2014/epl.match-preview.html/#{result['Home team'].gsub(' ', '-').downcase}-vs-#{result['Away team'].gsub(' ', '-').downcase}").
        to_return(:body => response, :status => 200)
  end
end

Then /^the following fixtures should be available for predictions:$/ do |table|
  # table is a | Home team        | Away team   |
  prediction_elements = page.all('.prediction_list .prediction')
  fixtures = table.hashes
  fixtures.length.should == prediction_elements.length

  fixtures.each_with_index do |fixture, index|
    prediction_elements[index]['data-home-team'].should == fixture['Home team']
    prediction_elements[index]['data-away-team'].should == fixture['Away team']
  end
end

Given /^user (\d+) has predicted the following:$/ do |user_id, table|
  # table is a | Man Utd   | Arsenal   | 1               | 0               | Wayne Rooney |
  table.hashes.each do |prediction|

    Prediction.create(:home_team => prediction['Home team'], :away_team => prediction['Away team'],
                      :home_team_score => prediction['Home team score'], :away_team_score => prediction['Away team score'],
                      :goal_scorer => prediction['Goal scorer'], :additional_goal_scorer => prediction['Additional Goal scorer'],
                      :kick_off => DateTime.parse(prediction['Kick off']), :user_id => user_id, :prediction_status_id => 0)
  end

end

When /^the predictions form is filled with the following:$/ do |table|
  # table is a | Man Utd   | Arsenal   | 1               | 0               | Wayne Rooney |
  table.hashes.each do |prediction|
    fixture_element = page.find(".prediction[data-home-team='#{prediction['Home team']}']")
    fixture_element.find(".home_team_score option[value='#{prediction['Home team score']}']").select_option
    fixture_element.find(".away_team_score option[value='#{prediction['Away team score']}']").select_option
    fixture_element.find(".goal_scorer option[value='#{prediction['Goal scorer']}']").select_option
    fixture_element.find(".additional_goal_scorer option[value='#{prediction['Additional Goal scorer']}']").select_option if prediction['Additional Goal scorer']
  end
end

Given /^the current date is (.*)$/ do |date|
  Timecop.travel(DateTime.parse(date))
end

When /^the submit button is clicked$/ do
  page.find('.submit_button').click
end

Then /^the table of predictions should contain the following predictions$/ do |table|
  # table is a       | player | Fixture                | Goal scorer  | status |
  table.hashes.each_with_index do |prediction, index|
    page.find(".prediction_table tbody tr:nth-child(#{index + 1}) .name").text.should == prediction['player']
    page.find(".prediction_table tbody tr:nth-child(#{index + 1}) .fixture").text.should == prediction['Result']
    page.find(".prediction_table tbody tr:nth-child(#{index + 1}) .goal_scorer").text.should == prediction['Goal scorer']
    page.find(".prediction_table tbody tr:nth-child(#{index + 1}) .additional_goal_scorer").text.should == prediction['Additional Goal scorer'] if prediction['Additional Goal scorer']
    page.find(".prediction_table tbody tr:nth-child(#{index + 1}) .status").text.should == prediction['Status']
  end
end

Then /^the user should be presented with a prediction duplication error$/ do
  page.has_css?('.error_message').should == true
end
Then /^the table of standings should contain the following:$/ do |table|
  # table is a | User  | Points                | Order        |
  table.hashes.each_with_index do |standing, index|
    page.find(".user_standings tbody tr:nth-child(#{index + 1}) .user").text.should == standing['User']
    page.find(".user_standings tbody tr:nth-child(#{index + 1}) .points").text.should == standing['Points']
    page.find(".user_standings tbody tr:nth-child(#{index + 1}) .prediction_order").text.should == standing['Order']
  end

end
Then /^the predictions form should contain the following predictions$/ do |table|
  # table is a | Home team | Away team | Home team score | Away team score | Goal scorer  |
  table.hashes.each_with_index do |prediction, index|
     page.find(".predictions_form .prediction_list li:nth-child(#{index + 1}) .home_team_score").find('option[selected]').text.should == prediction['Home team score']
     page.find(".predictions_form .prediction_list li:nth-child(#{index + 1}) .away_team_score").find('option[selected]').text.should == prediction['Away team score']
     page.find(".predictions_form .prediction_list li:nth-child(#{index + 1}) .goal_scorer").find('option[selected]').text.should == prediction['Goal scorer']
     page.find(".predictions_form .prediction_list li:nth-child(#{index + 1}) .additional_goal_scorer").find('option[selected]').text.should == prediction['Additional Goal scorer'] if prediction['Additional Goal scorer']
  end
end
When /^the users have the following precedence$/ do |table|
  # table is a | user  | precedence | predicted_first |
  table.hashes.each do |precedence|
    UserPrecedence.where(:user_id => precedence['User id'])[0].update(:precedence => precedence['Precedence'],
                                                                      :predicted_first => precedence['Predicted first'],
                                                                      :updated_at => precedence['Updated at'])
  end
end