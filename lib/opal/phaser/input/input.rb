require 'opal/phaser/input/keyboard'
require 'opal/phaser/input/pointer'
require 'opal/phaser/core/signal'

module Phaser
  class Input
    include Native

    alias_native :x
    alias_native :y

    alias_native :keyboard,       :keyboard,      as: Keyboard
    alias_native :mouse_pointer,  :mousePointer,  as: Pointer

    def on(type, &block)
      if block_given?
        case type.to_sym
        when :down
          `#@native.onDown.add(#{block.to_n})`
        when :up
          `#@native.onUp.add(#{block.to_n})`
        when :tap
          `#@native.onTap.add(#{block.to_n})`
        when :hold
          `#@native.onHold.add(#{block.to_n})`
        else
          raise ArgumentError, "Unrecognized event type #{type}"
        end
      else
        Signal.new
      end
    end
    alias_native :active_pointer, :activePointer
  end
end
