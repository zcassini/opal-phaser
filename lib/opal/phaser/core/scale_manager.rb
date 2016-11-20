module Phaser
  class ScaleManager
    include Native

    # A scale mode that stretches content to fill all available space
    EXACT_FIT = 0;

    # A scale mode that prevents any scaling
    NO_SCALE = 1;

    # A scale mode that shows the entire game while maintaining proportions
    SHOW_ALL = 2;

    # A scale mode that causes the Game size to change
    RESIZE = 3;

    # A scale mode that allows a custom scale factor
    USER_SCALE = 4;

    alias_native :scale_mode, :scaleMode
    alias_native :refresh

    native_accessor_alias :page_align_horizontally, :pageAlignHorizontally
    native_accessor_alias :page_align_vertically, :pageAlignVertically

    def scale_mode=(mode)
      `#@native.scaleMode = #{mode}`
    end
  end
end
