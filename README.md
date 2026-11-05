Premier League 2025/26: the first 30 matches as dots
A Processing sketch (#CreativeCoding) that visualises the first 30 Premier League matches of the 2025/26 season (15 to 31 August 2025). This is an early version for the Week 5 progress check-in.
Data
Source: football-data.co.uk - manually entereds
Observations: 30 matches (the first 30 of the season, in date order).
Columns used: date, teams, goals, shots, shots on target, corners, fouls, yellow and red cards, result.
How the data maps to the visual
x position: match order
y position: total shots in the match
dot size: total goals
dot colour: result (teal = home win, amber = draw, magenta = away win)
red ring: at least one red card in the match
white line: rolling 10-match average of total shots
hover a dot for the match details; press `s` to save an image
The method 
`float radiusFor(int goals)` takes in the number of goals in a match as an `int`, rescales it to a pixel size (5 to 30) using `map()` and `constrain()`, and returns a `float` that the sketch uses as the dot's diameter. The sketch has two more methods that return values: `rollingAverage()` and `colourFor()`.
What it shows so far
Of the first 30 matches, 15 were home wins, 9 were away wins and 6 were draws, so home advantage shows up early. Home teams scored 1.43 goals a match on average against 1.17 for away teams. Only 3 matches had a red card. I chose football because I follow it and wanted to see whether home advantage appears in real data. I plan to extend this to 100 or more matches later.
might be updated to follow the full premier league 25/26 season 
