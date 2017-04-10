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
                  type: 'physical',
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

  action_template :drain, :health, :from, 1,
                  type: 'magic',
                  message: 'SELF drains health from TARGET',
                  modifiers: [
                    {
                      type: 'Nullify',
                      percent: 30,
                      message: 'but it fails.'
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

def report_health(characters)
  GameLogger.info("")
  GameLogger.info(characters.collect { |c| "#{c}: #{c.get(:health)}" })
  GameLogger.info("")
end

characters = ['Alice', 'Bob', 'Charlie'].collect do |name|
  Character.new(name)
end

characters[1].add_action(
  :"big attack", :health, :decrease, 4, type: 'physical',
  message: 'SELF launches a huge attack on TARGET',
  modifiers: [
    {
      type: 'Nullify', percent: 50, message: "but he can't be bothered"
    }
  ]
)

characters[1].modify_action(:attack, {
  type: 'Nullify', percent: 10, message: "but he can't be bothered"
})


characters[2].add_action(
  :heal, :health, :increase, 2, type: 'magic',
  message: 'SELF heals TARGET',
  modifiers: [
    {
      type: 'Nullify', percent: 30, message: "but it didn't work"
    }
  ]
)

turn = 1
until characters.count(&:alive?) <= 1
  character = characters[0]
  GameLogger.info("Turn: #{turn += 1} - #{Character.name}")

  target = characters[1]

  action = character.actions[rand(character.actions.length)]
  if action == :heal
    character.action(action, character)
  else
    character.action(action, target)
  end

  characters.delete(target) if target.dead?
  report_health(characters)
  characters.rotate!
end

GameLogger.info("#{characters[0].name} won")