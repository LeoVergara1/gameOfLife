require './Organism'

RSpec.describe "Any" do
	before(:example) do
		@organism =  Organism.new(3)
	end

	it """organism in The universe of the Game of Life is an
		   infinite two-dimensional orthogonal grid
		   of square cells""" do
		expect( @organism ).to_not be_nil
		expect( @organism.cells ).to match_array([[1, 0, 1],
																							[1, 1, 1],
																							[1, 1, 1]])
		expect( @organism.cells.size ).to eq(3)
		expect( @organism.cells.first.size ).to eq(3)
	end

	it """cells of which is in one of two possible states,
				alive or dead """ do
		result = @organism.cells.flatten.all?{|cell| (cell==1 || cell==0)}
		expect(result).to be true
	end

	it """Every cell interacts with its eight neighbours""" do
    p "Hola"
    @organism.set_cells([[1, 0, 1],[1, 1, 1],[5, 9, 1]])
		expect( @organism.get_neighbors(0,0).size).to eq(8)
    expect( @organism.get_neighbors(1,1) ).to eq([1, 0, 1, 1, 1, 5, 9, 1])
    expect( @organism.get_neighbors(2,0) ).to eq([1, 1, 1, 1, 9, 1, 1, 0])
    expect( @organism.get_neighbors(1,2) ).to eq([0, 1, 1, 1, 1, 9, 1, 5])
    expect( @organism.get_neighbors(2,2) ).to eq([1, 1, 1, 9, 5, 0, 1, 1])
    @organism.set_cells([[1,2,3,4],[5,6,7,8],[9,10,11,12],[13,14,15,16]])
    expect( @organism.get_neighbors(2,2) ).to eq([6, 7, 8, 10, 12, 14, 15, 16])
    expect( @organism.get_neighbors(3,3) ).to eq([11, 12, 9, 15, 13, 3, 4, 1])

    #expect( @organism.get_neighbors(0,0) ).to eq([1,1,1,1,0,1,1,1])
    #expect( @organism.get_neighbors(2,2) ).to eq([1,1,1,1,1,0,1,1])
	end

  it """ Every cell interacts with its eight neighbours, until the last columns in the last row""" do
		expect( @organism.get_neighbors(0,2)).to eq([1,1,1,0,1,1,1,1])
    expect( @organism.get_neighbors(2,0)).to eq([1,1,1,1,1,1,1,0])
    expect( @organism.get_neighbors(2,1)).to eq([1,1,1,1,1,1,0,1])
    expect( @organism.get_neighbors(1,2)).to eq([0,1,1,1,1,1,1,1])
  end

  it"""Any live cell with fewer than two live neighbours dies, as if caused
       by underpopulation. """ do
  @organism.set_cells(
              [[0, 0, 1],
						  [0, 1, 0],
							[0, 0, 0]])
   p "*"*100
   p "Aqui"
   expect( @organism.prepare_to_evolution(1,1)).to eq(0)
   expect( @organism.prepare_to_evolution(1,2)).to eq(1)
   expect( @organism.prepare_to_evolution(2,2)).to eq(1)
   p "*"*100

     @organism.set_cells(
             [[0, 0, 1, 0],
						  [0, 1, 0, 0],
							[0, 0, 0, 0],
              [0, 1, 0, 0]])
   expect( @organism.prepare_to_evolution(1,3)).to eq(0)

  end

  it"""Any live cell with two or three live neighbours
        lives on to the next generation. """ do
  @organism.set_cells([[0,0,1],
                       [0,1,0],
                       [0,0,1]])
    expect(@organism.prepare_to_evolution(1,1)).to eq(1)
   @organism.set_cells([[1,0,1],
                       [0,1,0],
                       [0,0,1]])
    expect(@organism.prepare_to_evolution(1,1)).to eq(1)
  end

  it"""Any live cell with more than three live neighbours
      dies, as if by overpopulation. """ do
  @organism.set_cells([[1,1,1],
                       [0,1,0],
                       [0,0,1]])
    expect(@organism.prepare_to_evolution(1,1)).to eq(0)
  end

  it"""Any dead cell with exactly three live neighbours becomes
    a live cell, as if by reproduction. """ do
    @organism.set_cells([[0,0,1],
                        [0,1,0],
                        [0,0,1]])
    expect(@organism.prepare_to_evolution(1,2)).to eq(1)
    @organism.set_cells([[0,0,1],
                        [0,1,0],
                        [0,1,0]])
    expect(@organism.prepare_to_evolution(0,0)).to eq(1)
    expect(@organism.prepare_to_evolution(0,1)).to eq(1)
    expect(@organism.prepare_to_evolution(0,2)).to eq(1)
    expect(@organism.prepare_to_evolution(1,0)).to eq(1)
    expect(@organism.prepare_to_evolution(1,1)).to eq(1)
    expect(@organism.prepare_to_evolution(1,2)).to eq(1)
    expect(@organism.prepare_to_evolution(2,0)).to eq(1)
    expect(@organism.prepare_to_evolution(2,1)).to eq(1)
    expect(@organism.prepare_to_evolution(2,2)).to eq(1)
  end

  it """Evolve the organism """ do
    @organism.set_cells([[0,0,1],
                         [0,1,0],
                         [0,1,0]])
    expect(@organism.pokevolution.flatten).to eq([1,1,1,1,1,1,1,1,1])
  end
end
