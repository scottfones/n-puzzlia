using DataStructures;

function heurmanhattan(goal, node)
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

function heurmanhattanconflict(goal, node)
    f = heurmanhattan(goal, node);

    s = node.state;
    sidelen = size(goal)[1];
    for i in 1:sidelen
        # Elements in the right row or column
        inrow = intersect(goal[i,:], s[i,:]);
        incol = intersect(goal[:,i], s[:,1]);

        # Elements in the correct place
        corrow = sum(goal[i,:] .== s[i,:]);
        corcol = sum(goal[i,:] .== s[i,:]);

        # Elements in the incorrect place
        wrongrow = sidelen - corrow;
        wrongcol = sidelen - corcol;

        # Score Penalization
        f += 2*wrongrow + 2*wrongcol
    end

    return f

end

function heurmisplaced(goal, node)
    g = node.pathcost;

    # Generate truth table and take sum for shared elements
    shareels = sum(goal .== node.state);
    h = length(node.state) - shareels;

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

            cnode = addnode(a, node, s);
            score = heur(goal, cnode);

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