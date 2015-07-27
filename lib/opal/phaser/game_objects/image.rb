require 'opal/phaser/core/anchor'
module Phaser
  class Image
    include Native

    alias_native :x
    alias_native :y
    alias_native :x=
    alias_native :y=
    alias_native :height
    alias_native :width
    alias_native :input
    alias_native :name

    alias_native :scale
    alias_native :destroy

    alias_native :visible=
    alias_native :kill

    alias_native :load_texture, :loadTexture
    alias_native :anchor,     :anchor,     as: Anchor

    def smoothed=(bool)
      `#@native.smoothed = bool`
    end

    def crop(rect)
      `#@native.crop(#{rect.to_n})`
    end
  end
end