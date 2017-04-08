#Reenginering the RPG

To facilitate a talk on building computer systems and performance
tuning, this code attempts to recreate common components of Role
Playing Games, and other games, in an abstract form.


## Components

* lib/chance.rb - Chance operations, die rolls etc.
* lib/moving_attribute.rb - attributes which are expected to change during the course of the game.
  This can be included then called with e.g. `moving_attribute :health, 5`


