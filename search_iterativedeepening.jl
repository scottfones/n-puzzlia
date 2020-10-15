include("specfuncs.jl")
include("searchtree.jl")

function dlsexpand(node, puzzle)
    """Expand a given puzzle into next-step child nodes."""
    actions = possibleactions(puzzle);

    childrn = []
    for act in actions
        res = result(act, puzzle);
        newnode = addnode(act, node, res);
        push!(childrn, newnode);
    end

    return childrn
end

function depthlimitedsearch(depth, goal, puzzle)
    """Perform depth first search up to the input depth.

    Returns solution or nothing.
    """
    frontier = [newtree(puzzle)];
    solve = nothing;

    while !isempty(frontier)
        node = pop!(frontier);

        if node.state == goal
            return node
        end

        # Use pathcost as depth
        if node.pathcost > depth
            continue;
        
        elseif !iscycle(node, 3)
            childrn = dlsexpand(node, node.state);
            for chld in childrn
                push!(frontier, chld);
            end
        end
    end

    return solve
end

function iterativedfs(goal, puzzle; initdepth=1, limit=100, step=1, prnt="all")
    """Perform iterative depth first search.

    Optionally takes iteration and output options.
    """
    searchrange = initdepth:step:limit;
    for d in searchrange
        solnode = depthlimitedsearch(d, goal, puzzle)

        if !isnothing(solnode)
            if prnt == "actions"
                printactions(solnode)
            else
                printsolve(solnode)
            end
            return nothing
        end
    end
    
    println("No solutions found within depth limit. (limit=$limit)")
    return nothing    
end
