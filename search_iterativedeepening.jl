function dlsexpand(node, puzzle)
    """Expand a given puzzle into next-step child nodes."""
    @timeit to "possibleactions" actions = possibleactions(puzzle);
    @timeit to "expand" res = expand(puzzle)

    childrn = []
    for (a, r) in zip(actions, res)
        @timeit to "create node" newnode = addnode(a, node, r);
        @timeit to "push" push!(childrn, newnode);
    end

    return childrn
end

function depthlimitedsearch(depth, goal, puzzle)
    """Perform depth first search up to the input depth.

    Returns solution or nothing.
    """
    reset_timer!(to::TimerOutput)

    frontier = [newtree(puzzle)];

    while !isempty(frontier)
        @timeit to "pop" node = pop!(frontier);

        if node.state == goal
            return node
        end

        # Use pathcost as depth
        if node.pathcost > depth
            continue;
        
        elseif !iscycle(node, 3)
            childrn = dlsexpand(node, node.state);
            for chld in childrn
                @timeit to "push" push!(frontier, chld);
            end
        end
    end

    return nothing
end

function iterativedfs(goal, puzzle; initdepth=1, limit=100, step=1, prnt="all")
    """Perform iterative depth first search.

    Optionally takes iteration and output options.
    """
    searchrange = initdepth:step:limit;
    for d in searchrange
        @timeit to "depth limited search" solnode = depthlimitedsearch(d, goal, puzzle)

        if !isnothing(solnode)
            if prnt == "actions"
                printactions(solnode[2])
            else
                printsolve(solnode[2])
            end
            return solnode
        end
    end
    
    println("No solutions found within depth limit. (limit=$limit)")
    return nothing    
end
