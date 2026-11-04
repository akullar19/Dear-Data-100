// Premier League 2025/26 - the first 30 matches, each as a dot
// Data: football-data.co.uk (E0.csv), first 30 matches of the season, trimmed to the columns used here.
//
// x      = match order through the season (August -> May)
// y      = total shots in the match (both teams)
// size   = total goals in the match
// colour = result (teal = home win, amber = draw, magenta = away win)
// red ring = at least one red card
// white line = rolling average of shots over 10 matches
// Hover over a dot to see the match. Press 's' to save a PNG.

Table table;
int n;
float[] px, py, diam;
String[] label;
boolean[] redCard;
color[] col;
float[] shotsTotal;

color HOME_WIN = color(0, 210, 175);
color DRAW     = color(255, 190, 60);
color AWAY_WIN = color(235, 70, 160);

void setup() {
  size(1200, 800);
  table = loadTable("data.csv", "header");
  n = table.getRowCount();

  px = new float[n];
  py = new float[n];
  diam = new float[n];
  label = new String[n];
  redCard = new boolean[n];
  col = new color[n];
  shotsTotal = new float[n];

  float minShots = 1000;
  float maxShots = 0;
  for (int i = 0; i < n; i++) {
    TableRow r = table.getRow(i);
    shotsTotal[i] = r.getInt("home_shots") + r.getInt("away_shots");
    minShots = min(minShots, shotsTotal[i]);
    maxShots = max(maxShots, shotsTotal[i]);
  }

  for (int i = 0; i < n; i++) {
    TableRow r = table.getRow(i);
    int goals = r.getInt("home_goals") + r.getInt("away_goals");
    px[i] = map(i, 0, n - 1, 70, width - 40);
    py[i] = map(shotsTotal[i], minShots, maxShots, height - 110, 140);
    diam[i] = radiusFor(goals);
    redCard[i] = (r.getInt("home_red") + r.getInt("away_red")) > 0;
    col[i] = colourFor(r.getString("result"));
    label[i] = r.getString("date") + "  " + r.getString("home") + " "
      + r.getInt("home_goals") + "-" + r.getInt("away_goals") + " " + r.getString("away");
  }
}

void draw() {
  background(18, 18, 28);

  // title
  fill(255);
  textSize(26);
  textAlign(LEFT, TOP);
  text("First " + n + " Premier League matches, 2025/26", 70, 30);
  fill(180);
  textSize(14);
  text("height = total shots   |   size = total goals   |   red ring = a red card", 70, 66);

  // dots
  for (int i = 0; i < n; i++) {
    noStroke();
    fill(col[i], 150);
    ellipse(px[i], py[i], diam[i], diam[i]);
    if (redCard[i]) {
      noFill();
      stroke(255, 60, 60);
      strokeWeight(1.5);
      ellipse(px[i], py[i], diam[i] + 6, diam[i] + 6);
    }
  }

  // rolling average line
  noFill();
  stroke(255, 220);
  strokeWeight(2);
  beginShape();
  for (int i = 0; i < n; i++) {
    float avg = rollingAverage(i, 10);
    float y = map(avg, 10, 40, height - 110, 140);
    vertex(px[i], y);
  }
  endShape();

  drawLegend();
  drawTooltip();
}

// Method that RETURNS a value: converts a match's total goals into a dot diameter.
// Takes in an int (goals), rescales it to pixels and returns a float.
float radiusFor(int goals) {
  return map(constrain(goals, 0, 8), 0, 8, 5, 30);
}

// Method that RETURNS a value: average total shots over the previous w matches.
float rollingAverage(int index, int w) {
  float sum = 0;
  int count = 0;
  for (int j = max(0, index - w + 1); j <= index; j++) {
    sum += shotsTotal[j];
    count++;
  }
  return sum / count;
}

// Method that RETURNS a value: picks the colour for a result code (H, D or A).
color colourFor(String result) {
  if (result.equals("H")) return HOME_WIN;
  if (result.equals("A")) return AWAY_WIN;
  return DRAW;
}

void drawLegend() {
  float x = 70;
  float y = height - 60;
  noStroke();
  textSize(14);
  textAlign(LEFT, CENTER);
  fill(HOME_WIN); ellipse(x, y, 14, 14);
  fill(220); text("Home win", x + 14, y);
  fill(DRAW); ellipse(x + 120, y, 14, 14);
  fill(220); text("Draw", x + 134, y);
  fill(AWAY_WIN); ellipse(x + 210, y, 14, 14);
  fill(220); text("Away win", x + 224, y);
  stroke(255); strokeWeight(2);
  line(x + 340, y, x + 370, y);
  noStroke();
  fill(220); text("10-match average shots", x + 380, y);
  fill(140);
  text(label[0].substring(0, 10), 70, height - 25);
  textAlign(RIGHT, CENTER);
  text(label[n - 1].substring(0, 10), width - 40, height - 25);
}

void drawTooltip() {
  int best = -1;
  float bestD = 12;
  for (int i = 0; i < n; i++) {
    float d = dist(mouseX, mouseY, px[i], py[i]);
    if (d < bestD) {
      bestD = d;
      best = i;
    }
  }
  if (best >= 0) {
    textSize(14);
    textAlign(LEFT, CENTER);
    float w = textWidth(label[best]) + 20;
    float bx = constrain(mouseX + 15, 10, width - w - 10);
    float by = constrain(mouseY - 30, 10, height - 40);
    fill(0, 220);
    stroke(255, 100);
    strokeWeight(1);
    rect(bx, by, w, 28, 6);
    fill(255);
    noStroke();
    text(label[best], bx + 10, by + 14);
  }
}

void keyPressed() {
  if (key == 's') saveFrame("premier-league-####.png");
}
