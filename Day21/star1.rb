require 'pry'
class Star1
  def initialize
    @shop = {}
    @items = []
    read_shop
    read_enemy
    run
  end

  def read_enemy
    vals = []
    File.foreach('input.txt') do |line|
      vals << line.chomp.split(': ').last.to_i
    end
    @hp, @dmg, @armor = vals
  end

  def read_shop
    type = :weapons
    File.foreach('shop.txt') do |line|
      if line.chomp.match(/\d+/)
        name, cost, damage, armor = line.chomp.match(/(.+)\s+(\d+)\s+(\d+)\s+(\d+)/).to_a.last(4)
        item = {
          name: name.strip,
          cost: cost.to_i,
          damage: damage.to_i,
          armor: armor.to_i,
        }
        if @shop.has_key?(type)
          @shop[type] << item
        else
          @shop[type] = [item]
        end
      elsif line.chomp.split(': ').any?
        type = line.chomp.split(': ').first.downcase.to_sym
      end
    end
    insert_fakes
  end

  def insert_fakes
    fake = {
      name: 'fake',
      cost: 0,
      damage: 0,
      armor: 0
    }
    @shop[:armor] << fake
    @shop[:rings] << fake
    @shop[:rings] << fake
  end

  def run
    min = 999_999_999
    max = -1
    @shop[:weapons].each do |w|
      @shop[:armor].each do |a|
        @shop[:rings].each do |r1|
          @shop[:rings].each do |r2|
            next if (r1 == r2) && (r1[:name] != 'fake')
            damage, armor, cost = count_items(w, a, r1, r2)
            if play(damage, armor) && cost < min
              min = cost
              @items = [w, a, r1, r2]
            end
            max = cost if !play(damage, armor) && cost > max
          end
        end
      end
    end
    puts min
    puts max
  end

  def count_items(*args)
    [:damage, :armor, :cost].map do |attr|
      args.map {|item| item[attr]}.inject(:+)
    end
  end

  def play(player_damage, player_armor)
    player_hp = 100
    hp, dmg, armor = @hp, @dmg, @armor
    move = 0
    while (player_hp > 0) && (hp > 0)
      if move == 0
        attack = [(player_damage - armor), 1].max
        hp -= attack
      else
        attack = [(dmg - player_armor), 1].max
        player_hp -= attack
      end
      move = 1 - move
    end

    hp < 1
  end
end

Star1.new
