class Battle
  ABILITIES = {
    missle: 53,
    drain: 73,
    shield: 113,
    poison: 173,
    recharge: 229
  }

  TURNS = {
    shield: 6,
    poison: 6,
    recharge: 5
  }
  def initialize(mana, hp, boss_hp, damage, hardmode)
    min = 2_000_000
    desc = ''
    @hardmode = true
    1_000_000.times do
      @desc = ''
      @player = {
        mana: mana,
        hp: hp,
        armor: 0
      }
      @boss = {
        hp: boss_hp,
        damage: damage
      }
      @used_mana = 0
      @current_abilities = {}
      result = battle_loop
      if result[:mana] < min && result[:win]
        min = result[:mana]
        desc = @desc
      end
    end
    puts min
    puts desc
  end

  def battle_loop
    player = true
    loop do
      if player
        @desc << "---- PLAYER ----- \n"
        @desc << "Player has #{@player[:hp]} hp, #{@player[:mana]} mana, #{@player[:armor]} armor\n"
        @desc << "Boss has #{@boss[:hp]} hp\n"
        @player[:hp] -= 1 if @hardmode
        use_abilities
        ability = random_ability
        if ability
          cast(ability)
          status = check_status
          if status == :player
            return {
              win: true,
              mana: @used_mana
            }
          elsif status == :boss
            return {
              win: false,
              mana: @used_mana
            }
          end
          player = false
        else
          return {
            win: false,
            mana: @used_mana
          }
        end
      else
        @desc << "---- BOSS ----- \n"
        @desc << "Player has #{@player[:hp]} hp, #{@player[:mana]} mana, #{@player[:armor]} armor\n"
        @desc << "Boss has #{@boss[:hp]} hp\n"
        use_abilities
        status = check_status
        if status == :player
          return {
            win: true,
            mana: @used_mana
          }
        elsif status == :boss
          return {
            win: false,
            mana: @used_mana
          }
        end
        damage = [1, @boss[:damage] - @player[:armor]].max
        @player[:hp] -= damage
        @desc << "Boss deals #{damage} damage. Player hp is #{@player[:hp]}\n"
        status = check_status
        if status == :player
          return {
            win: true,
            mana: @used_mana
          }
        elsif status == :boss
          return {
            win: false,
            mana: @used_mana
          }
        end
        player = true
      end
      @desc << "END\n"
      @desc << "\n"
    end
  end

  def cast(ability)
    @player[:mana] -= ABILITIES[ability]
    @used_mana += ABILITIES[ability]
    case ability
    when :missle
      @boss[:hp] -= 4
      @desc << "Player casts missle. Player mana is #{@player[:mana]}. Boss hp is #{@boss[:hp]}\n"
    when :drain
      @player[:hp] += 2
      @boss[:hp] -= 2
      @desc << "Player casts drain. Player mana is #{@player[:mana]}. Boss hp is #{@boss[:hp]}. Player hp is #{@player[:hp]}\n"
    else
      start_effect(ability)
    end
  end

  def start_effect(ability)
    unless @current_abilities.has_key?(ability)
      @desc << "Player casts #{ability}. Player mana is now #{@player[:mana]}\n"
      @current_abilities[ability] = TURNS[ability]
    end
  end

  def check_status
    if @player[:hp] < 1
      return :boss
    end
    if @boss[:hp] < 1
      return :player
    end
    return nil
  end

  def cast_effect(ability)
    case ability
    when :shield
      @player[:armor] = 7
      @desc << "Armor 7. Now armor is #{@player[:armor]}. Armor timer is #{@current_abilities[ability]-1}\n"
    when :poison
      @boss[:hp] -= 3
      @desc << "Poison deals 3 damage. Boss has #{@boss[:hp]} hp. Poison timer is #{@current_abilities[ability]-1}\n"
    when :recharge
      @player[:mana] += 101
      @desc << "Recharge restores 101 mana. Player has #{@player[:mana]} mana. Recharge timer is #{@current_abilities[ability]-1}\n"
    end
  end

  def use_abilities
    @current_abilities.each do |k, v|
      cast_effect(k)
      @current_abilities[k] -= 1
      @player[:armor] = 0 if k == :shield && v < 2
    end
    @current_abilities = @current_abilities.select {|k, v| v > 0}
  end

  def random_ability
    running = @current_abilities.select { |k,v| v > 0}.keys
    ABILITIES.select {|k, v| (v <= @player[:mana]) && !running.include?(k) }.keys.sample
  end
end

Battle.new(500, 50, 58, 9, true)
