@javascript
Feature: A user is able to visit the predictions page to view the fixtures for the next round of fixtures
  and submit a prediction against those fixtures.

  @timecop
  Scenario: The user should be able to View the next round of fixtures
    Given the fixtures for the coming weeks are as follows:
      | Date                      | Time  | Home team      | Away team  |
      | Saturday 9 November 2013  | 15:00 | Man Utd        | Arsenal    |
      | Saturday 9 November 2013  | 15:00 | Aston Villa    | Cardiff    |
      | Saturday 9 November 2013  | 15:00 | Crystal Palace | Fulham     |
      | Sunday 10 November 2013   | 13:00 | Norwich        | Man City   |
      | Sunday 10 November 2013   | 16:00 | Southampton    | Sunderland |
      | Saturday 16 November 2013 | 15:00 | Man City       | Spurs      |
      | Saturday 16 November 2013 | 15:00 | Southampton    | Chelsea    |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    Then the following fixtures should be available for predictions:
      | Home team | Away team |
      | Man Utd   | Arsenal   |
      | Norwich   | Man City  |

  @timecop
  Scenario: The user should be able to submit a prediction for the fixtures displayed
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Arsenal   |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team | Home team score | Away team score | Goal scorer |
      | Man Utd   | Arsenal   | 3               | 4               | Ryan Giggs  |
    And the submit button is clicked
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer | Status             |
      | user1  | Man Utd 3 - 4 Arsenal | Ryan Giggs  | Match Not Complete |

  @timecop
  Scenario: The user should be able to view the predictions made by other players
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Arsenal   |
    And user 2 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Status             |
      | user2  | Man Utd 1 - 0 Arsenal | Wayne Rooney | Match Not Complete |

  @timecop
  Scenario: The users prediction should be added to the table of predictions as there prediction is valid
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Arsenal   |
    And user 2 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team | Home team score | Away team score | Goal scorer |
      | Man Utd   | Arsenal   | 3               | 4               | Ryan Giggs  |
    And the submit button is clicked
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Status             |
      | user1  | Man Utd 3 - 4 Arsenal | Ryan Giggs   | Match Not Complete |
      | user2  | Man Utd 1 - 0 Arsenal | Wayne Rooney | Match Not Complete |

  @timecop
  Scenario: The user should be presented with the invalid prediction error as the goal scorer has been selected by another player
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Arsenal   |
    And user 2 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | 3               | 4               | Wayne Rooney |
    And the submit button is clicked
    Then the user should be presented with a prediction duplication error
    And the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Status             |
      | user2  | Man Utd 1 - 0 Arsenal | Wayne Rooney | Match Not Complete |

  @timecop
  Scenario: The user should be presented with the invalid prediction error as the scoreline has been selected by another player
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Arsenal   |
    And user 2 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team | Home team score | Away team score | Goal scorer |
      | Man Utd   | Arsenal   | 1               | 0               | Ryan Giggs  |
    And the submit button is clicked
    Then the user should be presented with a prediction duplication error
    And the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Status             |
      | user2  | Man Utd 1 - 0 Arsenal | Wayne Rooney | Match Not Complete |

  @timecop
  Scenario: The user should be presented with the invalid prediction error as the scoreline and goal scorer have been selected by another player
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Arsenal   |
    And user 2 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | 1               | 0               | Wayne Rooney |
    And the submit button is clicked
    Then the user should be presented with a prediction duplication error
    And the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Status             |
      | user2  | Man Utd 1 - 0 Arsenal | Wayne Rooney | Match Not Complete |

  @timecop
  Scenario: The user should be awarded 3 points and the status of their prediction should be updated to correct
  prediction when they have predicted the correct scoreline and scorer
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 1               | 1               | Wayne Rooney      |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Status             |
      | user1  | Man Utd 1 - 1 Arsenal | Wayne Rooney | Correct Prediction |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 3      | 1     |

  @timecop
  Scenario: The user should be awarded 3 points and the status of their prediction should be updated to correct
  prediction when they have predicted the correct scoreline and scorer (0-0 draw)
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 0               | 0               | no scorer   |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 0               | 0               |                   |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer | Status             |
      | user1  | Man Utd 0 - 0 Arsenal | no scorer   | Correct Prediction |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 3      | 1     |

  @timecop
  Scenario: The user should be awarded 1 point and the status of their prediction should be updated to correct scoreline
  when they have predicted the correct scoreline but incorrect scorer
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 1               | 0               | Ryan Giggs        |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Status            |
      | user1  | Man Utd 1 - 0 Arsenal | Wayne Rooney | Correct Scoreline |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 1      | 1     |

  @timecop
  Scenario: The user should be awarded 1 point and the status of their prediction should be updated to correct scorer
  when they have predicted the correct scorer but incorrect scoreline
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 1               | 0               | Wayne Rooney      |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Status         |
      | user1  | Man Utd 1 - 1 Arsenal | Wayne Rooney | Correct Scorer |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 1      | 1     |

  @timecop
  Scenario: The user should be awarded 0 point and the status of their prediction should be updated to incorrect prediction
  when they have predicted the incorrect scorer and incorrect scoreline
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 0               | 0               |                   |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Status               |
      | user1  | Man Utd 1 - 1 Arsenal | Wayne Rooney | Incorrect Prediction |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user2 | 0      | 2     |
      | user1 | 0      | 1     |

  @timecop
  Scenario: The users predictions should have a status of match not complete if at least 2 hours have not passed
  since the kick off
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 16:59
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Status             |
      | user1  | Man Utd 1 - 1 Arsenal | Wayne Rooney | Match Not Complete |







