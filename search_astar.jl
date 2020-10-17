using DataStructures;

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

function heurmanhattanconflict(goal, state)
    h = heurmanhattan(goal, state);

    sidelen = size(goal)[1];
    for i in 1:sidelen

        # Row Check
        inrow = intersect(goal[i,:], state[i,:]);
        if 0 in inrow
            setdiff!(inrow, [0]);
        end

        if length(inrow) > 1
            roword = [];
            for el in inrow
                rn = findfirst(isequal(el), state)[2]
                push!(roword, rn)
            end

            rowpen = 0
            for a in 1:(length(roword)-1)
                for b in 2:length(roword)
                    if roword[b] < roword[a]
                        rowpen += 2;
                    end
                end
            end
            h += rowpen;
        end

        # Column Check
        incol = intersect(goal[:,i], state[:,i]);
        if 0 in incol
            setdiff!(incol, [0]);
        end

        if length(incol) > 1
            colord = [];
            for el in incol
                rm = findfirst(isequal(el), state)[1]
                push!(colord, rm)
            end

            colpen = 0
            for a in 1:(length(colord)-1)
                for b in 2:length(colord)
                    if colord[b] < colord[a]
                        colpen += 2;
                    end
                end
            end
            h += colpen;
        end           
    end

    return h
end

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