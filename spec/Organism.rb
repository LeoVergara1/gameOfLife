class Organism
	attr_accessor :cells
  attr_accessor :cells_clone
	def initialize(cells)
		@cells = [[1, 0, 1],
							[1, 1, 1],
							[1, 1, 1]]
	end

	def get_neighbors(row, col)
    ##if row == (@cells[0].size-1)
      ##[1,1,1,0,1,1,1,1]
    nextcol = 1
    if col == (@cells[0].size -1)
      nextcol = -(@cells[0].size -1)
    end
    nextrow = 1
    if row ==( @cells.size -1)
      nextrow = -(@cells.size -1)
    end
     [ @cells[row-1][col-1],@cells[row-1][col],@cells[row-1][col+nextcol],
       @cells[row][col-1], @cells[row][col+nextcol],
       @cells[row+nextrow][col-1], @cells[row+nextrow][col], @cells[row+nextrow][col+nextcol]]
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
