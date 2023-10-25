// The 'magic_square' program.
program magic_square.aleo {
    
    // State
    // Public
    mapping puzzles: u64 => u8;
    mapping scores: address => u64;

    // Data Structure
    struct Board {
        r1c1: u8,
        r1c2: u8,
        r1c3: u8,
        r2c1: u8,
        r2c3: u8,
        r3c1: u8,
        r3c2: u8,
        r3c3: u8
    }

    record Token {
        owner: address,
        amount: u64
    }

    record Solution {
        owner: address,
        solution: Board
    }

    transition add_puzzle(public goal: u8) {
        assert_eq(self.caller, aleo1fu0k2qfytzs5fhesgfgjuax6wsh9xx4ftpdapnhzrtruy0tx3urqx3p0ut);
        // assert(goal >= 12u8 && goal <= 15u8);
        return then finalize(goal);
    }

    finalize add_puzzle(goal: u8) {
        assert(goal >= 12u8 && goal <= 15u8);
        
        // Calculate mapping key from the goal
        let key: u64 = BHP256::hash_to_u64(goal);
        // Set the key, goal in the puzzles mapping
        Mapping::set(puzzles, key, goal);
    }

    transition get_puzzle_id(goal: u8) -> u64 {
        let key: u64 = BHP256::hash_to_u64(goal);
        return key;
    }

    function check_unique(solution: Board) {
        assert_neq(solution.r1c1, solution.r1c2);
        assert_neq(solution.r1c1, solution.r1c3);
        assert_neq(solution.r1c1, solution.r2c1);
        assert_neq(solution.r1c1, solution.r2c3);
        assert_neq(solution.r1c1, solution.r3c1);
        assert_neq(solution.r1c1, solution.r3c2);
        assert_neq(solution.r1c1, solution.r3c3);
        assert_neq(solution.r1c2, solution.r1c3);
        assert_neq(solution.r1c2, solution.r2c1);
        assert_neq(solution.r1c2, solution.r2c3);
        assert_neq(solution.r1c2, solution.r3c1);
        assert_neq(solution.r1c2, solution.r3c2);
        assert_neq(solution.r1c2, solution.r3c3);
        assert_neq(solution.r1c3, solution.r2c1);
        assert_neq(solution.r1c3, solution.r2c3);
        assert_neq(solution.r1c3, solution.r3c1);
        assert_neq(solution.r1c3, solution.r3c2);
        assert_neq(solution.r1c3, solution.r3c3);
        assert_neq(solution.r2c1, solution.r2c3);
        assert_neq(solution.r2c1, solution.r3c1);
        assert_neq(solution.r2c1, solution.r3c2);
        assert_neq(solution.r2c1, solution.r3c3);
        assert_neq(solution.r2c3, solution.r3c1);
        assert_neq(solution.r2c3, solution.r3c2);
        assert_neq(solution.r2c3, solution.r3c3);
        assert_neq(solution.r3c1, solution.r3c2);
        assert_neq(solution.r3c1, solution.r3c3);
        assert_neq(solution.r3c2, solution.r3c3);
    }

    function check_range(solution: Board) {
        assert(solution.r1c1 < 9u8);
        assert(solution.r1c1 > 0u8);
        assert(solution.r1c2 < 9u8);
        assert(solution.r1c2 > 0u8);
        assert(solution.r1c3 < 9u8);
        assert(solution.r1c3 > 0u8);
        assert(solution.r2c1 < 9u8);
        assert(solution.r2c1 > 0u8);
        assert(solution.r2c3 < 9u8);
        assert(solution.r2c3 > 0u8);
        assert(solution.r3c1 < 9u8);
        assert(solution.r3c1 > 0u8);
        assert(solution.r3c2 < 9u8);
        assert(solution.r3c2 > 0u8);
        assert(solution.r3c3 < 9u8);
        assert(solution.r3c3 > 0u8);
    }

    function check_correctness(solution: Board, goal: u8) {
        assert_eq(solution.r1c1 + solution.r1c2 + solution.r1c3, goal);    
        assert_eq(solution.r3c1 + solution.r3c2 + solution.r3c3, goal);    
        assert_eq(solution.r1c1 + solution.r2c1 + solution.r3c1, goal);    
        assert_eq(solution.r1c3 + solution.r2c3 + solution.r3c3, goal);
    }

    transition add_solution(puzzle_id: u64, goal: u8, solution: Board) -> (Token, Solution) {
        // Checks if the solution is correct
        check_correctness(solution, goal);
        
        // Check if solution is unique
        check_unique(solution);

        // Check range
        check_range(solution);

        let token: Token = Token {
            owner: self.caller,
            amount: 100u64
        };

        let solution_record: Solution = Solution {
            owner: self.caller,
            solution: solution
        };

        return (token, solution_record) then finalize(puzzle_id, goal, self.caller);    
    }

    finalize add_solution(puzzle_id: u64, goal: u8, caller: address) {
        // Use get_or_use first
        // Get the goal from the mapping
        let exists: bool = Mapping::contains(puzzles, puzzle_id);
        assert(exists);
        let goal_from_mapping: u8 = Mapping::get(puzzles, puzzle_id);
        assert_eq(goal, goal_from_mapping);
        
        // Increase score of player
        let initial_score: u64 = Mapping::get_or_use(scores, caller, 0u64);
        Mapping::set(scores, caller, initial_score + 1u64);
    }
}
