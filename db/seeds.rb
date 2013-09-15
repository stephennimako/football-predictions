# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# player 1 = mo, player 2 = nelseon player 3 = steve


#dev
#UserPrecedence.create([
#                            {:user_id => 1, :precedence => 1, :predicted_first => 1},
#                            {:user_id => 2, :precedence => 2, :predicted_first => 0},
#                            {:user_id => 3, :precedence => 3, :predicted_first => 0}
#                        ])


#prod
#UserPrecedence.create([
#                            {:user_id => 3, :precedence => 1, :predicted_first => 1},
#                            {:user_id => 4, :precedence => 2, :predicted_first => 0},
#                            {:user_id => 5, :precedence => 3, :predicted_first => 0}
#                        ])


#User.where(:id => 3)[0].update(:name => 'Mo')
#User.where(:id => 4)[0].update(:name => 'Nels')
#User.where(:id => 5)[0].update(:name => 'Stephen')