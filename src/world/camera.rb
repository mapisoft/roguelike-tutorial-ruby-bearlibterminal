module Camera

  global :x,
         :y,
         :dx,
         :dy


  def self.init
    @dirty  = true
    @offset = new_vector
    @target = new_vector
  end


  def self.update
    entity = World.player

    @target.x = entity.position.x - Display.width  * 0.5 + 1
    @target.y = entity.position.y - Display.height * 0.5 + 1

    old_offset_x = @offset.x
    old_offset_y = @offset.y

    @offset.x += (@target.x - @offset.x) * drag
    @offset.y += (@target.y - @offset.y) * drag

    if ( @target.x - @offset.x ).abs <= min_difference
      @offset.x = @target.x
    end

    if ( @target.y - @offset.y ).abs <= min_difference
      @offset.y = @target.y
    end

    @dirty = @force_dirty ||
             @offset.x != old_offset_x ||
             @offset.y != old_offset_y
    @force_dirty = false

    @x  = @target.x.floor
    @y  = @target.y.floor
    @dx = ( @offset.x - @target.x ) * Display.cell_width
    @dy = ( @offset.y - @target.y ) * Display.cell_height
  end


  def self.jump_to x, y
    @offset.x = @target.x = x - Display.width  * 0.5
    @offset.y = @target.y = y - Display.height * 0.5
  end


  def self.set_dirty
    @force_dirty = true
  end


  def self.dirty?
    @dirty
  end


  internal def self.max_target_distance
    0
  end


  internal def self.min_difference
    0.1
  end


  internal def self.drag
    if Display.big?
    then 1
    else 0.5
    end
  end

end
