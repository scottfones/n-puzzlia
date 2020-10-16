function breadthfirstsearch(goal, puzzle)
    """Perform breadth first search.

    Return solution or nothing.
    """
    node = newtree(puzzle);

    if node.state == goal
        return node
    end

    frontier = [node];
    reached = [node.state];

    while !isempty(frontier)
        node = popfirst!(frontier);

        states = expand(node.state);
        acts = possibleactions(node.state);

        for (cstate, caction) in zip(states, acts)
            if cstate == goal
                solvnode = addnode(caction, node, cstate);
                printsolve(solvnode)
                return solvnode
            end

            if !in(cstate, reached)
                push!(reached, cstate);
                cnode = addnode(caction, node, cstate);
                push!(frontier, cnode)
            end
        end
    end

    println("No solutions found.")
    return nothing
end