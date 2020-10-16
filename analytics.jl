include("puzzles.jl");
include("search_astar.jl");
include("search_breadthfirst.jl");
include("search_iterativedeepening.jl")
include("searchtree.jl");
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

idfs = @benchmark iterativedfs($goal, $puzzle0);
bfs = @benchmark breadthfirstsearch($goal, $puzzle0);
astar = @benchmark astarsearch($goal, $heurmanhattan, $puzzle0)

p2misplaced = @benchmark astarsearch($goal, $heurmisplaced, $puzzle2);
p2manhattan = @benchmark astarsearch($goal, $heurmanhattan, $puzzle2);

Profile.init(delay=.000001)

@profile astarsearch(goal, heurmanhattan, puzzle2);
open("astar2.txt", "w") do s
    Profile.print(IOContext(s, :displaysize => (24, 500)), format=:flat)
end
Profile.clear()

@profile astarsearch(goal, heurmanhattan, puzzle3);
open("astar3.txt", "w") do s
    Profile.print(IOContext(s, :displaysize => (24, 500)), format=:flat)
end
Profile.clear()

@profile astarsearch(goal, heurmanhattan, puzzle4);
open("astar4.txt", "w") do s
    Profile.print(IOContext(s, :displaysize => (24, 500)), format=:flat)
end
Profile.clear()

@profile astarsearch(goal, heurmanhattan, puzzle5);
open("astar5.txt", "w") do s
    Profile.print(IOContext(s, :displaysize => (24, 500)), format=:flat)
end
Profile.clear()

@profile astarsearch(goal, heurmanhattan, puzzle6);
open("astar6.txt", "w") do s
    Profile.print(IOContext(s, :displaysize => (24, 500)), format=:flat)
end
Profile.clear()

@profile breadthfirstsearch(goal, puzzle2);
open("breadth2.txt", "w") do s
    Profile.print(IOContext(s, :displaysize => (24, 500)), format=:flat)
end
Profile.clear()

@profile breadthfirstsearch(goal, puzzle3);
open("breadth3.txt", "w") do s
    Profile.print(IOContext(s, :displaysize => (24, 500)), format=:flat)
end
Profile.clear()

@profile breadthfirstsearch(goal, puzzle4);
open("breadth4.txt", "w") do s
    Profile.print(IOContext(s, :displaysize => (24, 500)), format=:flat)
end
Profile.clear()

@profile breadthfirstsearch(goal, puzzle5);
open("breadth5.txt", "w") do s
    Profile.print(IOContext(s, :displaysize => (24, 500)), format=:flat)
end
Profile.clear()

@profile breadthfirstsearch(goal, puzzle6);
open("breadth6.txt", "w") do s
    Profile.print(IOContext(s, :displaysize => (24, 500)), format=:flat)
end
Profile.clear()

@show idfs;
@show bfs;
@show astar;

