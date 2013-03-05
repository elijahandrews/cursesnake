class ScoreWindow < Curses::Window

  SCORE_WIDTH = 14
  SCORE_HEIGHT = 4

  attr_accessor :score

  def write_score
    setpos(2,1)
    addstr @score.to_s.rjust(SCORE_WIDTH - 2)
    refresh
  end

  def initialize(top, left)
    super(SCORE_HEIGHT, SCORE_WIDTH, top, left)
    @score = 0
    box '|', '-'
    setpos 1, 1
    addstr 'Score:'
    write_score
  end

end
