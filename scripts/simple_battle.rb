# Combatants: alice, bob and charlie
# their health is 10
# their damage is 2

# Each turn, a character chooses a target and attacks them.
# attacking
# They have a 90% chance to hit (nullify)
# They have a 20% chance of a critical (x 2, multiply)
# defending
# They have a 50% chance to block (half damage, multiply)
# They have a 10% change to dodge (nullify)

require_relative '../lib/environment'

class Character < GameEntity

  has_actions
  changing_attribute :health, initial: 10, maximum: 10

  attr_reader :name
  alias_method :to_s, :name

  action_template :attack, :health, :decrease, 2,
                  message: "SELF attacks TARGET",
                  modifiers: [
                    {
                      type: 'Nullify',
                      percent: 10,
                      message: 'but it missed.'
                    },
                    {
                      type: 'Multiply',
                      percent: 10,
                      multiplier: 2,
                      message: 'Critical hit! Double damage!'
                    }
                  ]

  def initialize(name, attrs={})
    super()
    @name = name
  end

  def dead?
    !alive?
  end

  def alive?
    get(:health) > 0
  end
end

characters = ['Alice', 'Bob', 'Charlie'].collect do |name|
  Character.new(name)
end

characters[1].modify_action(:attack, {type: 'Nullify', percent: 50, message: "but he can't be bothered"})

until characters.count(&:alive?) <= 1
  character = characters[0]
  target = characters[1]

  character.action(:attack, target)

  characters.each { |c| puts "#{c}: #{c.get(:health)}" }

  characters.delete(character) if character.dead?
  characters.rotate!
end

puts "#{characters[0].name} won"
characters.each { |c| puts "#{c}: #{c.get(:health)}" }
