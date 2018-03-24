class Organism
	attr_accessor :cells
  attr_accessor :cells_clone
	def initialize(cells)
		@cells = [[1, 0, 1],[1, 1, 1],[5, 9, 1]]
	end

	def get_neighbors(row, col)
    rowAux = 0
    colAux = 0
    puts "p"*100
    p @cells
    p "#{@cells[2][0]}"
    lower_limit = (@cells.size) - 1
    right_limit = (@cells[0].size) - 1
    p "lower limit: #{lower_limit}"
    p "right limit: #{right_limit}"
    currentPosition = @cells[row][col]
    p currentPosition
    if row == lower_limit and !(col == right_limit)
      p "Estas en el limite bajo"
      rowAux = 7
    elsif col == right_limit and !(row == lower_limit)
      rowAux = 9
      p "Estas em el limite derecho"
    elsif row == lower_limit and col == right_limit
      p "Es la esquina inferior"
    else
      p "Letra valida"
    end
    neighbours = [@cells[row-1][col-1], @cells[row-1][col], @cells[row-1][(col+1)-(colAux)], @cells[row][col-1], @cells[row][(col+1)-(colAux)], @cells[(row+1)-(rowAux)][col-1], @cells[(row+1)-(rowAux)][col], @cells[(row+1)-(rowAux)][(col+1)-(colAux)]]
    #@cells[(row+1)-(rowAux)][col-1], @cells[(row+1)-(rowAux)][col], @cells[(row+1)-(rowAux)][(col+1)-(colAux)
    neighbours
	end

  def set_cells(cells)
    @cells = cells
  end

  def prepare_to_evolution(row, col)
    next_state =(get_neighbors(row, col).count(1) < 2 or get_neighbors(row, col).count(1) > 3) ? 0 :1
    ##p "Next State for #{row}-#{col} is #{next_state}"
    p get_neighbors(row, col)
    next_state
  end

  def pokevolution
  @cells_clone = Array.new(@cells.size,Array.new(@cells[0].size,0))
  @cells.each_with_index do |r,rindex|
    r.each_with_index do |c,cindex|
      next_cell = prepare_to_evolution(rindex,cindex)
      @cells_clone[rindex][cindex] = next_cell
    end
  end
  @cells_clone
  end
end
