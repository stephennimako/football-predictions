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
  Scenario: The user should be able to select players from both teams as goalscorer
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team  |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Sunderland |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    Then the goal scorers list should contain players from both teams

  @timecop
  Scenario: The user should be able to select players from home team only as goalscorer and players from away team only as
  additional scorer for bonus game
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Arsenal   |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    Then the goal scorers list should contain players from the home team
    And the additional goal scorers list should contain players from the away team


  @timecop
  Scenario: The user should be able to submit a prediction for the fixtures displayed
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team  |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Sunderland |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team  | Home team score | Away team score | Goal scorer |
      | Man Utd   | Sunderland | 3               | 4               | Ryan Giggs  |
    And the submit button is clicked
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer | Status             |
      | user1  | Man Utd 3 - 4 Sunderland | Ryan Giggs  | Match Not Complete |

  @timecop
  Scenario: The user should be able to submit a prediction for bonus fixture
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Arsenal   |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team | Home team score | Away team score | Goal scorer | Additional Goal scorer |
      | Man Utd   | Arsenal   | 3               | 4               | Ryan Giggs  | Jack Wilshere          |
    And the submit button is clicked
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer | Additional Goal scorer | Status             |
      | user1  | Man Utd 3 - 4 Arsenal | Ryan Giggs  | Jack Wilshere          | Match Not Complete |

  @timecop
  Scenario: The predictions form should be populated with the scores and scorers that the user has predicted
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 3               | 4               | Wayne Rooney | Jack Wilshere          |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    Then the predictions form should contain the following predictions
      | Home team | Away team | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | 3               | 4               | Wayne Rooney | Jack Wilshere          |


  @timecop
  Scenario: The user should be able to view the predictions made by other players
    Given user 2 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer  | Status             |
      | user2  | Man Utd 1 - 0 Sunderland | Wayne Rooney | Match Not Complete |

  @timecop
  Scenario: The users prediction should be added to the table of predictions as they have selected the same scoreline but different scorer
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team  |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Sunderland |
    And user 2 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team  | Home team score | Away team score | Goal scorer |
      | Man Utd   | Sunderland | 1               | 0               | Ryan Giggs  |
    And the submit button is clicked
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer  | Status             |
      | user2  | Man Utd 1 - 0 Sunderland | Wayne Rooney | Match Not Complete |
      | user1  | Man Utd 1 - 0 Sunderland | Ryan Giggs   | Match Not Complete |

  @timecop
  Scenario: The users prediction should be added to the table of predictions as they have selected the same scorer but different scoreline
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team  |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Sunderland |
    And user 2 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team  | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | 3               | 4               | Wayne Rooney |
    And the submit button is clicked
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer  | Status             |
      | user1  | Man Utd 3 - 4 Sunderland | Wayne Rooney | Match Not Complete |
      | user2  | Man Utd 1 - 0 Sunderland | Wayne Rooney | Match Not Complete |

  @timecop
  Scenario: The user should be presented with the invalid prediction error as the scoreline and goal scorer have been selected by another player
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team  |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Sunderland |
    And user 2 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team  | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | 1               | 0               | Wayne Rooney |
    And the submit button is clicked
    Then the user should be presented with a prediction duplication error
    And the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer  | Status             |
      | user2  | Man Utd 1 - 0 Sunderland | Wayne Rooney | Match Not Complete |

  @timecop
  Scenario: The users bonus prediction should be added to the table of predictions as they have selected the same scoreline but different scorer for home team
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Arsenal   |
    And user 2 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney | Jack Wilshere          |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team | Home team score | Away team score | Goal scorer | Additional Goal scorer |
      | Man Utd   | Arsenal   | 1               | 0               | Ryan Giggs  | Jack Wilshere          |
    And the submit button is clicked
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Additional Goal scorer | Status             |
      | user2  | Man Utd 1 - 0 Arsenal | Wayne Rooney | Jack Wilshere          | Match Not Complete |
      | user1  | Man Utd 1 - 0 Arsenal | Ryan Giggs   | Jack Wilshere          | Match Not Complete |

  @timecop
  Scenario: The users bonus prediction should be added to the table of predictions as they have selected the same scorers but different scoreline
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team  |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Sunderland |
    And user 2 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney | Jack Wilshere          |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | 3               | 4               | Wayne Rooney | Jack Wilshere          |
    And the submit button is clicked
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Additional Goal scorer | Status             |
      | user1  | Man Utd 3 - 4 Arsenal | Wayne Rooney | Jack Wilshere          | Match Not Complete |
      | user2  | Man Utd 1 - 0 Arsenal | Wayne Rooney | Jack Wilshere          | Match Not Complete |

  @timecop
  Scenario: The user should be presented with the invalid prediction error as the scoreline and both goal scorer have been selected by another player for this bonus fixture
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Arsenal   |
    And user 2 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney | Jack Wilshere          |
    And the current date is Saturday 9 November 2013 12:00
    When user 1 signs in and visits the predictions page
    And the predictions form is filled with the following:
      | Home team | Away team | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | 1               | 0               | Wayne Rooney | Jack Wilshere          |
    And the submit button is clicked
    Then the user should be presented with a prediction duplication error
    And the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Additional Goal scorer | Status             |
      | user2  | Man Utd 1 - 0 Arsenal | Wayne Rooney | Jack Wilshere          | Match Not Complete |


  @timecop
  Scenario: The user should be awarded 5 points and the status of their bonus prediction should be updated to correct
  prediction when they have predicted the correct scoreline and scorer for home and away team
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney | Jack Wilshere          |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 1               | 1               | Wayne Rooney      | Jack Wilshere     |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Additional Goal scorer | Status                   |
      | user1  | Man Utd 1 - 1 Arsenal | Wayne Rooney | Jack Wilshere          | Correct Bonus Prediction |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 5      | 1     |

  @timecop
  Scenario: The user should be awarded 5 points and the status of their bonus prediction should be updated to correct
  prediction when they have predicted the correct scoreline and scorer for home and no scorer for away team
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney | no scorer              |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 1               | 0               | Wayne Rooney      |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Additional Goal scorer | Status                   |
      | user1  | Man Utd 1 - 0 Arsenal | Wayne Rooney | no scorer              | Correct Bonus Prediction |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 5      | 1     |

  @timecop
  Scenario: The user should be awarded 5 points and the status of their bonus prediction should be updated to correct
  prediction when they have predicted the correct scoreline and correct scorer for both home and away team (0-0 draw)
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 0               | 0               | no scorer   | no scorer              |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 0               | 0               |                   |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer | Additional Goal scorer | Status                   |
      | user1  | Man Utd 0 - 0 Arsenal | no scorer   | no scorer              | Correct Bonus Prediction |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 5      | 1     |


  @timecop
  Scenario: The user should be awarded 3 points and the status of their bonus prediction should be updated to correct
  scorers when they have predicted the correct scorer for home and away team but incorrect scoreline
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 2               | Wayne Rooney | Jack Wilshere          |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 1               | 1               | Wayne Rooney      | Jack Wilshere     |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Additional Goal scorer | Status               |
      | user1  | Man Utd 1 - 2 Arsenal | Wayne Rooney | Jack Wilshere          | Both Scorers Correct |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 3      | 1     |

  @timecop
  Scenario: The user should be awarded 3 points and the status of their bonus prediction should be updated to correct
  scoreline + 1 scorer when they have predicted the correct scoreline and one correct scorer
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney | no scorer              |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 1               | 1               | Wayne Rooney      | Jack Wilshere     |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Additional Goal scorer | Status                       |
      | user1  | Man Utd 1 - 1 Arsenal | Wayne Rooney | no scorer              | Correct Scoreline + 1 Scorer |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 3      | 1     |

  @timecop
  Scenario: The user should be awarded 1 point and the status of their bonus prediction should be updated to correct
  scorer when they have predicted one correct scorer
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer  | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 2               | Wayne Rooney | no scorer              |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 1               | 1               | Wayne Rooney      | Jack Wilshere     |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer  | Additional Goal scorer | Status         |
      | user1  | Man Utd 1 - 2 Arsenal | Wayne Rooney | no scorer              | Correct Scorer |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 1      | 1     |

  @timecop
  Scenario: The user should be awarded 1 point and the status of their bonus prediction should be updated to correct
  scoreline when they have predicted the correct scoreline
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 2               | no scorer   | no scorer              |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 1               | 2               | Wayne Rooney      | Jack Wilshere     |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer | Additional Goal scorer | Status            |
      | user1  | Man Utd 1 - 2 Arsenal | no scorer   | no scorer              | Correct Scoreline |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 1      | 1     |

  @timecop
  Scenario: The user should be awarded 0 points and the status of their bonus prediction should be updated to incorrect prediction
  when they have predicted the incorrect scorer for home and away team and incorrect scoreline
  scorer when they have predicted one correct scorer
    Given user 1 has predicted the following:
      | Home team | Away team | Kick off                       | Home team score | Away team score | Goal scorer | Additional Goal scorer |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 15:00 | 1               | 2               | no scorer   | no scorer              |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Arsenal   | Saturday 9 November 2013 | 15:00 | 1               | 1               | Wayne Rooney      | Jack Wilshere     |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                | Goal scorer | Additional Goal scorer | Status               |
      | user1  | Man Utd 1 - 2 Arsenal | no scorer   | no scorer              | Incorrect Prediction |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user2 | 0      | 2     |
      | user1 | 0      | 1     |

  @timecop
  Scenario: The user should be awarded 3 points and the status of their prediction should be updated to correct
  prediction when they have predicted the correct scoreline and scorer
    Given user 1 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team  | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Sunderland | Saturday 9 November 2013 | 15:00 | 1               | 1               | Wayne Rooney      |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer  | Status             |
      | user1  | Man Utd 1 - 1 Sunderland | Wayne Rooney | Correct Prediction |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 3      | 1     |

  @timecop
  Scenario: The user should be awarded 3 points and the status of their prediction should be updated to correct
  prediction when they have predicted the correct scoreline and scorer (0-0 draw)
    Given user 1 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 0               | 0               | no scorer   |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team  | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Sunderland | Saturday 9 November 2013 | 15:00 | 0               | 0               |                   |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer | Status             |
      | user1  | Man Utd 0 - 0 Sunderland | no scorer   | Correct Prediction |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 3      | 1     |

  @timecop
  Scenario: The user should be awarded 1 point and the status of their prediction should be updated to correct scoreline
  when they have predicted the correct scoreline but incorrect scorer
    Given user 1 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 0               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team  | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Sunderland | Saturday 9 November 2013 | 15:00 | 1               | 0               | Ryan Giggs        |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer  | Status            |
      | user1  | Man Utd 1 - 0 Sunderland | Wayne Rooney | Correct Scoreline |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 1      | 1     |

  @timecop
  Scenario: The user should be awarded 1 point and the status of their prediction should be updated to correct scorer
  when they have predicted the correct scorer from home team but incorrect scoreline
    Given user 1 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team  | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Sunderland | Saturday 9 November 2013 | 15:00 | 1               | 0               | Wayne Rooney      |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer  | Status         |
      | user1  | Man Utd 1 - 1 Sunderland | Wayne Rooney | Correct Scorer |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 1      | 1     |

  @timecop
  Scenario: The user should be awarded 1 point and the status of their prediction should be updated to correct scorer
  when they have predicted the correct scorer from away team but incorrect scoreline
    Given user 1 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 1               | Adam Johnson |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team  | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Sunderland | Saturday 9 November 2013 | 15:00 | 1               | 2               | Wayne Rooney      | Adam Johnson      |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer  | Status         |
      | user1  | Man Utd 1 - 1 Sunderland | Adam Johnson | Correct Scorer |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 1      | 1     |

  @timecop
  Scenario: The user should be awarded 0 points and the status of their prediction should be updated to incorrect prediction
  when they have predicted the incorrect scorer and incorrect scoreline
    Given user 1 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team  | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Sunderland | Saturday 9 November 2013 | 15:00 | 0               | 0               |                   |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer  | Status               |
      | user1  | Man Utd 1 - 1 Sunderland | Wayne Rooney | Incorrect Prediction |
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user2 | 0      | 2     |
      | user1 | 0      | 1     |

  @timecop
  Scenario: The users predictions should have a status of match not complete if at least 2 hours have not passed
  since the kick off
    Given user 1 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 16:59
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer  | Status             |
      | user1  | Man Utd 1 - 1 Sunderland | Wayne Rooney | Match Not Complete |

  @timecop
  Scenario: The users prediction should have a status match not complete if at least 2 hours have passed since kick off
  but the results for the match have not been published yet
    Given user 1 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Spurs     | Chelsea   | Saturday 9 November 2013 | 12:45 | 0               | 0               |                   |                   |
    When user 1 signs in and visits the predictions page
    Then the table of predictions should contain the following predictions
      | player | Result                   | Goal scorer  | Status             |
      | user1  | Man Utd 1 - 1 Sunderland | Wayne Rooney | Match Not Complete |

  Scenario: The user should be first to pick if he has a lower precedence and has not predicted first on more occasions
  then the other player
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team  |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Sunderland |
    And the users have the following precedence
      | User id | Precedence | Predicted first | Updated at                     |
      | 1       | 1          | 0               | Saturday 2 November 2013 17:00 |
      | 2       | 2          | 0               | Saturday 2 November 2013 17:00 |
    When user 1 signs in and visits the predictions page
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user2 | 0      | 2     |
      | user1 | 0      | 1     |

  Scenario: The user should be second to pick if he has a lower precedence but has predicted first on more occasions
  then the other player
    Given the fixtures for the coming weeks are as follows:
      | Date                     | Time  | Home team | Away team  |
      | Saturday 9 November 2013 | 15:00 | Man Utd   | Sunderland |
    And the users have the following precedence
      | User id | Precedence | Predicted first | Updated at                     |
      | 1       | 1          | 1               | Saturday 2 November 2013 17:00 |
      | 2       | 2          | 0               | Saturday 2 November 2013 17:00 |
    When user 1 signs in and visits the predictions page
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 0      | 2     |
      | user2 | 0      | 1     |

  @timecop
  Scenario: The user who is first to pick should be second to pick after all results have been updated
    Given user 1 has predicted the following:
      | Home team | Away team  | Kick off                       | Home team score | Away team score | Goal scorer  |
      | Man Utd   | Sunderland | Saturday 9 November 2013 15:00 | 1               | 1               | Wayne Rooney |
    And the users have the following precedence
      | User id | Precedence | Predicted first | Updated at                     |
      | 1       | 1          | 0               | Saturday 2 November 2013 17:00 |
      | 2       | 2          | 0               | Saturday 2 November 2013 17:00 |
    And the current date is Saturday 9 November 2013 17:00
    And the results for the fixtures are the following:
      | Home team | Away team  | Date                     | Time  | Home team score | Away team score | Home team scorers | Away team scorers |
      | Man Utd   | Sunderland | Saturday 9 November 2013 | 15:00 | 0               | 0               |                   |                   |
    When user 1 signs in and visits the predictions page
    Then the table of standings should contain the following:
      | User  | Points | Order |
      | user1 | 0      | 2     |
      | user2 | 0      | 1     |






