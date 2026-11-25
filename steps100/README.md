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
I plotted my daily steps for 100 days, from 17 August to 24 November 2026. My average day was about 6,300 steps, with a best of 19,672 on 20 November and a worst of 457 on 1 October. Twenty of the 100 days reached 10,000 steps or more, but 28 days were under 3,000, so my activity is very uneven rather than steady. Weekdays averaged about 6,700 steps and weekends about 5,300, which surprised me because I expected weekends to be more active. I chose steps because my phone records it automatically, so it shows a real pattern of my life that I wouldn't otherwise notice.

## Creativity (SCAMPER)
- **Substitute:** I used a spiral instead of a normal bar or line chart, so 100 days fit in a compact shape.
- **Combine:** each dot combines three things: size and colour for steps, and a ring for weekends.
- **Reverse:** the first day is in the centre and the newest days are on the outside, so the picture grows outwards as time goes on.
- **Modify:** I made one number, steps, show in two ways (size and colour) so big days stand out instantly.


## Run it
Open `Steps100.pde` in Processing and press Run. `data/data.csv` must stay in the `data` folder.
