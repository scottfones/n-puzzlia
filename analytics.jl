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
puzzle4 = getpuzzle8(4);
puzzle5 = getpuzzle8(5);
puzzle6 = getpuzzle8(6);

Profile.init(delay=.000001)
@profile astarsearch(goal, heurmanhattan, puzzle0);
@profile breadthfirstsearch(goal, puzzle0);
@profile iterativedfs(goal, puzzle0);
Profile.clear()


# 7.1
idfs = @benchmark iterativedfs($goal, $puzzle0);
bfs = @benchmark breadthfirstsearch($goal, $puzzle0);
astar = @benchmark astarsearch($goal, $heurmanhattan, $puzzle0)
open("profiles/puzzle0_all.txt", "w") do s
    tmd = @timed iterativedfs(goal, puzzle0);
    println(s, "IDFS:");
    println(s, "Counted Expand Calls: $(tmd[1][1])\n");
    println(s, "@profile:");
    @profile iterativedfs(goal, puzzle0);
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
    Profile.clear()
    println(s, "\n@timed:");
    println(s, "time: $(tmd.time)s, alloc: $(tmd.bytes)");
    println(s, "\n@benchmark:");
    println(s, "runs: $(length(idfs.times)), median time: $(median(idfs.times)), memory: $(idfs.memory)\n\n");

    tmd = @timed breadthfirstsearch(goal, puzzle0);
    println(s, "BFS:");
    println(s, "Counted Expand Calls: $(tmd[1][1])\n");
    println(s, "@profile:");
    @profile breadthfirstsearch(goal, puzzle0);
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
    Profile.clear()
    println(s, "\n@timed:");
    println(s, "time: $(tmd.time)s, alloc: $(tmd.bytes)");
    println(s, "\n@benchmark:");
    println(s, "runs: $(length(bfs.times)), median time: $(median(bfs.times)), memory: $(bfs.memory)\n\n");

    tmd = @timed astarsearch(goal, heurmanhattan, puzzle0);
    println(s, "A-STAR With Manhattan Distance:");
    println(s, "Counted Expand Calls: $(tmd[1][1])\n");
    println(s, "@profile:");
    @profile astarsearch(goal, heurmanhattan, puzzle0);
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
    Profile.clear()
    println(s, "\n@timed:");
    println(s, "time: $(tmd.time)s, alloc: $(tmd.bytes)");
    println(s, "\n@benchmark:");
    println(s, "runs: $(length(astar.times)), median time: $(median(astar.times)), memory: $(astar.memory)");
end


# 7.2
open("profiles/puzzle2_astarheurs.txt", "w") do s
    tmd = @timed astarsearch(goal, heurmanhattan, puzzle2);
    println(s, "A-STAR With Manhattan Distance:");
    println(s, "Counted Expand Calls: $(tmd[1][1])\n");
    println(s, "@profile:");
    @profile astarsearch(goal, heurmanhattan, puzzle2);
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
    Profile.clear()
    println(s, "\n@timed:");
    println(s, "time: $(tmd.time)s, alloc: $(tmd.bytes)");

    tmd = @timed astarsearch(goal, heurmisplaced, puzzle2);
    println(s, "A-STAR With Misplaced Tiles:");
    println(s, "Counted Expand Calls: $(tmd[1][1])\n");
    println(s, "@profile:");
    @profile astarsearch(goal, heurmisplaced, puzzle2);
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
    Profile.clear()
    println(s, "\n@timed:");
    println(s, "time: $(tmd.time)s, alloc: $(tmd.bytes)");
end


# 7.3
@profile soln = astarsearch(goal, heurmanhattan, puzzle2);
open("profiles/astar2.txt", "w") do s
    println(s, "Counted Expand Calls: $(soln[1][1])\nProfile Output:");
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
end
Profile.clear()

@profile soln = astarsearch(goal, heurmanhattan, puzzle3);
open("profiles/astar3.txt", "w") do s
    println(s, "Counted Expand Calls: $(soln[1][1])\nProfile Output:");
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
end
Profile.clear()

@profile soln = astarsearch(goal, heurmanhattan, puzzle4);
open("profiles/astar4.txt", "w") do s
    println(s, "Counted Expand Calls: $(soln[1][1])\nProfile Output:");
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
end
Profile.clear()

@profile soln = astarsearch(goal, heurmanhattan, puzzle5);
open("profiles/astar5.txt", "w") do s
    println(s, "Counted Expand Calls: $(soln[1][1])\nProfile Output:");
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
end
Profile.clear()

@profile soln = astarsearch(goal, heurmanhattan, puzzle6);
open("profiles/astar6.txt", "w") do s
    println(s, "Counted Expand Calls: $(soln[1][1])\nProfile Output:");
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
end
Profile.clear()

@profile soln = breadthfirstsearch(goal, puzzle2);
open("profiles/breadth2.txt", "w") do s
    println(s, "Counted Expand Calls: $(soln[1][1])\nProfile Output:");
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
end
Profile.clear()

@profile soln = breadthfirstsearch(goal, puzzle3);
open("profiles/breadth3.txt", "w") do s
    println(s, "Counted Expand Calls: $(soln[1][1])\nProfile Output:");
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
end
Profile.clear()

@profile soln = breadthfirstsearch(goal, puzzle4);
open("profiles/breadth4.txt", "w") do s
    println(s, "Counted Expand Calls: $(soln[1][1])\nProfile Output:");
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
end
Profile.clear()

@profile soln = breadthfirstsearch(goal, puzzle5);
open("profiles/breadth5.txt", "w") do s
    println(s, "Counted Expand Calls: $(soln[1][1])\nProfile Output:");
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
end
Profile.clear()

@profile soln = breadthfirstsearch(goal, puzzle6);
open("profiles/breadth6.txt", "w") do s
    println(s, "Counted Expand Calls: $(soln[1][1])\nProfile Output:");
    Profile.print(IOContext(s, :displaysize => (1000, 500)), format=:flat)
end
Profile.clear()

@show idfs;
@show bfs;
@show astar;

