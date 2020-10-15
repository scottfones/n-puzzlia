struct TreeNode
    """Node for search trees"""
    action::Union{Tuple, Nothing}
    parent::Union{TreeNode, Nothing}
    pathcost::Integer
    state::Matrix
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