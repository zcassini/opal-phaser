require 'opal'
require 'opal-phaser'
require 'pp'

class Sky
  def initialize(game)
    @sprite_key = 'sky'
    @sprite_url = 'assets/sky.png'
    @game       = game
  end

  def preload
    @game.load.image(@sprite_key, @sprite_url)
  end

  def create
    @game.add.sprite(0, 0, @sprite_key)
  end
end

class Platforms
  def initialize(game)
    @sprite_key = 'ground'
    @sprite_url = 'assets/platform.png'
    @game       = game
  end

  def preload
    @game.load.image(@sprite_key, @sprite_url)
  end

  def create
    @game.physics.startSystem(Phaser::Physics::ARCADE)
    @platforms = Phaser::Group.new(@game)
    @platforms.enable_body = true

    create_ground
    create_ledge(400, 400)
    create_ledge(-150, 250)
  end

  private

  def create_ground
    ground = @platforms.create(0, @game.world.height - 64, @sprite_key)
    ground.scale.setTo(2, 2)
    ground.body.immovable = true
  end

  def create_ledge(x, y)
    ledge = @platforms.create(x, y, @sprite_key)
    ledge.body.immovable = true
  end
end

class Player
  def initialize(game)
    @game = game

    @sprite_key = 'dude'
    @sprite_url = 'assets/dude.png'

    @x = 32
    @y = @game.world.height - 150
  end

  def preload
    @game.load.spritesheet(@sprite_key, @sprite_url)
  end

  def create
    @player = @game.add.sprite(@x, @y, @sprite_key);

    @game.physics.arcade.enable(@player)

    `#@player.body.bounce.y = 0.2`
    `#@player.body.gravity.y = 300`
    `#@player.body.collideWorldBounds = true`

    `#@player.animations.add('left', [0, 1, 2, 3], 10, true)`
    `#@player.animations.add('right', [5, 6, 7, 8], 10, true)`
  end
end

class Game
  def initialize
    run
  end

  def run
    preload
    create_game

    Phaser::Game.new(800, 600, Phaser::AUTO, '', state)
  end

  private

  def preload
    state.preload do |game|
      initialize_entities(game)
      entities_call :preload
    end
  end

  def create_game
    state.create do
      entities_call :create
    end
  end

  def state
    @state ||= Phaser::State.new
  end

  def initialize_entities(game)
    @sky       = Sky.new(game)
    @platforms = Platforms.new(game)
    @player    = Player.new(game)

    @entities ||= [@sky, @platforms, @player]
  end

  def entities_call(method)
    @entities.each { |e| e.send(method) }
  end
end