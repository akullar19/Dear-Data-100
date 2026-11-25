// 100 Days of Steps - Dear Data 100
// Data: daily step totals recorded by the Health app on my iPhone, 17 Aug - 24 Nov 2026 (100 days).
//
// Every day is a Day object. The days spiral outward from the centre (17 Aug) to the edge (24 Nov).
//   size   = steps that day
//   colour = steps that day (cool blue = few, warm gold = many)
//   ring   = weekend
// Hover over a dot to read the day. Press 's' to save a PNG.

Table table;
ArrayList<Day> days = new ArrayList<Day>();
int minSteps;
int maxSteps;

void setup() {
  size(900, 900);
  table = loadTable("data.csv", "header");

  // first pass: find the smallest and largest day so the mapping is relative to my own data
  minSteps = 1000000;
  maxSteps = 0;
  for (TableRow r : table.rows()) {
    int s = r.getInt("steps");
    minSteps = min(minSteps, s);
    maxSteps = max(maxSteps, s);
  }

  // second pass: create one Day object per row
  int i = 0;
  for (TableRow r : table.rows()) {
    days.add(new Day(i, r.getString("date"), r.getString("weekday"), r.getInt("steps")));
    i++;
  }
}

void draw() {
  background(16, 16, 28);

  // title
  fill(255);
  textSize(26);
  textAlign(LEFT, TOP);
  text("100 days of steps", 40, 30);
  fill(170);
  textSize(14);
  text(days.get(0).date + "  to  " + days.get(days.size() - 1).date, 40, 66);

  // draw every Day object
  for (Day d : days) {
    d.display();
  }

  drawLegend();
  drawTooltip();
}

// Method that RETURNS a value: turns a day's steps into a dot diameter.
// Takes in an int (steps), rescales it between my fewest and most steps, and returns a float.
float diameterFor(int steps) {
  return map(steps, minSteps, maxSteps, 6, 34);
}

// Method that RETURNS a value: turns a day's steps into a colour from cool blue to warm gold.
color colourFor(int steps) {
  float t = map(steps, minSteps, maxSteps, 0, 1);
  return lerpColor(color(70, 130, 255), color(255, 200, 60), t);
}

// The class: one Day object holds everything about a single day and knows how to draw itself.
class Day {
  int index;       // 0 = first day, 99 = last day
  String date;
  String weekday;
  int steps;
  float x, y;      // position on the spiral
  float diam;      // dot size
  color col;       // dot colour

  Day(int index, String date, String weekday, int steps) {
    this.index = index;
    this.date = date;
    this.weekday = weekday;
    this.steps = steps;

    float angle = index * 0.55 - HALF_PI;
    float radius = 30 + index * 3.4;
    this.x = width / 2 + cos(angle) * radius;
    this.y = height / 2 + sin(angle) * radius;
    this.diam = diameterFor(steps);
    this.col = colourFor(steps);
  }

  boolean isWeekend() {
    return weekday.equals("Sat") || weekday.equals("Sun");
  }

  boolean isHovered() {
    return dist(mouseX, mouseY, x, y) < max(diam / 2, 8);
  }

  void display() {
    noStroke();
    fill(col, 210);
    ellipse(x, y, diam, diam);
    if (isWeekend()) {
      noFill();
      stroke(255, 150);
      strokeWeight(1.2);
      ellipse(x, y, diam + 6, diam + 6);
    }
  }

  String label() {
    return weekday + " " + date + "   " + nfc(steps) + " steps";
  }
}

void drawLegend() {
  float x = 40;
  float y = height - 70;
  textSize(14);
  textAlign(LEFT, CENTER);
  noStroke();
  fill(colourFor(minSteps)); ellipse(x, y, diameterFor(minSteps), diameterFor(minSteps));
  fill(210); text(nfc(minSteps) + " steps", x + 24, y);
  fill(colourFor(maxSteps)); ellipse(x + 170, y, diameterFor(maxSteps), diameterFor(maxSteps));
  fill(210); text(nfc(maxSteps) + " steps", x + 204, y);
  noFill();
  stroke(255, 150);
  strokeWeight(1.2);
  ellipse(x + 360, y, 16, 16);
  noStroke();
  fill(210); text("ring = weekend", x + 378, y);
  fill(140);
  text("centre = first day, edge = last day", x, y + 34);
}

void drawTooltip() {
  for (Day d : days) {
    if (d.isHovered()) {
      String s = d.label();
      textSize(14);
      textAlign(LEFT, CENTER);
      float w = textWidth(s) + 20;
      float bx = constrain(mouseX + 15, 10, width - w - 10);
      float by = constrain(mouseY - 30, 10, height - 40);
      fill(0, 225);
      stroke(255, 100);
      strokeWeight(1);
      rect(bx, by, w, 28, 6);
      fill(255);
      noStroke();
      text(s, bx + 10, by + 14);
      break;
    }
  }
}

void keyPressed() {
  if (key == 's') saveFrame("steps-####.png");
}
