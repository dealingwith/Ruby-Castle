Making a text-based Ruby game. Inspired by [this exercise in Learn Ruby...](https://learnrubythehardway.org/book/ex36.html)

---

The castle game is based on a classic BASIC game from the 80's. It displays a grid and allows a player to move N, S, E, or W and then interact with what the player finds in that grid square.

I can't find the original BASIC game anymore. There was a different, more popular 2D real-time adventure game called Castle that I can find all over the web, but not the one I'm trying to emulate.

The grid is something like this 8x8:

```
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . A
```

A being "Adventurer" or whatever

As the Adventurer moves around the grid fills in with what they have discovered...

```
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . . .
. . . . . . C .
. . . . . . E O
. . . . . . . E
```

Each object in the castle has a letter or token associated with it, e.g. C for Chest, O for Ogre, E for Empty, S for Stairs (which allow the player to move to another level).

Soon I'll need to develop what all the possible room contents can be, and even contents of those contents (drops from a defeated moster, contents of a chest). But for now I just want to create the levels and randomly populate them with some chars.

**TODO**

- ☑️ Randomly generate a single level grid with random contents "a" through "z"
- Create 8 levels and store them
- Create the various things that can go into a level room
- Randomly populate the levels' rooms (remember empty rooms)
- Add the Adventurer
- Hide the rooms the Adventurer hasn't moved into yet
- Show the rooms the Adventurer has gone through already
- Allow the player to move through a level

---

Part 2

- Add a stair room and allow player to change levels
- Create interactions for each thing
- Add properties to the Adventurer (e.g. hit points, weapons)
- Did the Adventurer start with a wooden sword in the original?