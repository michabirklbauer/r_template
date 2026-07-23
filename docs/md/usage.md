# Usage

You can use the example R script/code provided in this template as outlined
below.

```text
Usage: run.R [-h] [-s] -f FILE [-a CHARACTER_1] [-b CHARACTER_2] [-p HEALTH]
Battles two characters.

Options:
        -h, --help
                Show this help message and exit

        -s, --shiny
                Run the script as a Shiny application

        -f FILE, --file=FILE
                Character file to read characters from (str)

        -a CHARACTER_1, --character-1=CHARACTER_1
                Index of the first character to use (int) [default 1]

        -b CHARACTER_2, --character-2=CHARACTER_2
                Index of the second character to use (int) [default 2]

        -p HEALTH, --hit-points=HEALTH
                Health of all characters (int) [default 130]

v1.0.0 (c) Micha Birklbauer, 2026
```

## Table of Contents

[[toc]]

## Script

You can run the script like this:

```bash
Rscript run.R -f data/characters.csv -p 200
```
::: tip Output
```text
INFO  [16:00:30.966] ---------- BATTLE START ----------
INFO  [16:00:31.008] Both characters have 200 hit points! The battle begins:
INFO  [16:00:31.020] Character Shadowheart has initiative!
INFO  [16:00:31.028] Character Shadowheart deals 320.903619494289 damage!
INFO  [16:00:31.035] Character Shadowheart won!
INFO  [16:00:31.042] ----------- BATTLE END -----------
INFO  [16:00:31.048] Script finished with exit code 0.
```
:::

## Shiny

To run the [Shiny](https://shiny.posit.co/) web app simply use the following command:

```bash
Rscript run.R -s
```

## R

Here are a few examples how you can directly use the code in R:

### Running the Script from R

```r
source("lib/main.R")
main(c("-f", "data/characters.csv"))
```
::: tip Output
```r
INFO  [16:06:02.119] ---------- BATTLE START ----------
INFO  [16:06:02.210] Both characters have 130 hit points! The battle begins:
INFO  [16:06:02.223] Character Shadowheart has initiative!
INFO  [16:06:02.231] Character Shadowheart deals 74.1384301558137 damage!
INFO  [16:06:02.246] Character Astarion deals 149.032246284187 damage!
INFO  [16:06:02.261] Character Astarion won!
INFO  [16:06:02.276] ----------- BATTLE END -----------
INFO  [16:06:02.290] Script finished with exit code 0.
[1] 0
```
:::

### Creating a Character

```r
source("lib/main.R")

jb <- Character$new(name="John Baldur")
jb
```
::: tip Output
```r
<Character>
  Public:
    attack: function ()
    avg_damage: active binding
    copy_with_update: function (update = list())
    initialize: function (name, race = NULL, min_damage = 0, max_damage = 0)
    max_damage: active binding
    min_damage: active binding
    name: active binding
    plot: function ()
    race: active binding
  Private:
    .avg_damage: 0
    .max_damage: 0
    .min_damage: 0
    .name: John Baldur
    .race: NULL
```
:::

### Reading Characters from a File

```r
source("lib/main.R")

characters <- character_factory("data/characters.csv")
characters
```
::: tip Output
```r
$`1`
<Character>
  Public:
    attack: function ()
    avg_damage: active binding
    copy_with_update: function (update = list())
    initialize: function (name, race = NULL, min_damage = 0, max_damage = 0)
    max_damage: active binding
    min_damage: active binding
    name: active binding
    plot: function ()
    race: active binding
  Private:
    .avg_damage: 120
    .max_damage: 200
    .min_damage: 40
    .name: Astarion
    .race: Elf

$`2`
<Character>
  Public:
    attack: function ()
    avg_damage: active binding
    copy_with_update: function (update = list())
    initialize: function (name, race = NULL, min_damage = 0, max_damage = 0)
    max_damage: active binding
    min_damage: active binding
    name: active binding
    plot: function ()
    race: active binding
  Private:
    .avg_damage: 216
    .max_damage: 400
    .min_damage: 32
    .name: Shadowheart
    .race: Half-Elf
```
:::

### Battle Two Characters

```r
source("lib/main.R")

characters <- character_factory("data/characters.csv")
winner <- battle(
  character_1 = characters[[1]],
  character_2 = characters[[2]],
  health = 200
)
```
::: tip Output
```r
INFO  [16:13:00.566] ---------- BATTLE START ----------
INFO  [16:13:00.581] Both characters have 200 hit points! The battle begins:
INFO  [16:13:00.590] Character Shadowheart has initiative!
INFO  [16:13:00.602] Character Shadowheart deals 99.9007865972817 damage!
INFO  [16:13:00.610] Character Astarion deals 53.5126914456487 damage!
INFO  [16:13:00.621] Character Shadowheart deals 133.388333775103 damage!
INFO  [16:13:00.652] Character Shadowheart won!
INFO  [16:13:00.668] ----------- BATTLE END -----------
```
:::

## Implementation Details

The `Character` class is implemented to make it
[Pydantic](https://pydantic.dev/docs/validation/latest/get-started/)-like, e.g.
all attributes are validated upon initialization and then locked (quasi immutable).

Consider this `Character`:

```r
source("lib/main.R")

jb <- Character$new(name="John Baldur")
jb
```
::: tip Output
```r
<Character>
  Public:
    attack: function ()
    avg_damage: active binding
    copy_with_update: function (update = list())
    initialize: function (name, race = NULL, min_damage = 0, max_damage = 0)
    max_damage: active binding
    min_damage: active binding
    name: active binding
    plot: function ()
    race: active binding
  Private:
    .avg_damage: 0
    .max_damage: 0
    .min_damage: 0
    .name: John Baldur
    .race: NULL
```
:::

The following will not work and raise an error:

```r
jb$race <- "Human"
```
::: danger Error
```r
Error in (function ()  : unused argument (base::quote("Human"))
```
:::

Instead one can create a modified copy of the `Character` instance:

```r
jb2 <- jb$copy_with_update(list(race="Human"))
jb2
```
::: tip Output
```r
<Character>
  Public:
    attack: function ()
    avg_damage: active binding
    copy_with_update: function (update = list())
    initialize: function (name, race = NULL, min_damage = 0, max_damage = 0)
    max_damage: active binding
    min_damage: active binding
    name: active binding
    plot: function ()
    race: active binding
  Private:
    .avg_damage: 0
    .max_damage: 0
    .min_damage: 0
    .name: John Baldur
    .race: Human
```
:::

Of course our original `jb` stayed the same:

```r
jb
```
::: tip Output
```r
<Character>
  Public:
    attack: function ()
    avg_damage: active binding
    copy_with_update: function (update = list())
    initialize: function (name, race = NULL, min_damage = 0, max_damage = 0)
    max_damage: active binding
    min_damage: active binding
    name: active binding
    plot: function ()
    race: active binding
  Private:
    .avg_damage: 0
    .max_damage: 0
    .min_damage: 0
    .name: John Baldur
    .race: NULL
```
:::
