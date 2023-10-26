import {
  Account,
  ProgramManager,
  PrivateKey,
  initThreadPool,
  AleoKeyProvider,
  AleoNetworkClient,
  NetworkRecordProvider
} from "@aleohq/sdk";
import { expose, proxy } from "comlink";

const ENDPOINT = "http://localhost:3030";
const PRIVATE_KEY = "APrivateKey1zkpHVhTAJiZPrDeVo6nDyvq2LDRhP2ZgECvr8zqtcefpgsc";

await initThreadPool();

async function executeOffline(program, aleoFunction, inputs) {
  const programManager = new ProgramManager();

  // Create a temporary account for the execution of the program
  const account = new Account();
  programManager.setAccount(account);

  const executionResponse = await programManager.executeOffline(
    program,
    aleoFunction,
    inputs,
    false,
  );
  return executionResponse.getOutputs();
}

async function execute(program, aleoFunction, inputs) {
  const programManager = new ProgramManager(ENDPOINT);

  const account = new Account({
    privateKey: PRIVATE_KEY,
  });

  console.log(account);

  programManager.setAccount(account);

  const executionResponse = await programManager.execute(
    program,
    aleoFunction,
    3.0,
    false,
    inputs
  );

  console.log(executionResponse);
  return executionResponse;
}

async function getPrivateKey() {
  const key = new PrivateKey();
  return proxy(key);
}

async function deployProgram(program) {
  const keyProvider = new AleoKeyProvider();
  keyProvider.useCache(true);

  // Create a record provider that will be used to find records and transaction data for Aleo programs
  const networkClient = new AleoNetworkClient(ENDPOINT);

  // Use existing account with funds
  const account = new Account({
    privateKey: PRIVATE_KEY,
  });

  const recordProvider = new NetworkRecordProvider(account, networkClient);

  // Initialize a program manager to talk to the Aleo network with the configured key and record providers
  const programManager = new ProgramManager(
    ENDPOINT,
    keyProvider,
    recordProvider,
  );

  programManager.setAccount(account);

  // Define a fee to pay to deploy the program
  const fee = 6.0;

  // Deploy the program to the Aleo network
  const tx_id = await programManager.deploy(program, fee);

  // Optional: Pass in fee record manually to avoid long scan times
  // const feeRecord = "{  owner: aleo1xxx...xxx.private,  microcredits: 2000000u64.private,  _nonce: 123...789group.public}";
  // const tx_id = await programManager.deploy(program, fee, undefined, feeRecord);

  return tx_id;
}

const workerMethods = { executeOffline, getPrivateKey, deployProgram, execute };
expose(workerMethods);
