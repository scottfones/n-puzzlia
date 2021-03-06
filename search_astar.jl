using DataStructures;

"""
    heurmanhattan(goal, state)

Compute the manhattan distance of nonzero tiles in `state` 
with respect to their locations in `goal`.

Return: Heuristic score
"""
function heurmanhattan(goal, state)
    m,n = size(state);

    h = 0;
    for row in 1:m
        for col in 1:n
            if goal[row,col] == 0
                continue;
            end
            cord = findfirst(isequal(goal[row,col]), state);
            hm = abs(cord[1] - row);
            hn = abs(cord[2] - col);
            h += hm + hn;
        end
    end

    return h    
end


"""
    conflictresolution(rowcol, slice, state)

Search for linear conflict elements within a `slice` 
representing the intersection of a row/column of
the goal and puzzle `state`.

rowcol: 2 if searching a row. 1 if searching a column.
        Represents the index element into the `state`

Return: 2 times the conflicts found.
"""
function conflictresolution(rowcol, slice, state)
    if 0 in slice
        setdiff!(slice, [0]);
    end

    # Collect row/col index of elements
    if length(slice) > 1
        sliceord = [];
        for el in slice
            idx = findfirst(isequal(el), state)[rowcol]
            push!(sliceord, idx)
        end

        # Increase score if out of order
        slicescore = 0
        for a in 1:(length(sliceord)-1)
            for b in 2:length(sliceord)
                if sliceord[b] < sliceord[a]
                    slicescore += 2;
                end
            end
        end
        return slicescore
    end
    return 0
end


"""
    heurmanhattanconflict(goal, state)

Supplement the manhattan distance calculation by accounting
for linear conflict.

For every pair of tiles in reverse order in their correct
row or column in `state`, increase the score by 2.

Return: Heuristic score
"""
function heurmanhattanconflict(goal, state)
    h = heurmanhattan(goal, state);

    sidelen = size(goal)[1];
    for i in 1:sidelen
        # Check intersection of goal,puzzle
        # row for shared elements
        inrow = intersect(goal[i,:], state[i,:]);
        h += conflictresolution(2, inrow, state)


        incol = intersect(goal[:,i], state[:,i]);
        h += conflictresolution(1, inrow, state);
    end
    return h
end


"""
    heurmisplaced(goal, state)

Calculate the number of misplaced tiles in `state`
with respect to their location in `goal`.

Return: Heuristic score
"""
function heurmisplaced(goal, state)
    m,n = size(state);
    
    h = 0
    for j in 1:m
        for i in 1:n
            if goal[j,i] == 0
                continue;
            elseif goal[j,i] == state[j,i]
                continue;
            else
                h += 1;
            end
        end
    end

    return h
end


"""
    astarsearch(goal, heur, puzzle)

Perform an a* search of a tree structure initiated with 
`puzzle`. Child states are scored according to heuristic
`heur` and stored in a priority queue until either the
`goal` state is found, or no solution is possible.

Return: TreeNode containing the goal state or nothing.
"""
function astarsearch(goal, heur, puzzle)
    """Perform A* search using an input heuristic function.

    Return solution or nothing.
    """
    # Reset timer
    reset_timer!(to::TimerOutput)

    node = newtree(puzzle);
    frontier = PriorityQueue{TreeNode, Integer}()
    frontier[node] = 0;
    basecamp = [];
    
    while !isempty(frontier)
        @timeit to "dequeue" node = dequeue!(frontier);
        @timeit to "push" push!(basecamp, node.state);

        @timeit to "possibleactions" acts = possibleactions(node.state);
        @timeit to "expand" states = expand(node.state);

        for (a, s) in zip(acts, states)
            if in(basecamp, s)
                continue;
            end

            @timeit to "create node" cnode = addnode(a, node, s);
            @timeit to "heuristic score" score = node.pathcost + heur(goal, cnode.state);

            if s == goal
                printsolve(cnode)
                return cnode
            end

            if !(cnode in keys(frontier))
                frontier[cnode] = score;
            
            elseif frontier[cnode] > score
                frontier[cnode] = score;
            end
        end
    end

    println("No solutions found.")
    return nothing
end