program magic_square.aleo;

struct Board:
    r1c1 as u8;
    r1c2 as u8;
    r1c3 as u8;
    r2c1 as u8;
    r2c3 as u8;
    r3c1 as u8;
    r3c2 as u8;
    r3c3 as u8;

record Token:
    owner as address.private;
    amount as u64.private;

record Solution:
    owner as address.private;
    solution as Board.private;


mapping puzzles:
	key as u64.public;
	value as u8.public;


mapping scores:
	key as address.public;
	value as u64.public;

function add_puzzle:
    input r0 as u8.public;
    assert.eq self.caller aleo1fu0k2qfytzs5fhesgfgjuax6wsh9xx4ftpdapnhzrtruy0tx3urqx3p0ut;
    async add_puzzle r0 into r1;
    output r1 as magic_square.aleo/add_puzzle.future;

finalize add_puzzle:
    input r0 as u8.public;
    gte r0 12u8 into r1;
    lte r0 15u8 into r2;
    and r1 r2 into r3;
    assert.eq r3 true;
    hash.bhp256 r0 into r4 as u64;
    set r0 into puzzles[r4];


function get_puzzle_id:
    input r0 as u8.private;
    hash.bhp256 r0 into r1 as u64;
    output r1 as u64.private;


closure check_unique:
    input r0 as Board;
    assert.neq r0.r1c1 r0.r1c2;
    assert.neq r0.r1c1 r0.r1c3;
    assert.neq r0.r1c1 r0.r2c1;
    assert.neq r0.r1c1 r0.r2c3;
    assert.neq r0.r1c1 r0.r3c1;
    assert.neq r0.r1c1 r0.r3c2;
    assert.neq r0.r1c1 r0.r3c3;
    assert.neq r0.r1c2 r0.r1c3;
    assert.neq r0.r1c2 r0.r2c1;
    assert.neq r0.r1c2 r0.r2c3;
    assert.neq r0.r1c2 r0.r3c1;
    assert.neq r0.r1c2 r0.r3c2;
    assert.neq r0.r1c2 r0.r3c3;
    assert.neq r0.r1c3 r0.r2c1;
    assert.neq r0.r1c3 r0.r2c3;
    assert.neq r0.r1c3 r0.r3c1;
    assert.neq r0.r1c3 r0.r3c2;
    assert.neq r0.r1c3 r0.r3c3;
    assert.neq r0.r2c1 r0.r2c3;
    assert.neq r0.r2c1 r0.r3c1;
    assert.neq r0.r2c1 r0.r3c2;
    assert.neq r0.r2c1 r0.r3c3;
    assert.neq r0.r2c3 r0.r3c1;
    assert.neq r0.r2c3 r0.r3c2;
    assert.neq r0.r2c3 r0.r3c3;
    assert.neq r0.r3c1 r0.r3c2;
    assert.neq r0.r3c1 r0.r3c3;
    assert.neq r0.r3c2 r0.r3c3;


closure check_range:
    input r0 as Board;
    lt r0.r1c1 9u8 into r1;
    assert.eq r1 true;
    gt r0.r1c1 0u8 into r2;
    assert.eq r2 true;
    lt r0.r1c2 9u8 into r3;
    assert.eq r3 true;
    gt r0.r1c2 0u8 into r4;
    assert.eq r4 true;
    lt r0.r1c3 9u8 into r5;
    assert.eq r5 true;
    gt r0.r1c3 0u8 into r6;
    assert.eq r6 true;
    lt r0.r2c1 9u8 into r7;
    assert.eq r7 true;
    gt r0.r2c1 0u8 into r8;
    assert.eq r8 true;
    lt r0.r2c3 9u8 into r9;
    assert.eq r9 true;
    gt r0.r2c3 0u8 into r10;
    assert.eq r10 true;
    lt r0.r3c1 9u8 into r11;
    assert.eq r11 true;
    gt r0.r3c1 0u8 into r12;
    assert.eq r12 true;
    lt r0.r3c2 9u8 into r13;
    assert.eq r13 true;
    gt r0.r3c2 0u8 into r14;
    assert.eq r14 true;
    lt r0.r3c3 9u8 into r15;
    assert.eq r15 true;
    gt r0.r3c3 0u8 into r16;
    assert.eq r16 true;


closure check_correctness:
    input r0 as Board;
    input r1 as u8;
    add r0.r1c1 r0.r1c2 into r2;
    add r2 r0.r1c3 into r3;
    assert.eq r3 r1;
    add r0.r3c1 r0.r3c2 into r4;
    add r4 r0.r3c3 into r5;
    assert.eq r5 r1;
    add r0.r1c1 r0.r2c1 into r6;
    add r6 r0.r3c1 into r7;
    assert.eq r7 r1;
    add r0.r1c3 r0.r2c3 into r8;
    add r8 r0.r3c3 into r9;
    assert.eq r9 r1;


function add_solution:
    input r0 as u64.private;
    input r1 as u8.private;
    input r2 as Board.private;
    call check_correctness r2 r1;
    call check_unique r2;
    call check_range r2;
    cast self.caller 100u64 into r3 as Token.record;
    cast self.caller r2 into r4 as Solution.record;
    async add_solution r0 r1 self.caller into r5;
    output r3 as Token.record;
    output r4 as Solution.record;
    output r5 as magic_square.aleo/add_solution.future;

finalize add_solution:
    input r0 as u64.public;
    input r1 as u8.public;
    input r2 as address.public;
    contains puzzles[r0] into r3;
    assert.eq r3 true;
    get puzzles[r0] into r4;
    assert.eq r1 r4;
    get.or_use scores[r2] 0u64 into r5;
    add r5 1u64 into r6;
    set r6 into scores[r2];
