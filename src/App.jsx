import { useState } from "react";
import reactLogo from "./assets/react.svg";
import aleoLogo from "./assets/aleo.svg";
import "./App.css";
import magic_square_program from "../magic_square/build/main.aleo?raw";
import { AleoWorker } from "./workers/AleoWorker.js";

import GameBoard from "./components/GameBoard";

const aleoWorker = AleoWorker();
function App() {
  const [count, setCount] = useState(0);
  const [account, setAccount] = useState(null);
  const [executing, setExecuting] = useState(false);
  const [deploying, setDeploying] = useState(false);

  const generateAccount = async () => {
    const key = await aleoWorker.getPrivateKey();
    setAccount(await key.to_string());
  };

  async function execute() {
    setExecuting(true);
    const result = await aleoWorker.localProgramExecution(
      helloworld_program,
      "main",
      ["5u32", "5u32"],
    );
    setExecuting(false);

    alert(JSON.stringify(result));
  }

  async function deploy() {
    setDeploying(true);
    try {
      const result = await aleoWorker.deployProgram(magic_square_program);
      console.log("Transaction:")
      console.log("https://explorer.hamp.app/transaction?id=" + result)
      alert("Transaction ID: " + result);
    } catch (e) {
      console.log(e)
      alert("Error with deployment, please check console for details");
    }
    setDeploying(false);
  }

  return (
    <>
      <button onClick={deploy}>Deploy</button>
      <GameBoard />
    </>
  );
}

export default App;
