# 100 Days of Steps

A Processing sketch (#CreativeCoding, Dear Data 100) that draws my daily step count for 100 days, 17 August to 24 November 2026, as a spiral of dots.

## Data
- **What:** the number of steps I took each day.
- **Source:** the Health app on my iPhone, which records steps automatically in the background. I copied the daily totals by hand from Health > Browse > Activity > Steps > Show All Data into `data/data.csv`.
- **Observations:** 100 consecutive days (17 Aug to 24 Nov 2026). Columns: `date`, `weekday`, `steps`.
- **Note:** this is data my phone recorded over time. On days I didn't carry my phone the total will be low, and I have left those days as they are.

## How the data maps to the visual
- Each day is a dot, and the days spiral outward from the centre (first day) to the edge (last day).
- Dot size and colour show steps: small blue = few steps, large gold = many steps.
- A ring around a dot means it was a weekend.
- Hover over a dot to read the date and the step count. Press `s` to save an image.

## The code
- **Class:** `Day` holds the date, weekday, steps, position, size and colour of one day, and draws itself with `display()`. The sketch makes 100 `Day` objects, one per row of the CSV, and stores them in an `ArrayList`.
- **Methods that return values:**
  - `diameterFor(int steps)` takes steps in, rescales them with `map()` and returns a `float` dot size.
  - `colourFor(int steps)` takes steps in and returns a `color` between blue and gold.
  - `isHovered()` and `isWeekend()` inside `Day` return `boolean` values.

## What it shows


## Creativity (SCAMPER)



## Run it
Open `Steps100.pde` in Processing and press Run. `data/data.csv` must stay in the `data` folder.
