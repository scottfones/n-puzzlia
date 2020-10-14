function getpuzzle(puznum::Int8)
    """Return 8-puzzle based on number id."""
    puzzle0 = Matrix{Int8}([3 1 2; 7 0 5; 4 6 8]);
    puzzle1 = Matrix{Int8}([7 2 4; 5 0 6; 8 3 1]);
    puzzle2 = Matrix{Int8}([6 7 3; 1 5 2; 4 0 8]);
    puzzle3 = Matrix{Int8}([0 8 6; 4 1 3; 7 2 5]);
    puzzle4 = Matrix{Int8}([7 3 4; 2 5 1; 6 8 0]);
    puzzle5 = Matrix{Int8}([1 3 8; 4 7 5; 6 0 2]);
    puzzle6 = Matrix{Int8}([8 7 6; 5 4 3; 2 1 0]);
    
    numdict = Dict(
        0 => puzzle0, 1 => puzzle1, 2 => puzzle2, 
        3 => puzzle3, 4 => puzzle4,
        5 => puzzle5, 6 => puzzle6
    );

    return copy(get(numdict, puznum, -1))
end
    
function getpuzzle(puzname::String)
    """Return 8-puzzle based on name id."""
    namedict = Dict(
        "puzzle-0" => 0, "puzzle-1" => 1, 
        "puzzle-2" => 2, "puzzle-3" => 3, 
        "puzzle-4" => 4, "puzzle-5" => 5, 
        "puzzle-6" => 6
    );

    numid = get(namedict, puzname, -1);
    return getpuzzle(numid)
end

function testpuzzle8sums()
    """Test all predefined 8-puzzles for a sum of 36."""
    allpuzzle8s = Array{Matrix{Int8}, 1}([
        puzzle0, puzzle1, puzzle2, puzzle3,
        puzzle4, puzzle5, puzzle6
    ]);
    for (i, puzzle) in enumerate(allpuzzle8s)
        println("puzzle-$(i-1): sum(puzzle) == sum(1:8):  $(sum(puzzle) == sum(1:8))");
    end
end