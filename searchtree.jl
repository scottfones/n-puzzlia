struct TreeNode
    """Node for search trees"""
    action::Tuple
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

function newtree(action, state)
    """Create initial node for new tree."""
    newnode = TreeNode(
        action,
        nothing,
        0,
        state
    );

    return newnode
end