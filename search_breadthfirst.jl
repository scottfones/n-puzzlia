function breadthfirstsearch(goal, puzzle)
    """Perform breadth first search.

    Return solution or nothing.
    """
    # Reset timer
    reset_timer!(to::TimerOutput)
    
    node = newtree(puzzle);

    if node.state == goal
        return node
    end

    frontier = [node];
    reached = [node.state];

    while !isempty(frontier)
        @timeit to "pop" node = popfirst!(frontier);

        @timeit to "expand" states = expand(node.state);
        @timeit to "possibleactions" acts = possibleactions(node.state);

        for (cstate, caction) in zip(states, acts)
            if cstate == goal
                solvnode = addnode(caction, node, cstate);
                printsolve(solvnode)
                return solvnode
            end

            if !in(cstate, reached)
                @timeit to "push" push!(reached, cstate);
                @timeit to "create node" cnode = addnode(caction, node, cstate);
                @timeit to "push" push!(frontier, cnode)
            end
        end
    end

    println("No solutions found.")
    return nothing
end