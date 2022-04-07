require 'dxopal'
include 
Image.register(:eraser, 'lib/images/eraser.png')
Image.register(:pen,    'lib/images/pen.png'   )
Image.register(:reset,  'lib/images/reset.png' )

def init
  Window.height, Window.width = 1000, 1000
  Window.bgcolor = C_WHITE
  $pen_statue = :marker
  $pen_size   = 30
  $pen_color  = C_BLACK
end
Window.fps = 1560
def draw_line
  Window.draw(0,                 0, Image.new(Window.width, 3, C_BLACK))
  Window.draw(0, Window.height - 3, Image.new(Window.width, 3, C_BLACK))
  Window.draw(0,                 0, Image.new(3, Window.height, C_BLACK))
  Window.draw(Window.width - 3,  0, Image.new(3, Window.height, C_BLACK))
end

class Pallet
  def initialize
    @pallet_color = [192, 192, 192]
    @circle_image = Image.new(150, 150).circle_fill(75, 75, 75, @pallet_color)
    @page_statue = :default
  end

  def draw(mouse, canvas)
    if Input.key_down?(K_LSHIFT) || Input.key_down?(K_SPACE)

      case @page_statue
      when :default
        color = Sprite.new(Window.width / 2 - 260, Window.height / 2 - 100, @circle_image)
        size  = Sprite.new(Window.width / 2 - 75 , Window.height / 2 - 100, @circle_image)
        paint = Sprite.new(Window.width / 2 + 105, Window.height / 2 - 100, @circle_image)
        reset = Sprite.new(0 , 0, Image[:reset])
        color.draw
        size.draw
        paint.draw
        reset.draw
        draw_illustration

        if Input.mouse_push?(M_LBUTTON)

          @page_statue = :color if color === mouse
          @page_statue = :size  if size  === mouse
          @page_statue = :reset if reset === mouse

          if paint === mouse
            if $pen_statue == :marker
              $pen_statue = :eraser
            elsif $pen_statue == :eraser
              $pen_statue = :marker
            end
          end
        end

      when :color
        red     = Sprite.new(100, 300, @circle_image)
        blue    = Sprite.new(300, 300, @circle_image)
        green   = Sprite.new(500, 300, @circle_image)
        yellow  = Sprite.new(700, 300, @circle_image)
        cyan    = Sprite.new(100, 500, @circle_image)
        magenta = Sprite.new(300, 500, @circle_image)
        white   = Sprite.new(500, 500, @circle_image)
        black   = Sprite.new(700, 500, @circle_image)
        red.draw
        blue.draw
        green.draw
        yellow.draw
        cyan.draw
        magenta.draw
        white.draw
        black.draw
        if Input.mouse_push?(M_LBUTTON)
          $pen_color = C_RED     if mouse === red
          $pen_color = C_BLUE    if mouse === blue
          $pen_color = C_GREEN   if mouse === green
          $pen_color = C_YELLOW  if mouse === yellow
          $pen_color = C_CYAN    if mouse === cyan
          $pen_color = C_MAGENTA if mouse === magenta
          $pen_color = C_WHITE   if mouse === white
          $pen_color = C_BLACK   if mouse === black
          @page_statue = :default
        end
        Window.draw(105, 305, Image.new(140, 140).circle_fill(70, 70, 70, C_RED    ))
        Window.draw(305, 305, Image.new(140, 140).circle_fill(70, 70, 70, C_BLUE   ))
        Window.draw(505, 305, Image.new(140, 140).circle_fill(70, 70, 70, C_GREEN  ))
        Window.draw(705, 305, Image.new(140, 140).circle_fill(70, 70, 70, C_YELLOW ))
        Window.draw(105, 505, Image.new(140, 140).circle_fill(70, 70, 70, C_CYAN   ))
        Window.draw(305, 505, Image.new(140, 140).circle_fill(70, 70, 70, C_MAGENTA))
        Window.draw(505, 505, Image.new(140, 140).circle_fill(70, 70, 70, C_WHITE  ))
        Window.draw(705, 505, Image.new(140, 140).circle_fill(70, 70, 70, C_BLACK  ))

      when :size
        size_10 = Sprite.new(100, 300, @circle_image)
        size_20 = Sprite.new(300, 300, @circle_image)
        size_30 = Sprite.new(500, 300, @circle_image)
        size_40 = Sprite.new(700, 300, @circle_image)
        size_50 = Sprite.new(100, 500, @circle_image)
        size_60 = Sprite.new(300, 500, @circle_image)
        size_70 = Sprite.new(500, 500, @circle_image)
        size_80 = Sprite.new(700, 500, @circle_image)
        size_10.draw
        size_20.draw
        size_30.draw
        size_40.draw
        size_50.draw
        size_60.draw
        size_70.draw
        size_80.draw
        if Input.mouse_push?(M_LBUTTON)
          @page_statue = :default
          $pen_size = 10 if mouse === size_10
          $pen_size = 20 if mouse === size_20
          $pen_size = 30 if mouse === size_30
          $pen_size = 40 if mouse === size_40
          $pen_size = 50 if mouse === size_50
          $pen_size = 60 if mouse === size_60
          $pen_size = 70 if mouse === size_70
          $pen_size = 80 if mouse === size_80
        end
        Window.draw_font(120, 320, '10', Font.new(100))
        Window.draw_font(320, 320, '20', Font.new(100))
        Window.draw_font(520, 320, '30', Font.new(100))
        Window.draw_font(720, 320, '40', Font.new(100))
        Window.draw_font(120, 520, '50', Font.new(100))
        Window.draw_font(320, 520, '60', Font.new(100))
        Window.draw_font(520, 520, '70', Font.new(100))
        Window.draw_font(720, 520, '80', Font.new(100))
      when :reset
        @page_statue = :default
        canvas.initialize
      end
    end

    if Input.key_release?(K_LSHIFT)
      @page_statue = :default
    end

  end

  def draw_illustration
    circle = Image.new(120, 120).circle_fill(60, 60, 60, $pen_color)
    Window.draw(255, 415, circle)
    Window.draw_scale( 35, -170, Image[:eraser], 0.15, 0.15) if $pen_statue == :marker
    Window.draw_scale( 85, -125, Image[:pen],     0.1,  0.1) if $pen_statue == :eraser
    Window.draw( 450, 405, Image.new(100, 100).triangle_fill(0, 100, 100, 40, 100, 100, C_BLACK))
  end
end

class Canvas
  def initialize
    @order_num = 0
    @colors = []
  end
  def update(mouse)
    if Input.mouse_release?(M_LBUTTON)
      @order_num += 1
    end

    if Input.mouse_down?(M_LBUTTON)
      @colors << Sprite.new(mouse.x, mouse.y,mouse.image)
    end
  end
  def draw
    @colors.each do |n|
      n.draw
    end
  end
end

class Mouse < Sprite
  def initialize
    super(0, 0, Image.new(1, 1, C_WHITE))
  end

  def update
    self.x = Input.mouse_pos_x - $pen_size / 2
    self.y = Input.mouse_pos_y - $pen_size / 2
    self.image = Image.new($pen_size, $pen_size).circle_fill($pen_size / 2, $pen_size / 2, $pen_size / 2, $pen_color)
  end
end

Window.load_resources do
  pallet = Pallet.new
  mouse = Mouse.new
  init
  canvas = Canvas.new
  Window.loop do
    draw_line

    if Input.key_down?(K_LSHIFT)
    else
       canvas.update(mouse)
    end 
    canvas.draw
    mouse.update
    pallet.draw(mouse, canvas)
    
    mouse.draw
  end
end
