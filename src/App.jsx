import { useState } from "react";
import "./App.css";
import magic_square_program from "../magic_square/build/main.aleo?raw";
import { AleoWorker } from "./workers/AleoWorker.js";

import GameBoard from "./components/GameBoard";

const aleoWorker = AleoWorker();
function App() {
  const [gridValues, setGridValues] = useState([
      ['1', '8', '3'],
      ['5', '', '7'],
      ['6', '4', '2'],
  ]);

  const [puzzle, setPuzzle] = useState(12);
  const [account, setAccount] = useState(null);
  const [executing, setExecuting] = useState(false);
  const [deploying, setDeploying] = useState(false);

  const generateAccount = async () => {
    const key = await aleoWorker.getPrivateKey();
    setAccount(await key.to_string());
  };

  async function deploy() {
    setDeploying(true);
    try {
      const result = await aleoWorker.deployProgram(magic_square_program);
      console.log("Transaction:")
      console.log("http://localhost:3030/testnet3/transaction/" + result)
      alert("Transaction ID: " + result);
    } catch (e) {
      console.log(e)
      alert("Error with deployment, please check console for details");
    }
    setDeploying(false);
  }

  async function addPuzzle() {
    try {
      const input = puzzle.toString() + "u8";
      console.log("Setting puzzle value to ", input);
      const result = await aleoWorker.execute("magic_square.aleo", "add_puzzle", [input]);
      console.log(result)
    } catch (e) {
      console.log(e)
      alert("Error with deployment, please check console for details");
    }
  }

  async function getPuzzleId(puzzleValue) {
    const input = puzzleValue.toString() + "u8";
    const result = await aleoWorker.executeOffline(magic_square_program, "get_puzzle_id", [input]);
    return result[0];
  }

  async function addSolution() {
    
    let puzzleId = await getPuzzleId(gridValues[1][1]);
    const goal = gridValues[1][1].toString() + "u8";
    let solutionStr = `{r1c1: ${gridValues[0][0].toString()}u8, r1c2: ${gridValues[0][1].toString()}u8, r1c3: ${gridValues[0][2].toString()}u8, r2c1: ${gridValues[1][0].toString()}u8, r2c3: ${gridValues[1][2].toString()}u8, r3c1: ${gridValues[2][0].toString()}u8, r3c2: ${gridValues[2][1].toString()}u8, r3c3: ${gridValues[2][2].toString()}u8}`;

    try {
      const result = await aleoWorker.execute("magic_square.aleo", "add_solution", [puzzleId, goal, solutionStr]);
      console.log(result)
    } catch (e) {
      console.log(e)
      alert("Error with deployment, please check console for details");
    }
  }

  return (
    <>
      <h2>Magic Square</h2>
      <div className="deploy-area">
        <button onClick={deploy}>Deploy</button>
      </div>

      <div className="puzzle-area">
        <input className="input-puzzle" type="number" value={puzzle} onChange={(e) => setPuzzle(e.target.value)}/>
        <button onClick={addPuzzle}>Add Puzzle</button>
      </div>

      <GameBoard gridValues={gridValues} setGridValues={setGridValues} />
      
      <button className="solution-btn" onClick={addSolution}>Add Solution</button>
    </>
  );
}

export default App;
