include("puzzles.jl");
include("search_astar.jl");
include("search_breadthfirst.jl");
include("search_iterativedeepening.jl")
include("specfuncs.jl");

using BenchmarkTools;
using Profile;

goal = getpuzzle8("goal");
puzzle0 = getpuzzle8(0);
puzzle1 = getpuzzle8(1);
puzzle2 = getpuzzle8(2);
puzzle3 = getpuzzle8(3);
puzzle5 = getpuzzle8(5);
puzzle6 = getpuzzle8(6);

idfs = @benchmark iterativedfs(goal, puzzle0);
bfs = @benchmark breadthfirstsearch(goal, puzzle0);
astar = @benchmark astarsearch(goal, heurmanhattan, puzzle0)

p2misplaced = @benchmark astarsearch(goal, heurmisplaced, puzzle2);
p2manhattan = @benchmark astarsearch(goal, heurmanhattan, puzzle2);

@show idfs;
@show bfs;
@show astar;

