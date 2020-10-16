using DataStructures;
include("specfuncs.jl")
include("searchtree.jl")

function heurmanhattan(node, goal)
    g = node.pathcost;
    m,n = size(node.state);

    h = 0;
    for row in 1:m
        for col in 1:n
            val = 3*(row-1)+col;
            cord = findfirst(isequal(val-1), node.state);
            hm = abs(cord[1] - row);
            hn = abs(cord[2] - col);
            h += hm + hn;
        end
    end

    return g + h    
end


function heurmisplaced(node, goal)
    g = node.pathcost;
    h = length(intersect(node.state, goal));

    return g+h
end

function astarsearch(goal, heur, puzzle)
    """Perform A* search using an input heuristic function.

    Return solution or nothing.
    """
    node = newtree(puzzle);
    frontier = PriorityQueue{TreeNode, Integer}()
    frontier[node] = 0;
    basecamp = [];
    
    while !isempty(frontier)
        node = dequeue!(frontier);
        push!(basecamp, node.state);

        acts = possibleactions(node.state);
        states = expand(node.state);

        for (a, s) in zip(acts, states)
            if in(basecamp, s)
                continue;
            end

            cnode = addnode(a, node, s)
            score = heur(cnode, goal);

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
end