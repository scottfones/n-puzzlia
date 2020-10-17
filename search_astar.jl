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

        # Row Check
        inrow = intersect(goal[i,:], s[i,:]);

        if length(inrow) > 1
            roword = [];
            for el in inrow
                rn = findfirst(isequal(el), s)[2]
                push!(roword, rn)
            end
            # @show s
            # @show roword
            if !issorted(roword)
                f += 2;
            end
        end

        # Row Check
        incol = intersect(goal[:,i], s[:,i]);

        if length(incol) > 1
            colord = [];
            for el in incol
                rm = findfirst(isequal(el), s)[1]
                push!(colord, rm)
            end
            
            if !issorted(colord)
                f += 2;
            end
        end
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
            @timeit to "heuristic score" score = heur(goal, cnode);

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