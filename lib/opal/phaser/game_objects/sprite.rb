require 'opal/phaser/physics/physics'
require 'opal/phaser/core/anchor'
require 'opal/phaser/animation/animation_manager'
require 'opal/phaser/game_objects/events'

module Phaser
  class Sprite < PIXI::Sprite
    include Native

    alias_native :key
    alias_native :bounce

    alias_native :play
    alias_native :crop

    alias_native :exists=
    alias_native :alive=
    alias_native :frame=
    alias_native :smoothed=

    alias_native :right

    alias_native :kill

    def input_enabled=(bool)
      `#@native.inputEnabled = bool`
    end

    def frame_name=(name)
      `#@native.frameName = name`
    end

    def auto_cull=(bool)
      `#@native.autoCull = bool`
    end

    def check_world_bounds=(bool)
      `#@native.checkWorldBounds = bool`
    end

    def update_crop
      `#@native.updateCrop()`
    end

    alias_native :load_texture, :loadTexture

    alias_native :body,       :body,       as: Physics::Arcade::Body
    alias_native :animations, :animations, as: AnimationManager
    alias_native :events,     :events,     as: Events

    def on(type, context, &block)
      events.on(type, context, &block)
    end

    alias_native :add_child, :addChild
    native_accessor :angle
    native_accessor :frame
    native_accessor :name
    native_accessor_alias :fixed_to_camera, :fixedToCamera
    native_accessor :key
  end
end
