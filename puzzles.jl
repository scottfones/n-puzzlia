puzzle0 = Matrix{Int8}([3 1 2; 7 0 5; 4 6 8]);
puzzle1 = Matrix{Int8}([7 2 4; 5 0 6; 8 3 1]);
puzzle2 = Matrix{Int8}([6 7 3; 1 5 2; 4 0 8]);
puzzle3 = Matrix{Int8}([0 8 6; 4 1 3; 7 2 5]);
puzzle4 = Matrix{Int8}([7 3 4; 2 5 1; 6 8 0]);
puzzle5 = Matrix{Int8}([1 3 8; 4 7 5; 6 0 2]);
puzzle6 = Matrix{Int8}([8 7 6; 5 4 3; 2 1 0]);

allpuzzle8s = Array{Matrix{Int8}, 1}([puzzle0, puzzle1, puzzle2, puzzle3,
                                      puzzle4, puzzle5, puzzle6]);

function testpuzzle8sums()
    for (i, puzzle) in enumerate(allpuzzle8s)
        println("puzzle-$(i-1): sum(puzzle) == sum(1:8):  $(sum(puzzle) == sum(1:8))");
    end
end