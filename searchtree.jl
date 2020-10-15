struct TreeNode
    """Node for search trees"""
    action::Union{Tuple, Nothing}
    parent::Union{TreeNode, Nothing}
    pathcost::Integer
    state::Matrix
end

function Base.copy(node::TreeNode)
    TreeNode(
        node.action,
        node.parent,
        node.pathcost,
        node.state
    );
end

function addnode(action, parent, state)
    """Create a new child node wrt the parent."""
    cost = parent.pathcost + 1;
    newnode = TreeNode(
        action, 
        parent, 
        cost, 
        state
    );

    return newnode
end

function newtree(state)
    """Create initial node for new tree."""
    newnode = TreeNode(
        nothing,
        nothing,
        0,
        state
    );

    return newnode
end

function iscycle(node, pnum)
    """Check pnum parents for identical state."""
    count = 0;
    prnt = node;

    while (count < pnum) && !isnothing(prnt.parent)
        count+=1;
        prnt = prnt.parent;

        if node.state == prnt.state
            return true
        end
    end

    return false
end

function printactions(solvenode)
    """Print actions from solution to initial state."""
    while !isnothing(solvenode)
        println("Step $(solvenode.pathcost): Action: $(solvenode.action)");
        solvenode = solvenode.parent;
    end
end

function printsolve(solvenode)
    """Print actions and state from solution to initial state."""
    while !isnothing(solvenode)
        println("Step $(solvenode.pathcost):")
        println("\t$(solvenode.state[1,:])") 
        println("\t$(solvenode.state[2,:])")
        println("\t$(solvenode.state[3,:])")
        println("\tAction: $(solvenode.action)");
        solvenode = solvenode.parent;
    end
end