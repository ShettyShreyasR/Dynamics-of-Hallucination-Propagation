# Dynamics of Hallucination Propagation in Multi-Agent LLM Collaboration

## 📝 Overview
This project investigates the dynamics of hallucination propagation and self-correction within a **50-node multi-agent network**. By utilizing **Erdős-Rényi random graphs**, we demonstrate how network topology influences multi-round discussions among architecturally diverse LLM agents. 

To solve the "infinite regress of trust" found in automated LLM evaluation, this system integrates a **Solidity smart contract-based audit and reputation system**. This blockchain infrastructure provides tamper-resistant, penalty-weighted accountability for each agent based on immutable on-chain data recorded on a local Ethereum test chain.

## 🛡️ Key Features
* **Architectural Heterogeneity**: Employs **Llama 3.2 (3B)**, **Qwen 2.5 (7B)**, and **Mistral (7B)** to ensure diverse failure modes and study peer-to-peer correction.
* **Topological Analysis**: Tests three edge probabilities ($p=0.03, 0.07, 0.12$) to quantify how connectivity governs factual convergence.
* **Blockchain Accountability**: Implements a `HallucinationAudit.sol` contract to log every response and apply fixed penalties for hallucinations.
* **Quantitative Benchmarks**: Tracks system alignment through **Shannon Entropy (H)** decay and Normal Distribution analysis.

## 🛠️ Technical Stack
* **Platform**: Google Colab with GPU acceleration.
* **Inference**: Ollama API serving local open-weight models.
* **Graph Theory**: NetworkX for topology generation and giant component extraction.
* **Blockchain**: Solidity 0.8.20, Web3.py, and EthereumTesterProvider.
* **Visualization**: Matplotlib for heatmaps and entropy decay curves.

## 💻 How to Run
### 1. Environment Setup
* Ensure you have a T4 GPU (or better) enabled in your Colab environment.
* Install Ollama and the required Python libraries:
    ```bash
    !pip install networkx matplotlib web3 py-solc-x
    ```

### 2. Execution Pipeline
1.  **Initialize Nodes**: Fifty stateful agents are instantiated with balanced model assignments.
2.  **Generate Topology**: Random graphs are constructed, and isolated nodes are removed to ensure a giant component.
3.  **Run Discussion**: Start the 50-round synthesis process where agents merge neighbor responses.
4.  **Audit & Penalty**: Manually annotate the results in the generated CSV and run the orchestration script to commit records to the blockchain.

## 📊 Experimental Results
* **Convergence**: A sharp decline in entropy is observed by Round 15, indicating a powerful alignment mechanism.
* **Topological Pressure**: Denser networks ($p=0.12$) yielded the lowest hallucination rate (27.30%) and highest mean reputation (72.70).
* **Consensus Drift**: Late-round volatility (Rounds 35-50) suggests that cumulative iterations can introduce minor stochastic fluctuations.

## 👥 Contributors
This research was a collaborative effort with equal contributions (16.67% each) across all project phases:

* **Shreyas R. Shetty**
* **Alan Jacob**
* **Apoorv Mani**
* **Chris George**
* **Ramya Varunsegar**
* **Shreya Patil**

