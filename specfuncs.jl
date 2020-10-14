
function swaptile!(board, t1, t2)
    """Swap the labels on the board for
       elements at index t1 and t2."""
    tmp = board[t1];
    board[t1] = board[t2];
    board[t2] = tmp;
end

function possibleactions(board)
    """Return list of all possible actions for input board."""
    orthdict = Dict(
        "UP" => (-1, 0), "DOWN" => (1, 0),
        "LEFT" => (0, -1), "RIGHT" => (0, 1)
    );

    zeroindex = findfirst(iszero, board);

    newboards = Matrix[];
    for (key, value) in pairs(orthdict)
        modindex = zeroindex + CartesianIndex(value);
        
        if checkbounds(Bool, board, modindex)
            newboard = copy(board);
            swaptile!(newboard, zeroindex, modindex);
            push!(newboards, newboard);
        end
    end

    return newboards
end
