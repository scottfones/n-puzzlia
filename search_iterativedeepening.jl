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

function printsolve(solvenode)
    while !isnothing(solvenode)
        println("Step $(solvenode.pathcost):")
        println("\t$(solvenode.state[1,:])") 
        println("\t$(solvenode.state[2,:])")
        println("\t$(solvenode.state[3,:])")
        println("\tAction: $(solvenode.action)");
        solvenode = solvenode.parent;
    end
end