function directindex(direction) 
    dirdict = Dict(
        "UP" => (-1, 0), "DOWN" => (1, 0),
        "LEFT" => (0, -1), "RIGHT" => (0, 1)
    );

    return CartesianIndex(dirdict[direction])
end

function swaptile!(b, t1, t2)
    """Swap the labels on the board for
    elements at index t1 and t2.
    """
    tmp = b[t1];
    b[t1] = b[t2];
    b[t2] = tmp;
end

function possibleactions(board)
    """Return list of all possible actions for input board."""
    zeroindex = findfirst(iszero, board);
    invmovedict = Dict(
        "UP" => "DOWN", "DOWN" => "UP",
        "LEFT" => "RIGHT", "RIGHT" => "LEFT"
    );

    possacts = [];
    for direction in ("UP", "DOWN", "LEFT", "RIGHT")
        modindex = zeroindex + directindex(direction)

        if checkbounds(Bool, board, modindex)
            act = (modindex, invmovedict[direction])
            push!(possacts, act);
        end
    end

    return possacts
end

function result(action, board)
    """Applies an action to the board.

    The action should be a tuple in the form
    (index, direction) where index is the index 
    of the piece to be moved, and direction is 
    one of "UP", "DOWN", "LEFT", "RIGHT"
    """
    newboard = copy(board);
    index1 = action[1];
    index2 = index1 + directindex(action[2]);
    swaptile!(newboard, index1, index2)

    return newboard
end

function expand(board)
    """Return all possible next-step states."""
    states = [];
    possacts = possibleactions(board);

    for act in possacts
        push!(states, result(act, board));
    end

    return states
end