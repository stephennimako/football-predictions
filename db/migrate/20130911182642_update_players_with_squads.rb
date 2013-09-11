# encoding: utf-8
class UpdatePlayersWithSquads < ActiveRecord::Migration
  def up
    players = [{:name=>"Wojciech Szczesny", :team=>"Arsenal"}, {:name=>"Bacary Sagna", :team=>"Arsenal"}, {:name=>"Per Mertesacker", :team=>"Arsenal"}, {:name=>"Thomas Vermaelen", :team=>"Arsenal"}, {:name=>"Laurent Koscielny", :team=>"Arsenal"}, {:name=>"Tomas Rosicky", :team=>"Arsenal"}, {:name=>"Mikel Arteta", :team=>"Arsenal"}, {:name=>"Lukas Podolski", :team=>"Arsenal"}, {:name=>"Mesut Özil", :team=>"Arsenal"}, {:name=>"Olivier Giroud", :team=>"Arsenal"}, {:name=>"Emiliano Viviano", :team=>"Arsenal"}, {:name=>"Theo Walcott", :team=>"Arsenal"}, {:name=>"Aaron Ramsey", :team=>"Arsenal"}, {:name=>"Nacho Monreal", :team=>"Arsenal"}, {:name=>"Santiago Cazorla", :team=>"Arsenal"}, {:name=>"Mathieu Flamini", :team=>"Arsenal"}, {:name=>"Lukasz Fabianski", :team=>"Arsenal"}, {:name=>"Yaya Sanogo", :team=>"Arsenal"}, {:name=>"Vassiriki Abou Diaby", :team=>"Arsenal"}, {:name=>"Kieran Gibbs", :team=>"Arsenal"}, {:name=>"Park Chu-Young", :team=>"Arsenal"}, {:name=>"Nicklas Bendtner", :team=>"Arsenal"}, {:name=>"Gedion Zelalem", :team=>"Arsenal"}, {:name=>"Johan Djourou", :team=>"Arsenal"}, {:name=>"Jack Wilshere", :team=>"Arsenal"}, {:name=>"Alex Oxlade-Chamberlain", :team=>"Arsenal"}, {:name=>"Carl Jenkinson", :team=>"Arsenal"}, {:name=>"Emmanuel Frimpong", :team=>"Arsenal"}, {:name=>"Ryo Miyaichi", :team=>"Arsenal"}, {:name=>"Thomas Eisfeld", :team=>"Arsenal"}, {:name=>"Damián Martinez", :team=>"Arsenal"}, {:name=>"Serge Gnabry", :team=>"Arsenal"}, {:name=>"Nicholas Yennaris", :team=>"Arsenal"}, {:name=>"Brad Guzan", :team=>"Aston Villa"}, {:name=>"Joe Bennett", :team=>"Aston Villa"}, {:name=>"Ron Vlaar", :team=>"Aston Villa"}, {:name=>"Jores Okore", :team=>"Aston Villa"}, {:name=>"Ciaran Clark", :team=>"Aston Villa"}, {:name=>"Leandro Bacuna", :team=>"Aston Villa"}, {:name=>"Karim El Ahmadi", :team=>"Aston Villa"}, {:name=>"Nicklas Helenius", :team=>"Aston Villa"}, {:name=>"Gabriel Agbonlahor", :team=>"Aston Villa"}, {:name=>"Marc Albrighton", :team=>"Aston Villa"}, {:name=>"Antonio Luna", :team=>"Aston Villa"}, {:name=>"Ashley Westwood", :team=>"Aston Villa"}, {:name=>"Fabian Delph", :team=>"Aston Villa"}, {:name=>"Chris Herd", :team=>"Aston Villa"}, {:name=>"Yacouba Sylla", :team=>"Aston Villa"}, {:name=>"Christian Benteke", :team=>"Aston Villa"}, {:name=>"Aleksandar Tonev", :team=>"Aston Villa"}, {:name=>"Libor Kozák", :team=>"Aston Villa"}, {:name=>"Matthew Lowton", :team=>"Aston Villa"}, {:name=>"Shay Given", :team=>"Aston Villa"}, {:name=>"Charles N'Zogbia", :team=>"Aston Villa"}, {:name=>"Alan Hutton", :team=>"Aston Villa"}, {:name=>"Benjamin Siegrist", :team=>"Aston Villa"}, {:name=>"Nathan Baker", :team=>"Aston Villa"}, {:name=>"Andreas Weimann", :team=>"Aston Villa"}, {:name=>"Jed Steer", :team=>"Aston Villa"}, {:name=>"Jordan Bowery", :team=>"Aston Villa"}, {:name=>"Gary Gardner", :team=>"Aston Villa"}, {:name=>"Daniel Johnson", :team=>"Aston Villa"}, {:name=>"David Marshall", :team=>"Cardiff"}, {:name=>"Matthew Connolly", :team=>"Cardiff"}, {:name=>"Andrew Taylor", :team=>"Cardiff"}, {:name=>"Mark Hudson", :team=>"Cardiff"}, {:name=>"Ben Turner", :team=>"Cardiff"}, {:name=>"Peter Whittingham", :team=>"Cardiff"}, {:name=>"Gary Medel", :team=>"Cardiff"}, {:name=>"Andreas Cornelius", :team=>"Cardiff"}, {:name=>"Fraizer Campbell", :team=>"Cardiff"}, {:name=>"Peter Odemwingie", :team=>"Cardiff"}, {:name=>"John Brayford", :team=>"Cardiff"}, {:name=>"Kim Bo-Kyung", :team=>"Cardiff"}, {:name=>"Tommy Smith", :team=>"Cardiff"}, {:name=>"Rudy Gestede", :team=>"Cardiff"}, {:name=>"Craig Noone", :team=>"Cardiff"}, {:name=>"Aron Gunnarsson", :team=>"Cardiff"}, {:name=>"Jordon Mutch", :team=>"Cardiff"}, {:name=>"Don Cowie", :team=>"Cardiff"}, {:name=>"Joe Mason", :team=>"Cardiff"}, {:name=>"Craig Conway", :team=>"Cardiff"}, {:name=>"Nicky Maynard", :team=>"Cardiff"}, {:name=>"Simon Lappin", :team=>"Cardiff"}, {:name=>"Kevin McNaughton", :team=>"Cardiff"}, {:name=>"Filip Kiss", :team=>"Cardiff"}, {:name=>"Etien Velikonja", :team=>"Cardiff"}, {:name=>"Kévin Théophile-Catherine", :team=>"Cardiff"}, {:name=>"Maximiliano Amondarain", :team=>"Cardiff"}, {:name=>"Joe Lewis", :team=>"Cardiff"}, {:name=>"Simon Moore", :team=>"Cardiff"}, {:name=>"Craig Bellamy", :team=>"Cardiff"}, {:name=>"Kadeem Harris", :team=>"Cardiff"}, {:name=>"Adedeji Oshilaja", :team=>"Cardiff"}, {:name=>"Declan John", :team=>"Cardiff"}, {:name=>"Dave Richards", :team=>"Cardiff"}, {:name=>"Steven Caulker", :team=>"Cardiff"}, {:name=>"Petr Cech", :team=>"Chelsea"}, {:name=>"Branislav Ivanovic", :team=>"Chelsea"}, {:name=>"Ashley Cole", :team=>"Chelsea"}, {:name=>"David Luiz", :team=>"Chelsea"}, {:name=>"Michael Essien", :team=>"Chelsea"}, {:name=>"Ramires", :team=>"Chelsea"}, {:name=>"Frank Lampard", :team=>"Chelsea"}, {:name=>"Fernando Torres", :team=>"Chelsea"}, {:name=>"Juan Mata", :team=>"Chelsea"}, {:name=>"John Obi Mikel", :team=>"Chelsea"}, {:name=>"Andre Schürrle", :team=>"Chelsea"}, {:name=>"Marco van Ginkel", :team=>"Chelsea"}, {:name=>"Demba Ba", :team=>"Chelsea"}, {:name=>"Willian", :team=>"Chelsea"}, {:name=>"Mark Schwarzer", :team=>"Chelsea"}, {:name=>"Gary Cahill", :team=>"Chelsea"}, {:name=>"John Terry", :team=>"Chelsea"}, {:name=>"César Azpilicueta", :team=>"Chelsea"}, {:name=>"Samuel Eto'o", :team=>"Chelsea"}, {:name=>"Tomas Kalas", :team=>"Chelsea"}, {:name=>"Ryan Bertrand", :team=>"Chelsea"}, {:name=>"Henrique Hilário", :team=>"Chelsea"}, {:name=>"Oscar", :team=>"Chelsea"}, {:name=>"Kevin De Bruyne", :team=>"Chelsea"}, {:name=>"Eden Hazard", :team=>"Chelsea"}, {:name=>"Joshua McEachran", :team=>"Chelsea"}, {:name=>"Nathaniel Chalobah", :team=>"Chelsea"}, {:name=>"Jamal Blackman", :team=>"Chelsea"}, {:name=>"Nathan Aké", :team=>"Chelsea"}, {:name=>"Julian Speroni", :team=>"Crystal Palace"}, {:name=>"Joel Ward", :team=>"Crystal Palace"}, {:name=>"Jack Hunt", :team=>"Crystal Palace"}, {:name=>"Jonathan Parr", :team=>"Crystal Palace"}, {:name=>"Patrick McCarthy", :team=>"Crystal Palace"}, {:name=>"José Campaña", :team=>"Crystal Palace"}, {:name=>"Yannick Bolasie", :team=>"Crystal Palace"}, {:name=>"Kagisho Dikgacoi", :team=>"Crystal Palace"}, {:name=>"Kevin Phillips", :team=>"Crystal Palace"}, {:name=>"Owen Garvan", :team=>"Crystal Palace"}, {:name=>"Stephen Dobbie", :team=>"Crystal Palace"}, {:name=>"Stuart O'Keefe", :team=>"Crystal Palace"}, {:name=>"Jason Puncheon", :team=>"Crystal Palace"}, {:name=>"Jerome Thomas", :team=>"Crystal Palace"}, {:name=>"Mile Jedinak", :team=>"Crystal Palace"}, {:name=>"Dwight Gayle", :team=>"Crystal Palace"}, {:name=>"Glenn Murray", :team=>"Crystal Palace"}, {:name=>"Aaron Wilbraham", :team=>"Crystal Palace"}, {:name=>"Daniel Gabbidon", :team=>"Crystal Palace"}, {:name=>"Jonathan Williams", :team=>"Crystal Palace"}, {:name=>"Dean Moxey", :team=>"Crystal Palace"}, {:name=>"Jimmy Kébé", :team=>"Crystal Palace"}, {:name=>"Florian Marange", :team=>"Crystal Palace"}, {:name=>"Elliot Grandin", :team=>"Crystal Palace"}, {:name=>"Neil Alexander", :team=>"Crystal Palace"}, {:name=>"Matthew Parsons", :team=>"Crystal Palace"}, {:name=>"Damien Delaney", :team=>"Crystal Palace"}, {:name=>"Adrian Mariappa", :team=>"Crystal Palace"}, {:name=>"Marouane Chamakh", :team=>"Crystal Palace"}, {:name=>"Cameron Jerome", :team=>"Crystal Palace"}, {:name=>"Barry Bannan", :team=>"Crystal Palace"}, {:name=>"Kwesi Appiah", :team=>"Crystal Palace"}, {:name=>"Ibra Sekajja", :team=>"Crystal Palace"}, {:name=>"Lewis Price", :team=>"Crystal Palace"}, {:name=>"Kyle De Silva", :team=>"Crystal Palace"}, {:name=>"Alex Wynter", :team=>"Crystal Palace"}, {:name=>"Hiram Boateng", :team=>"Crystal Palace"}, {:name=>"Reise Allassani", :team=>"Crystal Palace"}, {:name=>"Ross Fitzsimons", :team=>"Crystal Palace"}, {:name=>"Quade Taylor", :team=>"Crystal Palace"}, {:name=>"Adlène Guédioura", :team=>"Crystal Palace"}, {:name=>"Jerome Williams", :team=>"Crystal Palace"}, {:name=>"Darcy Blake", :team=>"Crystal Palace"}, {:name=>"Osman Sow", :team=>"Crystal Palace"}, {:name=>"Jack Hunt", :team=>"Crystal Palace"}, {:name=>"Jonathan Parr", :team=>"Crystal Palace"}, {:name=>"Patrick McCarthy", :team=>"Crystal Palace"}, {:name=>"Yannick Bolasie", :team=>"Crystal Palace"}, {:name=>"Jerome Thomas", :team=>"Crystal Palace"}, {:name=>"Glenn Murray", :team=>"Crystal Palace"}, {:name=>"Jonathan Williams", :team=>"Crystal Palace"}, {:name=>"Jimmy Kébé", :team=>"Crystal Palace"}, {:name=>"Joel Robles", :team=>"Everton"}, {:name=>"Tony Hibbert", :team=>"Everton"}, {:name=>"Leighton Baines", :team=>"Everton"}, {:name=>"Darron Gibson", :team=>"Everton"}, {:name=>"Johnny Heitinga", :team=>"Everton"}, {:name=>"Phil Jagielka", :team=>"Everton"}, {:name=>"Nikica Jelavic", :team=>"Everton"}, {:name=>"Bryan Oviedo", :team=>"Everton"}, {:name=>"Arouna Koné", :team=>"Everton"}, {:name=>"Gerard Deulofeu", :team=>"Everton"}, {:name=>"Kevin Mirallas", :team=>"Everton"}, {:name=>"Steven Naismith", :team=>"Everton"}, {:name=>"Sylvain Distin", :team=>"Everton"}, {:name=>"James McCarthy", :team=>"Everton"}, {:name=>"Gareth Barry", :team=>"Everton"}, {:name=>"Magaye Gueye", :team=>"Everton"}, {:name=>"Leon Osman", :team=>"Everton"}, {:name=>"Steven Pienaar", :team=>"Everton"}, {:name=>"Steven Pienaar", :team=>"Everton"}, {:name=>"Seamus Coleman", :team=>"Everton"}, {:name=>"Tim Howard", :team=>"Everton"}, {:name=>"Antolin Alcaraz", :team=>"Everton"}, {:name=>"John Lundstram", :team=>"Everton"}, {:name=>"Ibou Touray", :team=>"Everton"}, {:name=>"Mason Springthorpe", :team=>"Everton"}, {:name=>"Romelu Lukaku", :team=>"Everton"}, {:name=>"Ross Barkley", :team=>"Everton"}, {:name=>"John Stones", :team=>"Everton"}, {:name=>"Apostolos Vellios", :team=>"Everton"}, {:name=>"Luke Garbutt", :team=>"Everton"}, {:name=>"Matthew Kennedy", :team=>"Everton"}, {:name=>"Shane Duffy", :team=>"Everton"}, {:name=>"Conor McAleny", :team=>"Everton"}, {:name=>"Maarten Stekelenburg", :team=>"Fulham"}, {:name=>"John Arne Riise", :team=>"Fulham"}, {:name=>"Philippe Senderos", :team=>"Fulham"}, {:name=>"Brede Hangeland", :team=>"Fulham"}, {:name=>"Steve Sidwell", :team=>"Fulham"}, {:name=>"Dimitar Berbatov", :team=>"Fulham"}, {:name=>"Bryan Ruiz", :team=>"Fulham"}, {:name=>"David Stockdale", :team=>"Fulham"}, {:name=>"Giorgos Karagounis", :team=>"Fulham"}, {:name=>"Kieran Richardson", :team=>"Fulham"}, {:name=>"Damien Duff", :team=>"Fulham"}, {:name=>"Aaron Hughes", :team=>"Fulham"}, {:name=>"Adel Taarabt", :team=>"Fulham"}, {:name=>"Hugo Rodallega", :team=>"Fulham"}, {:name=>"Elsad Zverotic", :team=>"Fulham"}, {:name=>"Derek Boateng", :team=>"Fulham"}, {:name=>"Ashkan Dejagah", :team=>"Fulham"}, {:name=>"Sascha Riether", :team=>"Fulham"}, {:name=>"Scott Parker", :team=>"Fulham"}, {:name=>"Chris David", :team=>"Fulham"}, {:name=>"Fernando Amorebieta", :team=>"Fulham"}, {:name=>"Mesca", :team=>"Fulham"}, {:name=>"Neil Etheridge", :team=>"Fulham"}, {:name=>"Darren Bent", :team=>"Fulham"}, {:name=>"Pajtim Kasami", :team=>"Fulham"}, {:name=>"Alexander Kacaniklic", :team=>"Fulham"}, {:name=>"Matthew Briggs", :team=>"Fulham"}, {:name=>"Charles Banya", :team=>"Fulham"}, {:name=>"Muamer Tankovic", :team=>"Fulham"}, {:name=>"Jack Grimmer", :team=>"Fulham"}, {:name=>"Allan McGregor", :team=>"Hull"}, {:name=>"Liam Rosenior", :team=>"Hull"}, {:name=>"Maynor Figueroa", :team=>"Hull"}, {:name=>"Alex Bruce", :team=>"Hull"}, {:name=>"James Chester", :team=>"Hull"}, {:name=>"Curtis Davies", :team=>"Hull"}, {:name=>"David Meyler", :team=>"Hull"}, {:name=>"Tom Huddlestone", :team=>"Hull"}, {:name=>"Danny Graham", :team=>"Hull"}, {:name=>"Robert Koren", :team=>"Hull"}, {:name=>"Robbie Brady", :team=>"Hull"}, {:name=>"Matty Fryatt", :team=>"Hull"}, {:name=>"Jake Livermore", :team=>"Hull"}, {:name=>"Paul McShane", :team=>"Hull"}, {:name=>"Eldin Jakupovic", :team=>"Hull"}, {:name=>"George Boyd", :team=>"Hull"}, {:name=>"Gedo", :team=>"Hull"}, {:name=>"Joe Dudgeon", :team=>"Hull"}, {:name=>"Yannick Sagbo", :team=>"Hull"}, {:name=>"Aaron McLean", :team=>"Hull"}, {:name=>"Steve Harper", :team=>"Hull"}, {:name=>"Abdoulaye Faye", :team=>"Hull"}, {:name=>"Sone Aluko", :team=>"Hull"}, {:name=>"Ahmed Elmohamady", :team=>"Hull"}, {:name=>"Stephen Quinn", :team=>"Hull"}, {:name=>"Calaum Jahraldo-Martin", :team=>"Hull"}, {:name=>"Nick Proschwitz", :team=>"Hull"}, {:name=>"Joe Cracknell", :team=>"Hull"}, {:name=>"Dougie Wilson", :team=>"Hull"}, {:name=>"Allan McGregor", :team=>"Hull"}, {:name=>"George Boyd", :team=>"Hull"}, {:name=>"Abdoulaye Faye", :team=>"Hull"}, {:name=>"Sone Aluko", :team=>"Hull"}, {:name=>"Bradley Jones", :team=>"Liverpool"}, {:name=>"Glen Johnson", :team=>"Liverpool"}, {:name=>"José Enrique", :team=>"Liverpool"}, {:name=>"Kolo Touré", :team=>"Liverpool"}, {:name=>"Daniel Agger", :team=>"Liverpool"}, {:name=>"Luis Alberto", :team=>"Liverpool"}, {:name=>"Luis Suárez", :team=>"Liverpool"}, {:name=>"Steven Gerrard", :team=>"Liverpool"}, {:name=>"Iago Aspas", :team=>"Liverpool"}, {:name=>"Philippe Coutinho", :team=>"Liverpool"}, {:name=>"Victor Moses", :team=>"Liverpool"}, {:name=>"Jordan Henderson", :team=>"Liverpool"}, {:name=>"Daniel Sturridge", :team=>"Liverpool"}, {:name=>"Sebastián Coates", :team=>"Liverpool"}, {:name=>"Mamadou Sakho", :team=>"Liverpool"}, {:name=>"Aly Cissokho", :team=>"Liverpool"}, {:name=>"Lucas Leiva", :team=>"Liverpool"}, {:name=>"Simon Mignolet", :team=>"Liverpool"}, {:name=>"Joe Allen", :team=>"Liverpool"}, {:name=>"Tiago Ilori", :team=>"Liverpool"}, {:name=>"Jordon Ibe", :team=>"Liverpool"}, {:name=>"Martin Kelly", :team=>"Liverpool"}, {:name=>"Martin Skrtel", :team=>"Liverpool"}, {:name=>"Raheem Sterling", :team=>"Liverpool"}, {:name=>"Jon Flanagan", :team=>"Liverpool"}, {:name=>"Andre Wisdom", :team=>"Liverpool"}, {:name=>"Joe Hart", :team=>"Man City"}, {:name=>"Micah Richards", :team=>"Man City"}, {:name=>"Vincent Kompany", :team=>"Man City"}, {:name=>"Pablo Zabaleta", :team=>"Man City"}, {:name=>"Joleon Lescott", :team=>"Man City"}, {:name=>"James Milner", :team=>"Man City"}, {:name=>"Samir Nasri", :team=>"Man City"}, {:name=>"Álvaro Negredo", :team=>"Man City"}, {:name=>"Edin Dzeko", :team=>"Man City"}, {:name=>"Aleksandar Kolarov", :team=>"Man City"}, {:name=>"Javi García", :team=>"Man City"}, {:name=>"Jesús Navas", :team=>"Man City"}, {:name=>"Sergio Agüero", :team=>"Man City"}, {:name=>"David Silva", :team=>"Man City"}, {:name=>"Gaël Clichy", :team=>"Man City"}, {:name=>"Fernandinho", :team=>"Man City"}, {:name=>"Martín Demichelis", :team=>"Man City"}, {:name=>"Richard Wright", :team=>"Man City"}, {:name=>"Costel Pantilimon", :team=>"Man City"}, {:name=>"Stevan Jovetic", :team=>"Man City"}, {:name=>"Dedryck Boyata", :team=>"Man City"}, {:name=>"Yaya Touré", :team=>"Man City"}, {:name=>"Jack Rodwell", :team=>"Man City"}, {:name=>"Matija Nastasic", :team=>"Man City"}, {:name=>"Alex Nimely", :team=>"Man City"}, {:name=>"John Guidetti", :team=>"Man City"}, {:name=>"David De Gea", :team=>"Man Utd"}, {:name=>"Rafael", :team=>"Man Utd"}, {:name=>"Patrice Evra", :team=>"Man Utd"}, {:name=>"Rio Ferdinand", :team=>"Man Utd"}, {:name=>"Jonny Evans", :team=>"Man Utd"}, {:name=>"Anderson", :team=>"Man Utd"}, {:name=>"Wayne Rooney", :team=>"Man Utd"}, {:name=>"Ryan Giggs", :team=>"Man Utd"}, {:name=>"Chris Smalling", :team=>"Man Utd"}, {:name=>"Anders Lindegaard", :team=>"Man Utd"}, {:name=>"Javier Hernández", :team=>"Man Utd"}, {:name=>"Nemanja Vidic", :team=>"Man Utd"}, {:name=>"Michael Carrick", :team=>"Man Utd"}, {:name=>"Nani", :team=>"Man Utd"}, {:name=>"Ashley Young", :team=>"Man Utd"}, {:name=>"Danny Welbeck", :team=>"Man Utd"}, {:name=>"Robin van Persie", :team=>"Man Utd"}, {:name=>"Fabio", :team=>"Man Utd"}, {:name=>"Tom Cleverley", :team=>"Man Utd"}, {:name=>"Darren Fletcher", :team=>"Man Utd"}, {:name=>"Antonio Valencia", :team=>"Man Utd"}, {:name=>"Shinji Kagawa", :team=>"Man Utd"}, {:name=>"Alexander Büttner", :team=>"Man Utd"}, {:name=>"Guillermo Varela", :team=>"Man Utd"}, {:name=>"Marouane Fellaini", :team=>"Man Utd"}, {:name=>"Ben Amos", :team=>"Man Utd"}, {:name=>"Adnan Januzaj", :team=>"Man Utd"}, {:name=>"Phil Jones", :team=>"Man Utd"}, {:name=>"Federico Macheda", :team=>"Man Utd"}, {:name=>"Wilfried Zaha", :team=>"Man Utd"}, {:name=>"Michael Keane", :team=>"Man Utd"}, {:name=>"Federico Macheda", :team=>"Man Utd"}, {:name=>"Tim Krul", :team=>"Newcastle"}, {:name=>"Fabricio Coloccini", :team=>"Newcastle"}, {:name=>"Yohan Cabaye", :team=>"Newcastle"}, {:name=>"Michael Williamson", :team=>"Newcastle"}, {:name=>"Moussa Sissoko", :team=>"Newcastle"}, {:name=>"Vurnon Anita", :team=>"Newcastle"}, {:name=>"Papiss Demba Cissé", :team=>"Newcastle"}, {:name=>"Hatem Ben Arfa", :team=>"Newcastle"}, {:name=>"Yoan Gouffran", :team=>"Newcastle"}, {:name=>"Mapou Yanga-Mbiwa", :team=>"Newcastle"}, {:name=>"Loïc Remy", :team=>"Newcastle"}, {:name=>"Dan Gosling", :team=>"Newcastle"}, {:name=>"Ryan Taylor", :team=>"Newcastle"}, {:name=>"Jonás Gutiérrez", :team=>"Newcastle"}, {:name=>"Massadio Haidara", :team=>"Newcastle"}, {:name=>"Robert Elliot", :team=>"Newcastle"}, {:name=>"Sylvain Marveaux", :team=>"Newcastle"}, {:name=>"Shola Ameobi", :team=>"Newcastle"}, {:name=>"Cheik Tioté", :team=>"Newcastle"}, {:name=>"Gabriel Obertan", :team=>"Newcastle"}, {:name=>"Mathieu Debuchy", :team=>"Newcastle"}, {:name=>"Steven Taylor", :team=>"Newcastle"}, {:name=>"Curtis Good", :team=>"Newcastle"}, {:name=>"Jak Alnwick", :team=>"Newcastle"}, {:name=>"Davide Santon", :team=>"Newcastle"}, {:name=>"Gael Bigirimana", :team=>"Newcastle"}, {:name=>"Sammy Ameobi", :team=>"Newcastle"}, {:name=>"Haris Vuckic", :team=>"Newcastle"}, {:name=>"James Tavernier", :team=>"Newcastle"}, {:name=>"Paul Dummett", :team=>"Newcastle"}, {:name=>"Remie Streete", :team=>"Newcastle"}, {:name=>"John Ruddy", :team=>"Norwich"}, {:name=>"Russell Martin", :team=>"Norwich"}, {:name=>"Steven Whittaker", :team=>"Norwich"}, {:name=>"Bradley Johnson", :team=>"Norwich"}, {:name=>"Sébastien Bassong", :team=>"Norwich"}, {:name=>"Michael Turner", :team=>"Norwich"}, {:name=>"Robert Snodgrass", :team=>"Norwich"}, {:name=>"Jonathan Howson", :team=>"Norwich"}, {:name=>"Ricky van Wolfswinkel", :team=>"Norwich"}, {:name=>"Leroy Fer", :team=>"Norwich"}, {:name=>"Gary Hooper", :team=>"Norwich"}, {:name=>"Anthony Pilkington", :team=>"Norwich"}, {:name=>"Mark Bunn", :team=>"Norwich"}, {:name=>"Wes Hoolahan", :team=>"Norwich"}, {:name=>"Johan Elmander", :team=>"Norwich"}, {:name=>"Elliott Bennett", :team=>"Norwich"}, {:name=>"Javier Garrido", :team=>"Norwich"}, {:name=>"Luciano Becchio", :team=>"Norwich"}, {:name=>"Carlo Nash", :team=>"Norwich"}, {:name=>"Nathan Redmond", :team=>"Norwich"}, {:name=>"Martin Olsson", :team=>"Norwich"}, {:name=>"Ryan Bennett", :team=>"Norwich"}, {:name=>"David Fox", :team=>"Norwich"}, {:name=>"Daniel Ayala", :team=>"Norwich"}, {:name=>"Alexander Tettey", :team=>"Norwich"}, {:name=>"Jamar Loza", :team=>"Norwich"}, {:name=>"Ollie Cole", :team=>"Norwich"}, {:name=>"Gary Hooper", :team=>"Norwich"}, {:name=>"Elliott Bennett", :team=>"Norwich"}, {:name=>"Ryan Bennett", :team=>"Norwich"}, {:name=>"Kelvin Davis", :team=>"Southampton"}, {:name=>"Maya Yoshida", :team=>"Southampton"}, {:name=>"Morgan Schneiderlin", :team=>"Southampton"}, {:name=>"Dejan Lovren", :team=>"Southampton"}, {:name=>"Jose Fonte", :team=>"Southampton"}, {:name=>"Rickie Lambert", :team=>"Southampton"}, {:name=>"Steven Davis", :team=>"Southampton"}, {:name=>"Jay Rodriguez", :team=>"Southampton"}, {:name=>"Gastón Ramírez", :team=>"Southampton"}, {:name=>"Victor Wanyama", :team=>"Southampton"}, {:name=>"Daniel Fox", :team=>"Southampton"}, {:name=>"Pablo Osvaldo", :team=>"Southampton"}, {:name=>"Jack Cork", :team=>"Southampton"}, {:name=>"Adam Lallana", :team=>"Southampton"}, {:name=>"Guly", :team=>"Southampton"}, {:name=>"Jos Hooiveld", :team=>"Southampton"}, {:name=>"Artur Boruc", :team=>"Southampton"}, {:name=>"Omar Rowe", :team=>"Southampton"}, {:name=>"Harrison Reed", :team=>"Southampton"}, {:name=>"Aaron Martin", :team=>"Southampton"}, {:name=>"Billy Sharp", :team=>"Southampton"}, {:name=>"Craig Richards", :team=>"Southampton"}, {:name=>"Jonathan Forte", :team=>"Southampton"}, {:name=>"Lee Barnard", :team=>"Southampton"}, {:name=>"Marcelo Tejera", :team=>"Southampton"}, {:name=>"Matt Targett", :team=>"Southampton"}, {:name=>"Tadanari Lee", :team=>"Southampton"}, {:name=>"Zac Jones", :team=>"Southampton"}, {:name=>"Nathaniel Clyne", :team=>"Southampton"}, {:name=>"James Ward-Prowse", :team=>"Southampton"}, {:name=>"Calum Chambers", :team=>"Southampton"}, {:name=>"Luke Shaw", :team=>"Southampton"}, {:name=>"Paulo Gazzaniga", :team=>"Southampton"}, {:name=>"Lloyd Isgrove", :team=>"Southampton"}, {:name=>"Jack Stephens", :team=>"Southampton"}, {:name=>"Jake Sinclair", :team=>"Southampton"}, {:name=>"Asmir Begovic", :team=>"Stoke"}, {:name=>"Erik Pieters", :team=>"Stoke"}, {:name=>"Robert Huth", :team=>"Stoke"}, {:name=>"Marc Muniesa", :team=>"Stoke"}, {:name=>"Glenn Whelan", :team=>"Stoke"}, {:name=>"Jermaine Pennant", :team=>"Stoke"}, {:name=>"Wilson Palacios", :team=>"Stoke"}, {:name=>"Kenwyne Jones", :team=>"Stoke"}, {:name=>"Marko Arnautovic", :team=>"Stoke"}, {:name=>"Brek Shea", :team=>"Stoke"}, {:name=>"Marc Wilson", :team=>"Stoke"}, {:name=>"Maurice Edu", :team=>"Stoke"}, {:name=>"Steven N'Zonzi", :team=>"Stoke"}, {:name=>"Charlie Adam", :team=>"Stoke"}, {:name=>"Ryan Shawcross", :team=>"Stoke"}, {:name=>"Jonathan Walters", :team=>"Stoke"}, {:name=>"Geoff Cameron", :team=>"Stoke"}, {:name=>"Oussama Assaidi", :team=>"Stoke"}, {:name=>"Peter Crouch", :team=>"Stoke"}, {:name=>"Matthew Etherington", :team=>"Stoke"}, {:name=>"Andy Wilkinson", :team=>"Stoke"}, {:name=>"Thomas Sørensen", :team=>"Stoke"}, {:name=>"Stephen Ireland", :team=>"Stoke"}, {:name=>"Jordan Keane", :team=>"Stoke"}, {:name=>"Alex Grant", :team=>"Stoke"}, {:name=>"Elliot Wheeler", :team=>"Stoke"}, {:name=>"Juan Agudelo", :team=>"Stoke"}, {:name=>"Jamie Ness", :team=>"Stoke"}, {:name=>"Jack Butland", :team=>"Stoke"}, {:name=>"Phillip Bardsley", :team=>"Sunderland"}, {:name=>"Andrea Dossena", :team=>"Sunderland"}, {:name=>"Ki Sung-Yueng", :team=>"Sunderland"}, {:name=>"Wes Brown", :team=>"Sunderland"}, {:name=>"Cabral", :team=>"Sunderland"}, {:name=>"Sebastian Larsson", :team=>"Sunderland"}, {:name=>"Craig Gardner", :team=>"Sunderland"}, {:name=>"Steven Fletcher", :team=>"Sunderland"}, {:name=>"Adam Johnson", :team=>"Sunderland"}, {:name=>"Ondrej Celustka", :team=>"Sunderland"}, {:name=>"Jordan Pickford", :team=>"Sunderland"}, {:name=>"Jack Colback", :team=>"Sunderland"}, {:name=>"David Vaughan", :team=>"Sunderland"}, {:name=>"John O'Shea", :team=>"Sunderland"}, {:name=>"Jozy Altidore", :team=>"Sunderland"}, {:name=>"Mikael Mandron", :team=>"Sunderland"}, {:name=>"David Moberg-Karlsson", :team=>"Sunderland"}, {:name=>"Keiren Westwood", :team=>"Sunderland"}, {:name=>"Modibo Diakité", :team=>"Sunderland"}, {:name=>"El-Hadji Ba", :team=>"Sunderland"}, {:name=>"Emanuele Giaccherini", :team=>"Sunderland"}, {:name=>"Carlos Cuéllar", :team=>"Sunderland"}, {:name=>"Vito Mannone", :team=>"Sunderland"}, {:name=>"Valentin Roberge", :team=>"Sunderland"}, {:name=>"Lee Cattermole", :team=>"Sunderland"}, {:name=>"Charalampos Mavrias", :team=>"Sunderland"}, {:name=>"Duncan Watmore", :team=>"Sunderland"}, {:name=>"Connor Wickham", :team=>"Sunderland"}, {:name=>"Ji Dong-Won", :team=>"Sunderland"}, {:name=>"Fabio Borini", :team=>"Sunderland"}, {:name=>"Michel Vorm", :team=>"Swansea"}, {:name=>"Jordi Amat", :team=>"Swansea"}, {:name=>"Neil Taylor", :team=>"Swansea"}, {:name=>"Chico", :team=>"Swansea"}, {:name=>"Ashley Williams", :team=>"Swansea"}, {:name=>"Leon Britton", :team=>"Swansea"}, {:name=>"Michu", :team=>"Swansea"}, {:name=>"Wilfried Bony", :team=>"Swansea"}, {:name=>"Pablo Hernández", :team=>"Swansea"}, {:name=>"Nathan Dyer", :team=>"Swansea"}, {:name=>"Roland Lamah", :team=>"Swansea"}, {:name=>"Wayne Routledge", :team=>"Swansea"}, {:name=>"Garry Monk", :team=>"Swansea"}, {:name=>"Leroy Lita", :team=>"Swansea"}, {:name=>"Jonathan De Guzmán", :team=>"Swansea"}, {:name=>"José Cañas", :team=>"Swansea"}, {:name=>"Angel Rangel", :team=>"Swansea"}, {:name=>"Álex Pozuelo", :team=>"Swansea"}, {:name=>"Gerhard Tremmel", :team=>"Swansea"}, {:name=>"Álvaro", :team=>"Swansea"}, {:name=>"Curtis Obeng", :team=>"Swansea"}, {:name=>"Gregor Zabret", :team=>"Swansea"}, {:name=>"Dwight Tiendalli", :team=>"Swansea"}, {:name=>"Kenji Gorre", :team=>"Swansea"}, {:name=>"Jonjo Shelvey", :team=>"Swansea"}, {:name=>"Darnel Situ", :team=>"Swansea"}, {:name=>"Ben Davies", :team=>"Swansea"}, {:name=>"Daniel Alfei", :team=>"Swansea"}, {:name=>"Rory Donnelly", :team=>"Swansea"}, {:name=>"Jernade Meade", :team=>"Swansea"}, {:name=>"Darnel Situ", :team=>"Swansea"}, {:name=>"Heurelho Gomes", :team=>"Tottenham"}, {:name=>"Kyle Walker", :team=>"Tottenham"}, {:name=>"Danny Rose", :team=>"Tottenham"}, {:name=>"Younes Kaboul", :team=>"Tottenham"}, {:name=>"Jan Vertonghen", :team=>"Tottenham"}, {:name=>"Vlad Chiriches", :team=>"Tottenham"}, {:name=>"Aaron Lennon", :team=>"Tottenham"}, {:name=>"Paulinho", :team=>"Tottenham"}, {:name=>"Roberto Soldado", :team=>"Tottenham"}, {:name=>"Emmanuel Adebayor", :team=>"Tottenham"}, {:name=>"Lewis Holtby", :team=>"Tottenham"}, {:name=>"Etienne Capoue", :team=>"Tottenham"}, {:name=>"Kyle Naughton", :team=>"Tottenham"}, {:name=>"Jermain Defoe", :team=>"Tottenham"}, {:name=>"Jermain Defoe", :team=>"Tottenham"}, {:name=>"Mousa Dembélé", :team=>"Tottenham"}, {:name=>"Michael Dawson", :team=>"Tottenham"}, {:name=>"Nacer Chadli", :team=>"Tottenham"}, {:name=>"Gylfi Sigurdsson", :team=>"Tottenham"}, {:name=>"Christian Eriksen", :team=>"Tottenham"}, {:name=>"Brad Friedel", :team=>"Tottenham"}, {:name=>"Hugo Lloris", :team=>"Tottenham"}, {:name=>"Sandro", :team=>"Tottenham"}, {:name=>"Erik Lamela", :team=>"Tottenham"}, {:name=>"Shaquile Coulthirst", :team=>"Tottenham"}, {:name=>"Andros Townsend", :team=>"Tottenham"}, {:name=>"Ezekiel Fryers", :team=>"Tottenham"}, {:name=>"Harry Kane", :team=>"Tottenham"}, {:name=>"Ben Foster", :team=>"West Brom"}, {:name=>"Steven Reid", :team=>"West Brom"}, {:name=>"Jonas Olsson", :team=>"West Brom"}, {:name=>"Goran Popov", :team=>"West Brom"}, {:name=>"Claudio Yacob", :team=>"West Brom"}, {:name=>"Liam Ridgewell", :team=>"West Brom"}, {:name=>"James Morrison", :team=>"West Brom"}, {:name=>"Markus Rosenberg", :team=>"West Brom"}, {:name=>"Shane Long", :team=>"West Brom"}, {:name=>"Scott Sinclair", :team=>"West Brom"}, {:name=>"Chris Brunt", :team=>"West Brom"}, {:name=>"Lee Camp", :team=>"West Brom"}, {:name=>"Boaz Myhill", :team=>"West Brom"}, {:name=>"Diego Lugano", :team=>"West Brom"}, {:name=>"Victor Anichebe", :team=>"West Brom"}, {:name=>"Graham Dorrans", :team=>"West Brom"}, {:name=>"Morgan Amalfitano", :team=>"West Brom"}, {:name=>"Luke Daniels", :team=>"West Brom"}, {:name=>"Matej Vydra", :team=>"West Brom"}, {:name=>"Youssuf Mulumbu", :team=>"West Brom"}, {:name=>"Zoltán Gera", :team=>"West Brom"}, {:name=>"Gareth McAuley", :team=>"West Brom"}, {:name=>"Craig Dawson", :team=>"West Brom"}, {:name=>"Billy Jones", :team=>"West Brom"}, {:name=>"Stéphane Sessegnon", :team=>"West Brom"}, {:name=>"Gabriel Tamas", :team=>"West Brom"}, {:name=>"Nicolas Anelka", :team=>"West Brom"}, {:name=>"Ibrahim Sissoko", :team=>"West Brom"}, {:name=>"George Thorne", :team=>"West Brom"}, {:name=>"Kemar Roofe", :team=>"West Brom"}, {:name=>"Adil Nabi", :team=>"West Brom"}, {:name=>"Saido Berahino", :team=>"West Brom"}, {:name=>"Cameron Gayle", :team=>"West Brom"}, {:name=>"Donervon Daniels", :team=>"West Brom"}, {:name=>"Winston Reid", :team=>"West Ham"}, {:name=>"George McCartney", :team=>"West Ham"}, {:name=>"Kevin Nolan", :team=>"West Ham"}, {:name=>"James Tomkins", :team=>"West Ham"}, {:name=>"Matthew Jarvis", :team=>"West Ham"}, {:name=>"Razvan Rat", :team=>"West Ham"}, {:name=>"Andy Carroll", :team=>"West Ham"}, {:name=>"Jack Collison", :team=>"West Ham"}, {:name=>"Modibo Maiga", :team=>"West Ham"}, {:name=>"Ricardo Vaz Te", :team=>"West Ham"}, {:name=>"Adrián", :team=>"West Ham"}, {:name=>"Matthew Taylor", :team=>"West Ham"}, {:name=>"Mark Noble", :team=>"West Ham"}, {:name=>"Joey O'Brien", :team=>"West Ham"}, {:name=>"Alou Diarra", :team=>"West Ham"}, {:name=>"James Collins", :team=>"West Ham"}, {:name=>"Guy Demel", :team=>"West Ham"}, {:name=>"Mohamed Diamé", :team=>"West Ham"}, {:name=>"Jussi Jääskeläinen", :team=>"West Ham"}, {:name=>"Stewart Downing", :team=>"West Ham"}, {:name=>"Stephen Henderson", :team=>"West Ham"}, {:name=>"Joe Cole", :team=>"West Ham"}, {:name=>"Elliot Lee", :team=>"West Ham"}, {:name=>"Pelly Ruddock", :team=>"West Ham"}, {:name=>"Mladen Petric", :team=>"West Ham"}, {:name=>"Ravel Morrison", :team=>"West Ham"}, {:name=>"Raphael Spiegel", :team=>"West Ham"}, {:name=>"Daniel Potts", :team=>"West Ham"}, {:name=>"George Moncur", :team=>"West Ham"}, {:name=>"Sebastian Lletget", :team=>"West Ham"}, {:name=>"Leo Chambers", :team=>"West Ham"}]
    Player.create(players)
  end

  def down
    Player.delete_all
  end
end
