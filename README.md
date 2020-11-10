# n-puzzlia
Solving n-puzzle problems with different algorithms in Julia.

Answers to 7.1, 7.2, 7.3 and solutions to *puzzle-0* and *puzzle-1* are located in "Assignment_Reports"

Set-up and Run:
	Install Julia: https://julialang.org/downloads/

	On Command Line/Terminal, change directory into the project

	Enter "julia" to start Julia's REPL

	Hit the "]" key to enter Julia's package manager
		Enter "add DataStructures,TimerOutputs"

	After package installation, hit "Backspace" to exit the package manager
		You should now be back at the initial REPL prompt

	Load all code with "include("init.jl")"

	Example Commands:
		# Appending a semi-colon at the end of commands will suppress output

		
		# Get the first 8-puzzle and store in variable p1
		# All 8-puzzles can be accessed in a similar way
		p1 = getpuzzle8(1)
		         or
		p1 = getpuzzle8("puzzle-0")


		# Assign the goal puzzle
		goal = getpuzzle8("goal")
		         or
		goal = getpuzzle8(-1)


		# Perform Iterative Deepening Search on puzzle-0
		goal = getpuzzle8("goal")
		p0 = getpuzzle8(0)
		iterativedfs(goal, p0);
		         or
		iterativedfs(getpuzzle8("goal"), getpuzzle8(0));


		# Perform Breadth First Search on puzzle-0
		goal = getpuzzle8("goal")
		p0 = getpuzzle8(0)
		breadthfirstsearch(goal, p0);
                         or
		breadthfirstsearch(getpuzzle8("goal"), getpuzzle8(0));


		# Perform A* Search with Misplaced Tiles Heuristic on 8-puzzle 0
		goal = getpuzzle8("goal")
		p0 = getpuzzle8(0)
		astarsearch(goal, heurmisplaced, p0);	
                         or
                astarsearch(getpuzzle8("goal"), heurmisplaced, getpuzzle8(0));

		
		# Perform A* Search with Manhattan Distance Heuristic on 8-puzzle 0
		goal = getpuzzle8("goal")
		p0 = getpuzzle8(0)
		astarsearch(goal, heurmanhattan, p0);
                         or
                astarsearch(getpuzzle8("goal"), heurmanhattan, getpuzzle8(0));


		# Perform A* Search with Manhattan Distance with Linear Conflict Heuristic on 8-puzzle 0
		goal = getpuzzle8("goal")
		p0 = getpuzzle8(0)
		astarsearch(goal, heurmanhattanconflict, p0);
                         or
		astarsearch(getpuzzle8("goal"), heurmanhattanconflict, getpuzzle8(0));
		

	Note: Julia uses a "just ahead of time" (fancy JIT) compiler. Code is compiled on the first execution.
	      If benchmarking, repeat the command twice to remove the compilation overhead.
		
